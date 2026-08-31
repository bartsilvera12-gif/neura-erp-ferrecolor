import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { calcularComision, getEscalasComision } from "@/lib/comisiones/escalas-ferrecolor";
import { cargarVentasConGanancia, SIN_VENDEDOR } from "@/lib/comisiones/ventas-ganancia";

/**
 * GET /api/comisiones/mi-cierre?caja_id=UUID
 *
 * Lo que el vendedor necesita ver al cerrar su caja: cuanto vendio en el turno,
 * cuanto lleva vendido en el mes, cuanta comision tiene generada hasta ahora y
 * cuanto efectivo tiene que rendir.
 *
 * IMPORTANTE — por que hay dos numeros distintos de "vendido":
 * la comision NO es del turno, es del MES: el tramo (0/5/7%) se decide por el
 * total vendido en el periodo completo. Un turno suelto casi nunca alcanza los
 * 20.000.000, asi que calcular la comision por turno daria siempre 0. Por eso se
 * muestra el turno como dato del dia y la comision como acumulado del mes a la
 * fecha, que es lo que efectivamente se le va a liquidar.
 *
 * La comision es INFORMATIVA: no se descuenta del efectivo a rendir. El vendedor
 * rinde toda la plata de la caja y la comision se liquida aparte a fin de mes.
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;

    const cajaId = request.nextUrl.searchParams.get("caja_id") || "";

    // El vendedor se identifica igual que al crear la venta (ventas.usuario_nombre),
    // si no, el turno no cruza con sus ventas.
    const vendedor =
      (ctx.auth.nombre ?? "").trim() || (ctx.auth.user?.email ?? "").trim() || SIN_VENDEDOR;

    // Periodo de comision = mes en curso hasta hoy.
    const hoy = new Date();
    const y = hoy.getFullYear();
    const m = String(hoy.getMonth() + 1).padStart(2, "0");
    const desde = `${y}-${m}-01`;
    const hasta = `${y}-${m}-${String(hoy.getDate()).padStart(2, "0")}`;
    const hastaTs = `${hasta}T23:59:59.999Z`;

    const { escalas, origen: escalasOrigen } = await getEscalasComision(ctx.supabase, empresaId);
    const ventasMes = await cargarVentasConGanancia(ctx.supabase, empresaId, desde, hastaTs);

    const mias = ventasMes.filter((v) => v.vendedor === vendedor);
    const acumular = (lista: typeof mias) =>
      lista.reduce(
        (a, v) => ({
          ventas: a.ventas + 1,
          ingresos: a.ingresos + v.ingresos,
          costo: a.costo + v.costo,
          ganancia: a.ganancia + v.ganancia,
        }),
        { ventas: 0, ingresos: 0, costo: 0, ganancia: 0 }
      );

    const mes = acumular(mias);
    const turno = acumular(cajaId ? mias.filter((v) => v.caja_id === cajaId) : []);

    const { tramo, comision } = calcularComision(escalas, mes.ingresos, mes.ganancia);

    // Cuanto le falta vender para saltar al tramo siguiente: evita el reclamo de
    // "por que me dio 0%".
    const siguiente = escalas.find((e) => e.desde > mes.ingresos) ?? null;

    return NextResponse.json(successResponse({
      vendedor,
      caja_id: cajaId || null,
      periodo: { desde, hasta },
      turno: {
        ventas: turno.ventas,
        vendido: Math.round(turno.ingresos),
        ganancia: Math.round(turno.ganancia),
      },
      mes: {
        ventas: mes.ventas,
        vendido: Math.round(mes.ingresos),
        costo: Math.round(mes.costo),
        ganancia: Math.round(mes.ganancia),
        porcentaje: tramo.porcentaje,
        tramo_desde: tramo.desde,
        tramo_hasta: tramo.hasta,
        comision,
      },
      proximo_tramo: siguiente
        ? {
            desde: siguiente.desde,
            porcentaje: siguiente.porcentaje,
            falta: Math.round(siguiente.desde - mes.ingresos),
          }
        : null,
      escalas,
      escalas_origen: escalasOrigen,
      comision_se_descuenta_del_efectivo: false,
    }));
  } catch (err) {
    const detalle = err instanceof Error ? err.message : String(err);
    console.error("[/api/comisiones/mi-cierre GET]", detalle);
    return NextResponse.json(
      errorResponse(`No se pudo calcular la comisión del cierre: ${detalle}`),
      { status: 500 }
    );
  }
}
