import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  calcularComision,
  calcularComisionPauta,
  getEscalasComision,
  PAUTA_PORCENTAJE_GANANCIA,
} from "@/lib/comisiones/escalas-ferrecolor";
import { agruparPorVendedorConCanal, cargarVentasConGanancia } from "@/lib/comisiones/ventas-ganancia";

/**
 * GET /api/comisiones/ferrecolor?desde=YYYY-MM-DD&hasta=YYYY-MM-DD
 *
 * Comisiones por vendedor del periodo. La ganancia sale de
 * precio_venta - costo_unitario snapshot (ver ventas-ganancia.ts).
 *
 * OJO: el TRAMO lo define lo VENDIDO en el periodo, pero el porcentaje se
 * aplica sobre la GANANCIA de esas ventas, y sobre TODA la ganancia (no solo
 * sobre el excedente del tramo).
 *
 * Ej: vendio 40.000.000 con 12.000.000 de ganancia -> tramo 7% -> 840.000.
 *
 * Los tramos son configurables desde Administracion; ver escalas-ferrecolor.ts.
 */
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

    // Escalas vigentes (Administracion > Configuracion > Comisiones). Si no hay
    // ninguna cargada, caen las por defecto 0% / 5% / 7%.
    const { escalas, origen: escalasOrigen } = await getEscalasComision(ctx.supabase, empresaId);

    const ventas = await cargarVentasConGanancia(ctx.supabase, empresaId, desde, hastaTs);

    // Desglose venta por venta de UN vendedor, para poder verificar de donde
    // sale la ganancia sobre la que se calcula la comision.
    const vendedorDetalle = (sp.get("vendedor") || "").trim();
    const detalle = vendedorDetalle
      ? ventas
          .filter((v) => v.vendedor === vendedorDetalle)
          .sort((a, b) => (a.fecha < b.fecha ? 1 : -1))
          .map((v) => ({
            id: v.id,
            numero_control: v.numero_control,
            fecha: v.fecha,
            ingresos: Math.round(v.ingresos),
            costo: Math.round(v.costo),
            ganancia: Math.round(v.ganancia),
            canal: v.canal,
          }))
      : null;

    // Comisión por canal: balcón usa las escalas por tramo (según lo vendido en
    // balcón); pauta paga 3% de su ganancia, aparte. La comisión del vendedor es
    // la suma de ambas. El tramo/porcentaje de la fila refleja el canal balcón.
    const filas = agruparPorVendedorConCanal(ventas)
      .map((a) => {
        const { tramo, comision: comisionBalcon } = calcularComision(
          escalas,
          a.balcon.ingresos,
          a.balcon.ganancia
        );
        const comisionPauta = calcularComisionPauta(a.pauta.ganancia);
        const round = (s: typeof a.balcon) => ({
          ventas: s.ventas,
          ingresos: Math.round(s.ingresos),
          costo: Math.round(s.costo),
          ganancia: Math.round(s.ganancia),
        });
        return {
          vendedor: a.vendedor,
          ventas: a.total.ventas,
          ingresos: Math.round(a.total.ingresos),
          costo: Math.round(a.total.costo),
          ganancia: Math.round(a.total.ganancia),
          tramo_desde: tramo.desde,
          tramo_hasta: tramo.hasta,
          porcentaje: tramo.porcentaje,
          comision: comisionBalcon + comisionPauta,
          comision_balcon: comisionBalcon,
          comision_pauta: comisionPauta,
          balcon: round(a.balcon),
          pauta: round(a.pauta),
        };
      })
      .sort((a, b) => b.ganancia - a.ganancia);

    return NextResponse.json(successResponse({
      periodo: { desde, hasta },
      escalas,
      escalas_origen: escalasOrigen,
      pauta_porcentaje: PAUTA_PORCENTAJE_GANANCIA,
      por_vendedor: filas,
      detalle_vendedor: vendedorDetalle || null,
      detalle,
      totales: {
        ventas: filas.reduce((s, f) => s + f.ventas, 0),
        ingresos: filas.reduce((s, f) => s + f.ingresos, 0),
        costo: filas.reduce((s, f) => s + f.costo, 0),
        ganancia: filas.reduce((s, f) => s + f.ganancia, 0),
        comision: filas.reduce((s, f) => s + f.comision, 0),
        comision_balcon: filas.reduce((s, f) => s + f.comision_balcon, 0),
        comision_pauta: filas.reduce((s, f) => s + f.comision_pauta, 0),
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
