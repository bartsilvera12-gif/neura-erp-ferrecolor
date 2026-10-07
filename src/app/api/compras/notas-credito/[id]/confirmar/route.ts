import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { confirmarNotaCreditoCompra } from "@/lib/compras/server/notas-credito-compra-pg";

/**
 * POST /api/compras/notas-credito/[id]/confirmar
 * Confirma la NC (borrador -> confirmada) y descuenta stock. Idempotente.
 */
export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    const { id } = await params;
    const ncId = String(id ?? "").trim();
    if (!ncId) return NextResponse.json(errorResponse("Falta el ID de la nota de crédito."), { status: 400 });

    try {
      const out = await confirmarNotaCreditoCompra(schema, empresaId, ncId, {
        created_by: ctx.auth.usuarioCatalogId ?? null,
        usuario_nombre: ctx.auth.user?.email ?? null,
      });
      return NextResponse.json(successResponse({
        nota: out.nota,
        ya_confirmada: out.ya_confirmada,
        movimientos_creados: out.movimientos_creados,
      }));
    } catch (e) {
      const msg = e instanceof Error ? e.message : "No se pudo confirmar la nota de crédito.";
      console.error("[/api/compras/notas-credito/[id]/confirmar POST]", { schema, empresaId, ncId, msg });
      return NextResponse.json(errorResponse(msg), { status: 400 });
    }
  } catch (err) {
    console.error("[/api/compras/notas-credito/[id]/confirmar] outer", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo confirmar la nota de crédito."), { status: 500 });
  }
}
