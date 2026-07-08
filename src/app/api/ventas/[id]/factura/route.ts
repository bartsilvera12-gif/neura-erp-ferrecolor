import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getFacturacionModo, getAutoimpresor } from "@/lib/facturacion/server/facturacion-modo-pg";
import {
  emitirFacturaAutoimpresor,
  liquidarIva,
  EmisionBloqueadaError,
  type LiquidacionIva,
} from "@/lib/facturacion/autoimpresor/emitir-factura";
import { renderFacturaAutoimpresorHTML } from "@/lib/facturacion/autoimpresor/render-factura";
import { EMPRESA_DOC } from "@/lib/documentos/membrete";

/**
 * GET /api/ventas/[id]/factura?auto=1&preview=1
 *
 * Devuelve la FACTURA AUTOIMPRESOR de la venta como HTML imprimible (A4).
 *
 * - Si el modo de facturación es 'autoimpresor', la config está activa y el
 *   timbrado tiene rango disponible → EMITE (asigna número correlativo real,
 *   idempotente) y renderiza la factura legal.
 * - En cualquier otro caso (o con ?preview=1) → renderiza un BORRADOR con marca
 *   de agua "SIN VALIDEZ FISCAL", sin consumir la numeración real. Sirve para
 *   ver el formato antes de activar el autoimpresor.
 *
 * No toca SIFEN ni el ticket interno.
 */

interface ItemRow {
  producto_nombre: string;
  cantidad: number | string;
  precio_venta: number | string;
  total_linea: number | string;
  monto_iva: number | string;
  tipo_iva: string;
}

export async function GET(request: NextRequest, ctxParams: { params: Promise<{ id: string }> }) {
  const { id } = await ctxParams.params;
  const url = new URL(request.url);
  const forcePreview = url.searchParams.get("preview") === "1";
  const autoPrint = url.searchParams.get("auto") === "1";

  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new NextResponse("No autorizado", { status: 401 });
  const empresaId = ctx.auth.empresa_id;
  const schema = await fetchDataSchemaForEmpresaId(empresaId);

  // Venta
  const vQ = await ctx.supabase
    .from("ventas")
    .select("id, numero_control, fecha, tipo_venta, cliente_id")
    .eq("id", id)
    .eq("empresa_id", empresaId)
    .maybeSingle();
  if (vQ.error) return new NextResponse(`Error: ${vQ.error.message}`, { status: 500 });
  if (!vQ.data) return new NextResponse("Venta no encontrada", { status: 404 });
  const venta = vQ.data as {
    id: string; numero_control: string; fecha: string; tipo_venta: string | null; cliente_id: string | null;
  };

  // Ítems (para el detalle de la factura)
  const iQ = await ctx.supabase
    .from("ventas_items")
    .select("producto_nombre, cantidad, precio_venta, total_linea, monto_iva, tipo_iva")
    .eq("venta_id", id)
    .eq("empresa_id", empresaId);
  if (iQ.error) return new NextResponse(`Error items: ${iQ.error.message}`, { status: 500 });
  const itemsRaw = (iQ.data ?? []) as unknown as ItemRow[];
  const items = itemsRaw.map((it) => ({
    cantidad: Number(it.cantidad),
    descripcion: it.producto_nombre,
    precioUnitario: Number(it.precio_venta),
    totalLinea: Number(it.total_linea),
    tipo_iva: it.tipo_iva,
  }));

  // Cliente (si la venta lo tiene)
  let cliente: { nombre: string; ruc: string | null } | null = null;
  if (venta.cliente_id) {
    const cQ = await ctx.supabase
      .from("clientes")
      .select("empresa, nombre, nombre_contacto, ruc, documento")
      .eq("id", venta.cliente_id)
      .eq("empresa_id", empresaId)
      .maybeSingle();
    const c = cQ.data as Record<string, string | null> | null;
    if (c) {
      const s = (v: string | null | undefined) => (typeof v === "string" && v.trim() ? v.trim() : null);
      cliente = {
        nombre: s(c.empresa) || s(c.nombre_contacto) || s(c.nombre) || "SIN NOMBRE",
        ruc: s(c.ruc) || s(c.documento),
      };
    }
  }

  // Config fiscal
  const [modo, cfg] = await Promise.all([
    getFacturacionModo(schema, empresaId),
    getAutoimpresor(schema, empresaId),
  ]);

  const emisor = {
    razon_social: cfg.razon_social_emisor?.trim() || EMPRESA_DOC.razonSocial || EMPRESA_DOC.nombre,
    ruc: cfg.ruc_emisor?.trim() || EMPRESA_DOC.ruc,
    direccion: cfg.direccion_matriz?.trim() || EMPRESA_DOC.direccion.join(" · "),
    telefono: cfg.telefono?.trim() || EMPRESA_DOC.telefono,
    actividad: EMPRESA_DOC.actividad[0] ?? null,
  };

  // ¿Se puede emitir real? modo autoimpresor + config activa + rango disponible.
  const puedeEmitir =
    !forcePreview &&
    modo.modo === "autoimpresor" &&
    cfg.activo === true &&
    !!cfg.timbrado_numero &&
    !!cfg.establecimiento_codigo &&
    !!cfg.punto_expedicion_codigo &&
    cfg.numero_inicial != null &&
    cfg.numero_final != null &&
    cfg.numero_actual != null;

  if (puedeEmitir) {
    try {
      const factura = await emitirFacturaAutoimpresor(schema, empresaId, id);
      const liq: LiquidacionIva = {
        gravado_10: factura.gravado_10, iva_10: factura.iva_10,
        gravado_5: factura.gravado_5, iva_5: factura.iva_5,
        exentas: factura.exentas, total: factura.total,
      };
      const html = renderFacturaAutoimpresorHTML({
        borrador: false,
        emisor,
        timbrado: {
          numero: factura.timbrado_numero,
          inicio: factura.timbrado_inicio_vigencia,
          fin: factura.timbrado_fin_vigencia,
          establecimiento: factura.establecimiento_codigo,
          punto_expedicion: factura.punto_expedicion_codigo,
        },
        numeroCompleto: factura.numero_completo,
        fechaEmision: factura.emitida_at,
        condicion: factura.condicion,
        cliente,
        ventaNumeroControl: venta.numero_control,
        items,
        liq,
        autoPrint,
      });
      return new NextResponse(html, {
        status: 200,
        headers: { "content-type": "text/html; charset=utf-8", "cache-control": "no-store" },
      });
    } catch (e) {
      // Si el motor bloquea (config incompleta / timbrado agotado), caemos a borrador
      // con el motivo, en vez de romper la impresión.
      if (!(e instanceof EmisionBloqueadaError)) throw e;
      return borradorResponse(e.message);
    }
  }

  // ── Borrador (no consume numeración) ───────────────────────────────────────
  function borradorResponse(motivo: string) {
    const est = cfg.establecimiento_codigo?.trim() || "001";
    const punto = cfg.punto_expedicion_codigo?.trim() || "002";
    const html = renderFacturaAutoimpresorHTML({
      borrador: true,
      motivoBorrador: motivo,
      emisor,
      timbrado: {
        numero: cfg.timbrado_numero?.trim() || "—",
        inicio: cfg.timbrado_inicio_vigencia,
        fin: cfg.timbrado_fin_vigencia,
        establecimiento: est,
        punto_expedicion: punto,
      },
      numeroCompleto: `${est.padStart(3, "0").slice(-3)}-${punto.padStart(3, "0").slice(-3)}-XXXXXXX`,
      fechaEmision: venta.fecha,
      condicion: String(venta.tipo_venta).toUpperCase() === "CREDITO" ? "credito" : "contado",
      cliente,
      ventaNumeroControl: venta.numero_control,
      items,
      liq: liquidarIva(itemsRaw),
      autoPrint,
    });
    return new NextResponse(html, {
      status: 200,
      headers: { "content-type": "text/html; charset=utf-8", "cache-control": "no-store" },
    });
  }

  const motivo =
    modo.modo !== "autoimpresor"
      ? "El modo de facturación no es autoimpresor."
      : cfg.activo !== true
        ? "El autoimpresor no está activo todavía."
        : "Falta cargar el número actual del timbrado.";
  return borradorResponse(forcePreview ? "Vista previa del formato." : motivo);
}
