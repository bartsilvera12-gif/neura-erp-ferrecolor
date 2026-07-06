import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { getRotacionAbc } from "@/lib/reportes/server/rotacion-abc-pg";
import { asuncionRangeBoundsUtc } from "@/lib/fechas/asuncion-bounds";

const TZ = "America/Asuncion";

/** Bordes UTC de "los últimos N meses" (Asunción), + etiquetas YYYY-MM-DD. */
function ultimosMesesBounds(meses: number) {
  const hoy = new Date();
  const inicio = new Date(hoy);
  inicio.setMonth(inicio.getMonth() - meses);
  const hasta = hoy.toLocaleDateString("en-CA", { timeZone: TZ });
  const desde = inicio.toLocaleDateString("en-CA", { timeZone: TZ });
  const { start, end } = asuncionRangeBoundsUtc(desde, hasta);
  return { start, end, desde, hasta };
}

/** GET /api/reportes/rotacion-abc?meses=1|2|3 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);

    const raw = parseInt(new URL(request.url).searchParams.get("meses") ?? "3", 10);
    const meses = [1, 2, 3].includes(raw) ? raw : 3;
    const b = ultimosMesesBounds(meses);

    const data = await getRotacionAbc(schema, ctx.auth.empresa_id, { ...b, meses });
    return NextResponse.json(successResponse(data));
  } catch (err) {
    console.error("[/api/reportes/rotacion-abc]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo calcular la rotación de productos."), { status: 500 });
  }
}
