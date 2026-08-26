import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";

/**
 * GET /api/comisiones/ferrecolor?desde=YYYY-MM-DD&hasta=YYYY-MM-DD
 *
 * Calcula comisiones sobre GANANCIA por vendedor. La ganancia se calcula
 * como precio_venta - costo_unitario a nivel item, usando el costo snapshot
 * guardado en movimientos_inventario al momento de la SALIDA.
 *
 * Escalas Ferrecolor. OJO: el tramo lo define lo VENDIDO en el periodo, pero el
 * porcentaje se aplica sobre la GANANCIA de esas ventas.
 *   - Vendido < 20.000.000  → 0%
 *   - Vendido 20M a 35M     → 5% de la ganancia
 *   - Vendido >= 35M        → 7% de la ganancia
 *
 * Ej: vendio 25.000.000 y genero 6.000.000 de ganancia → 6.000.000 x 5% = 300.000.
 * Se aplica el porcentaje a TODA la ganancia (no solo al excedente).
 */

const ESCALAS = [
  { desde: 0,          hasta: 20_000_000, porcentaje: 0 },
  { desde: 20_000_000, hasta: 35_000_000, porcentaje: 5 },
  { desde: 35_000_000, hasta: null,       porcentaje: 7 },
];

/** El tramo se determina por el MONTO VENDIDO (ingresos) del periodo. */
function tramoParaVentas(ingresos: number) {
  for (const e of ESCALAS) {
    if (ingresos >= e.desde && (e.hasta === null || ingresos < e.hasta)) {
      return e;
    }
  }
  return ESCALAS[0];
}

export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;

    const sp = request.nextUrl.searchParams;
    const desde = sp.get("desde") || "";
    const hasta = sp.get("hasta") || "";
    if (!/^\d{4}-\d{2}-\d{2}$/.test(desde) || !/^\d{4}-\d{2}-\d{2}$/.test(hasta)) {
      return NextResponse.json(errorResponse("Faltan desde/hasta (YYYY-MM-DD)."), { status: 400 });
    }
    const hastaTs = `${hasta}T23:59:59.999Z`;

    // 1) Ventas del periodo (activas)
    const { data: ventasRaw, error: eV } = await ctx.supabase
      .from("ventas")
      .select("id, total, fecha, estado, usuario_nombre, created_by")
      .eq("empresa_id", empresaId)
      .gte("fecha", desde)
      .lte("fecha", hastaTs);
    if (eV) throw new Error(eV.message);

    const ventas = (ventasRaw ?? []).filter(
      (v) => v.estado !== "anulada" && v.estado !== "devuelta_total"
    );
    const ventaIds = ventas.map((v) => String(v.id));
    if (ventaIds.length === 0) {
      return NextResponse.json(successResponse({ por_vendedor: [], periodo: { desde, hasta }, escalas: ESCALAS }));
    }

    // 2) Movimientos SALIDA (costo real snapshot) para esas ventas.
    //    Se consulta por lotes chicos de venta_id: con cientos de ventas en el
    //    periodo, un unico .in() arma una URL enorme y la request falla (la
    //    pantalla mostraba "No se pudieron calcular las comisiones"). Ademas se
    //    pagina, porque PostgREST corta en 1000 filas y los costos salian cortos.
    type MovRow = { venta_id: string | null; cantidad: number | string | null; costo_unitario: number | string | null; anulado_at: string | null };
    const CHUNK = 25;
    const PAGE = 1000;
    const movs: MovRow[] = [];
    for (let i = 0; i < ventaIds.length; i += CHUNK) {
      const ids = ventaIds.slice(i, i + CHUNK);
      for (let desdeFila = 0; ; desdeFila += PAGE) {
        const { data, error: eM } = await ctx.supabase
          .from("movimientos_inventario")
          .select("venta_id, cantidad, costo_unitario, tipo, anulado_at")
          .eq("empresa_id", empresaId)
          .eq("tipo", "SALIDA")
          .in("venta_id", ids)
          .range(desdeFila, desdeFila + PAGE - 1);
        if (eM) throw new Error(eM.message);
        const lote = (data ?? []) as MovRow[];
        movs.push(...lote);
        if (lote.length < PAGE) break;
      }
    }

    const costoPorVenta = new Map<string, number>();
    for (const m of movs) {
      if (m.anulado_at) continue;
      const vid = String(m.venta_id ?? "");
      if (!vid) continue;
      const c = (Number(m.cantidad) || 0) * (Number(m.costo_unitario) || 0);
      costoPorVenta.set(vid, (costoPorVenta.get(vid) ?? 0) + c);
    }

    // 3) Agrupar por vendedor (usuario_nombre)
    type Agg = { vendedor: string; ventas: number; ingresos: number; costo: number; ganancia: number };
    const porVendedor = new Map<string, Agg>();
    for (const v of ventas) {
      const nombre = (v.usuario_nombre?.trim() as string) || "Sin vendedor";
      const ingresos = Number(v.total) || 0;
      const costo = costoPorVenta.get(String(v.id)) ?? 0;
      const ganancia = ingresos - costo;
      let a = porVendedor.get(nombre);
      if (!a) { a = { vendedor: nombre, ventas: 0, ingresos: 0, costo: 0, ganancia: 0 }; porVendedor.set(nombre, a); }
      a.ventas += 1;
      a.ingresos += ingresos;
      a.costo += costo;
      a.ganancia += ganancia;
    }

    // 4) Aplicar tramo por vendedor
    const filas = [...porVendedor.values()]
      .map((a) => {
        // Tramo por lo vendido; porcentaje sobre la ganancia generada.
        const tramo = tramoParaVentas(a.ingresos);
        const comision = Math.max(0, Math.round((a.ganancia * tramo.porcentaje) / 100));
        return {
          vendedor: a.vendedor,
          ventas: a.ventas,
          ingresos: Math.round(a.ingresos),
          costo: Math.round(a.costo),
          ganancia: Math.round(a.ganancia),
          tramo_desde: tramo.desde,
          tramo_hasta: tramo.hasta,
          porcentaje: tramo.porcentaje,
          comision,
        };
      })
      .sort((a, b) => b.ganancia - a.ganancia);

    return NextResponse.json(successResponse({
      periodo: { desde, hasta },
      escalas: ESCALAS,
      por_vendedor: filas,
      totales: {
        ventas: filas.reduce((s, f) => s + f.ventas, 0),
        ingresos: filas.reduce((s, f) => s + f.ingresos, 0),
        costo: filas.reduce((s, f) => s + f.costo, 0),
        ganancia: filas.reduce((s, f) => s + f.ganancia, 0),
        comision: filas.reduce((s, f) => s + f.comision, 0),
      },
    }));
  } catch (err) {
    const detalle = err instanceof Error ? err.message : String(err);
    console.error("[/api/comisiones/ferrecolor GET]", detalle);
    // Se incluye el detalle: antes el mensaje generico obligaba a adivinar la causa.
    return NextResponse.json(
      errorResponse(`No se pudieron calcular las comisiones: ${detalle}`),
      { status: 500 }
    );
  }
}
