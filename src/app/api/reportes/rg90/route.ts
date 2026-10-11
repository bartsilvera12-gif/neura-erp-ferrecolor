import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { getReporteRG90 } from "@/lib/reportes/server/rg90-pg";
import { asuncionMesBoundsUtc, normalizarMes } from "@/lib/fechas/asuncion-bounds";

/** GET /api/reportes/rg90?mes=YYYY-MM → Libro de Ventas RG90 (JSON para vista previa). */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const mes = normalizarMes(new URL(request.url).searchParams.get("mes"));
    const { start, end } = asuncionMesBoundsUtc(mes);
    const data = await getReporteRG90(schema, ctx.auth.empresa_id, { mes, start, end, mesInicio: `${mes}-01` });
    return NextResponse.json(successResponse(data));
  } catch (err) {
    console.error("[/api/reportes/rg90]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo generar el Libro de Ventas RG90."), { status: 500 });
  }
}
