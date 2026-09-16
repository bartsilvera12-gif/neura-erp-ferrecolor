import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getFacturacionModo } from "@/lib/facturacion/server/facturacion-modo-pg";
import { obtenerSiguienteNumeroFacturaEmpresa } from "@/lib/facturacion/factura-suscripcion-servidor";

/**
 * POST /api/ventas/[id]/emitir-factura
 *
 * Crea RETROACTIVAMENTE el puente venta→factura para una venta que se cerró como
 * TICKET (sin factura). Es el mismo puente que corre al crear la venta cuando el
 * cajero elige "Factura" (ver create-venta-pg.ts), pero para una venta ya existente.
 *
 * Garantías:
 *  - Idempotente: si la venta ya tiene `factura_id`, devuelve esa (no duplica).
 *  - NO toca stock, cobro ni la venta salvo el link `ventas.factura_id`.
 *  - Sólo crea la factura ERP (FAC-XXXXXX) + sus líneas. La emisión SIFEN real
 *    (firma/envío a la SET/KUDE) se hace después desde /facturas/[id].
 *
 * Requiere: empresa en modo 'sifen', venta no anulada, y cliente con razón social.
 */
export async function POST(request: NextRequest, ctxParams: { params: Promise<{ id: string }> }) {
  const { id } = await ctxParams.params;

  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return NextResponse.json({ error: "No autorizado" }, { status: 401 });
  const sb = ctx.supabase;
  const empresaId = ctx.auth.empresa_id;
  const schema = await fetchDataSchemaForEmpresaId(empresaId);

  // La empresa debe estar en modo facturación electrónica.
  const modo = await getFacturacionModo(schema, empresaId);
  if (modo.modo !== "sifen") {
    return NextResponse.json(
      { error: "La empresa no está en modo de facturación electrónica (SIFEN)." },
      { status: 409 }
    );
  }

  // Venta.
  const vQ = await sb
    .from("ventas")
    .select("id, cliente_id, numero_control, tipo_venta, total, moneda, fecha, estado, anulada_at, factura_id")
    .eq("id", id)
    .eq("empresa_id", empresaId)
    .maybeSingle();
  if (vQ.error) return NextResponse.json({ error: vQ.error.message }, { status: 500 });
  const venta = vQ.data as
    | {
        id: string; cliente_id: string | null; numero_control: string; tipo_venta: string | null;
        total: number | string; moneda: string | null; fecha: string; estado: string | null;
        anulada_at: string | null; factura_id: string | null;
      }
    | null;
  if (!venta) return NextResponse.json({ error: "Venta no encontrada." }, { status: 404 });
  if (venta.anulada_at) {
    return NextResponse.json({ error: "La venta está anulada; no se puede facturar." }, { status: 409 });
  }

  // Idempotencia: si ya tiene factura, devolverla sin crear otra.
  if (venta.factura_id) {
    const fx = await sb
      .from("facturas")
      .select("numero_factura")
      .eq("id", venta.factura_id)
      .maybeSingle();
    return NextResponse.json({
      ok: true,
      alreadyExisted: true,
      facturaId: venta.factura_id,
      numeroFactura: (fx.data as { numero_factura?: string } | null)?.numero_factura ?? null,
    });
  }

  // Receptor: la factura ERP exige cliente con razón social (SIFEN necesita receptor).
  if (!venta.cliente_id) {
    return NextResponse.json(
      { error: "La venta no tiene cliente. Asigná un cliente con RUC/CI para poder facturar." },
      { status: 422 }
    );
  }
  const s = (v: string | null | undefined) => (typeof v === "string" && v.trim() ? v.trim() : null);
  const cliQ = await sb
    .from("clientes")
    .select("empresa, nombre, nombre_contacto, nombre_facturacion, ruc")
    .eq("id", venta.cliente_id)
    .eq("empresa_id", empresaId)
    .maybeSingle();
  const c = cliQ.data as Record<string, string | null> | null;
  const razonSocial = c
    ? s(c.nombre_facturacion) || s(c.empresa) || s(c.nombre_contacto) || s(c.nombre)
    : null;
  const rucSnap = c ? s(c.ruc) : null;
  if (!razonSocial) {
    return NextResponse.json(
      { error: "El cliente de la venta no tiene nombre/razón social para facturar." },
      { status: 422 }
    );
  }

  // Ítems de la venta → líneas de factura. Subtotal (base gravada) = total_linea - IVA.
  const iQ = await sb
    .from("ventas_items")
    .select("producto_nombre, cantidad, precio_venta, monto_iva, total_linea, tipo_iva")
    .eq("venta_id", id)
    .eq("empresa_id", empresaId);
  if (iQ.error) return NextResponse.json({ error: iQ.error.message }, { status: 500 });
  const itemsRaw = (iQ.data ?? []) as Array<{
    producto_nombre: string; cantidad: number | string; precio_venta: number | string;
    monto_iva: number | string; total_linea: number | string; tipo_iva: string;
  }>;
  if (itemsRaw.length === 0) {
    return NextResponse.json({ error: "La venta no tiene ítems para facturar." }, { status: 422 });
  }

  const num = (v: unknown): number => {
    const n = typeof v === "number" ? v : parseFloat(String(v ?? "0"));
    return Number.isFinite(n) ? n : 0;
  };

  // Numeración canónica (misma que usa el puente al crear la venta).
  const numeroFactura = await obtenerSiguienteNumeroFacturaEmpresa(sb, empresaId);

  const fechaYmd = String(venta.fecha).slice(0, 10);
  const esCredito = String(venta.tipo_venta ?? "").toUpperCase() === "CREDITO";
  const total = num(venta.total);

  const facPayload: Record<string, unknown> = {
    empresa_id: empresaId,
    cliente_id: venta.cliente_id,
    numero_factura: numeroFactura,
    fecha: fechaYmd,
    fecha_vencimiento: fechaYmd,
    monto: total,
    saldo: esCredito ? total : 0,
    estado: esCredito ? "Pendiente" : "Pagado",
    tipo: esCredito ? "credito" : "contado",
    moneda: venta.moneda === "USD" ? "USD" : "GS",
    cliente_razon_social: razonSocial,
    cliente_ruc: rucSnap,
    origen_venta_id: id,
    es_retroactiva: true,
  };

  const insFac = await sb.from("facturas").insert(facPayload).select("id").single();
  if (insFac.error) return NextResponse.json({ error: insFac.error.message }, { status: 500 });
  const facturaId = String((insFac.data as { id: string }).id);

  const itemsFacRows = itemsRaw.map((line) => {
    const totalLinea = num(line.total_linea);
    const iva = num(line.monto_iva);
    return {
      empresa_id: empresaId,
      factura_id: facturaId,
      descripcion: line.producto_nombre,
      cantidad: num(line.cantidad),
      precio_unitario: num(line.precio_venta),
      subtotal: totalLinea - iva,
      iva,
      total: totalLinea,
      tipo_iva: line.tipo_iva,
    };
  });
  const insItems = await sb.from("factura_items").insert(itemsFacRows);
  if (insItems.error) {
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    return NextResponse.json({ error: insItems.error.message }, { status: 500 });
  }

  // Link venta→factura SÓLO si sigue sin factura (evita duplicar ante doble clic/carrera).
  const linkUpd = await sb
    .from("ventas")
    .update({ factura_id: facturaId })
    .eq("id", id)
    .eq("empresa_id", empresaId)
    .is("factura_id", null)
    .select("id");
  if (linkUpd.error) {
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    return NextResponse.json({ error: linkUpd.error.message }, { status: 500 });
  }
  if (!linkUpd.data || (linkUpd.data as unknown[]).length === 0) {
    // Otro proceso ya facturó esta venta entre medio: descarto la mía y devuelvo la existente.
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    const again = await sb
      .from("ventas")
      .select("factura_id")
      .eq("id", id)
      .eq("empresa_id", empresaId)
      .maybeSingle();
    const existing = (again.data as { factura_id?: string } | null)?.factura_id ?? null;
    let numExisting: string | null = null;
    if (existing) {
      const fx = await sb.from("facturas").select("numero_factura").eq("id", existing).maybeSingle();
      numExisting = (fx.data as { numero_factura?: string } | null)?.numero_factura ?? null;
    }
    return NextResponse.json({ ok: true, alreadyExisted: true, facturaId: existing, numeroFactura: numExisting });
  }

  return NextResponse.json({
    ok: true,
    facturaId,
    numeroFactura,
    sinRuc: !rucSnap,
  });
}
