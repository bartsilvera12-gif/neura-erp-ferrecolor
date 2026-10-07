import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { listComprasElegibles } from "@/lib/compras/server/notas-credito-compra-pg";

/**
 * GET /api/compras/notas-credito/elegibles?proveedor_id=...
 * Compras del proveedor con cantidad aún disponible para acreditar.
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    const proveedorId = request.nextUrl.searchParams.get("proveedor_id")?.trim() ?? "";
    if (!proveedorId) return NextResponse.json(errorResponse("Falta el proveedor."), { status: 400 });

    const compras = await listComprasElegibles(schema, empresaId, proveedorId);
    return NextResponse.json(successResponse({ compras }));
  } catch (err) {
    console.error("[/api/compras/notas-credito/elegibles GET]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudieron cargar las compras elegibles."), { status: 500 });
  }
}
