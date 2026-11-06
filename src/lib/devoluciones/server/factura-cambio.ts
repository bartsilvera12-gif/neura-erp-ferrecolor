/**
 * Factura ERP del producto entregado en un CAMBIO de devolución (Fase C, #5).
 *
 * Crea la factura ERP (+ líneas) para la mercadería entregada en el cambio, para
 * que luego pueda emitirse el documento electrónico (DE) a la SET por el pipeline
 * SIFEN existente (borrador→xml→firmar→enviar). NO emite el DE acá: eso es I/O
 * externo y se dispara desde el cliente después de confirmar la devolución.
 *
 * Es BEST-EFFORT y se corre DESPUÉS de confirmar la devolución: si falla, la
 * devolución ya quedó registrada y solo se informa el warning (igual criterio que
 * el puente venta→factura en create-venta-pg.ts). Idempotente por
 * devoluciones_venta.cambio_factura_id.
 */
import type { AppSupabaseClient } from "@/lib/supabase/schema";
import { getFacturacionModo } from "@/lib/facturacion/server/facturacion-modo-pg";
import { obtenerSiguienteNumeroFacturaEmpresa } from "@/lib/facturacion/factura-suscripcion-servidor";
import type { Devolucion } from "@/lib/devoluciones/types";

export type FacturaCambioResultado =
  | { emitida: false; motivo: string }
  | { emitida: true; factura_id: string; numero_factura: string; sin_ruc: boolean };

function n(v: unknown): number {
  const x = typeof v === "number" ? v : parseFloat(String(v ?? "0"));
  return Number.isFinite(x) ? x : 0;
}

export async function crearFacturaCambioDevolucion(
  sb: AppSupabaseClient,
  schema: string,
  empresaId: string,
  devolucion: Devolucion
): Promise<FacturaCambioResultado> {
  // Solo cambios con mercadería entregada.
  if (devolucion.resolucion !== "cambio") {
    return { emitida: false, motivo: "La devolución no es un cambio." };
  }
  const cambios = devolucion.cambios ?? [];
  if (cambios.length === 0) {
    return { emitida: false, motivo: "El cambio no tiene productos entregados." };
  }
  if (!devolucion.cliente_id) {
    return { emitida: false, motivo: "La venta no tiene cliente asignado; no se puede facturar el cambio." };
  }

  // La empresa debe estar en modo facturación electrónica (SIFEN).
  const modo = await getFacturacionModo(schema, empresaId);
  if (modo.modo !== "sifen") {
    return { emitida: false, motivo: "La empresa no está en modo de facturación electrónica (SIFEN)." };
  }

  // Idempotencia: si ya se creó la factura del cambio, devolverla.
  const yaQ = await sb
    .from("devoluciones_venta")
    .select("cambio_factura_id")
    .eq("id", devolucion.id)
    .eq("empresa_id", empresaId)
    .maybeSingle();
  const yaId = (yaQ.data as { cambio_factura_id?: string | null } | null)?.cambio_factura_id ?? null;
  if (yaId) {
    const fx = await sb.from("facturas").select("numero_factura").eq("id", yaId).maybeSingle();
    return {
      emitida: true,
      factura_id: yaId,
      numero_factura: (fx.data as { numero_factura?: string } | null)?.numero_factura ?? "",
      sin_ruc: false,
    };
  }

  // Receptor (cliente de la venta): razón social obligatoria para SIFEN.
  const s = (v: string | null | undefined) => (typeof v === "string" && v.trim() ? v.trim() : null);
  const cliQ = await sb
    .from("clientes")
    .select("empresa, nombre, nombre_contacto, nombre_facturacion, ruc")
    .eq("id", devolucion.cliente_id)
    .eq("empresa_id", empresaId)
    .maybeSingle();
  const c = cliQ.data as Record<string, string | null> | null;
  const razonSocial = c ? s(c.nombre_facturacion) || s(c.empresa) || s(c.nombre_contacto) || s(c.nombre) : null;
  const rucSnap = c ? s(c.ruc) : null;
  if (!razonSocial) {
    return { emitida: false, motivo: "El cliente no tiene nombre/razón social para facturar el cambio." };
  }

  const total = n(devolucion.total_entregado);
  if (total <= 0) {
    return { emitida: false, motivo: "El cambio no tiene monto a facturar." };
  }

  // La diferencia a crédito queda como saldo pendiente de esta factura.
  const aCredito = devolucion.metodo_reembolso === "credito" && n(devolucion.diferencia) > 0;
  const saldo = aCredito ? n(devolucion.diferencia) : 0;
  const fechaYmd = String(devolucion.created_at ?? devolucion.venta_fecha ?? "").slice(0, 10);

  const numeroFactura = await obtenerSiguienteNumeroFacturaEmpresa(sb, empresaId);

  const facPayload: Record<string, unknown> = {
    empresa_id: empresaId,
    cliente_id: devolucion.cliente_id,
    numero_factura: numeroFactura,
    fecha: fechaYmd,
    fecha_vencimiento: fechaYmd,
    monto: total,
    saldo,
    estado: saldo > 0 ? "Pendiente" : "Pagado",
    tipo: aCredito ? "credito" : "contado",
    moneda: "GS",
    cliente_razon_social: razonSocial,
    cliente_ruc: rucSnap,
    origen_venta_id: devolucion.venta_id,
    es_retroactiva: true,
  };

  const insFac = await sb.from("facturas").insert(facPayload).select("id").single();
  if (insFac.error) return { emitida: false, motivo: insFac.error.message };
  const facturaId = String((insFac.data as { id: string }).id);

  const itemsRows = cambios.map((cb) => {
    const totalLinea = n(cb.total);
    const iva = n(cb.monto_iva);
    return {
      empresa_id: empresaId,
      factura_id: facturaId,
      descripcion: cb.producto_nombre,
      cantidad: n(cb.cantidad),
      precio_unitario: n(cb.precio_unitario),
      subtotal: totalLinea - iva,
      iva,
      total: totalLinea,
      tipo_iva: cb.tipo_iva,
    };
  });
  const insItems = await sb.from("factura_items").insert(itemsRows);
  if (insItems.error) {
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    return { emitida: false, motivo: insItems.error.message };
  }

  // Link devolución→factura SOLO si sigue sin factura (anti doble emisión/carrera).
  const linkUpd = await sb
    .from("devoluciones_venta")
    .update({ cambio_factura_id: facturaId })
    .eq("id", devolucion.id)
    .eq("empresa_id", empresaId)
    .is("cambio_factura_id", null)
    .select("id");
  if (linkUpd.error) {
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    return { emitida: false, motivo: linkUpd.error.message };
  }
  if (!linkUpd.data || (linkUpd.data as unknown[]).length === 0) {
    // Otro proceso ya facturó este cambio: descarto la mía y devuelvo la existente.
    await sb.from("facturas").delete().eq("id", facturaId).eq("empresa_id", empresaId);
    const again = await sb
      .from("devoluciones_venta")
      .select("cambio_factura_id")
      .eq("id", devolucion.id)
      .eq("empresa_id", empresaId)
      .maybeSingle();
    const existing = (again.data as { cambio_factura_id?: string } | null)?.cambio_factura_id ?? null;
    let numExisting = "";
    if (existing) {
      const fx = await sb.from("facturas").select("numero_factura").eq("id", existing).maybeSingle();
      numExisting = (fx.data as { numero_factura?: string } | null)?.numero_factura ?? "";
    }
    return existing
      ? { emitida: true, factura_id: existing, numero_factura: numExisting, sin_ruc: !rucSnap }
      : { emitida: false, motivo: "No se pudo vincular la factura del cambio." };
  }

  return { emitida: true, factura_id: facturaId, numero_factura: numeroFactura, sin_ruc: !rucSnap };
}
