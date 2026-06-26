import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { getCajaAbierta, getResumenCaja } from "@/lib/caja/server";

/**
 * GET /api/caja/estado
 *
 * Devuelve la caja abierta actual de la empresa con su resumen completo, o
 * { caja: null } si no hay ninguna abierta. Usado por el panel de Caja en
 * /ventas para decidir si mostrar el boton "Abrir caja" o el bloque "Caja
 * abierta" con totales.
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });

    const abierta = await getCajaAbierta(ctx.supabase, ctx.auth.empresa_id);
    if (!abierta) return NextResponse.json(successResponse({ caja: null, resumen: null }));

    const resumen = await getResumenCaja(ctx.supabase, ctx.auth.empresa_id, abierta.id);
    return NextResponse.json(successResponse({ caja: abierta, resumen }));
  } catch (err) {
    const msg = err instanceof Error ? err.message : "No se pudo cargar el estado de caja.";
    return NextResponse.json(errorResponse(msg), { status: 500 });
  }
}
