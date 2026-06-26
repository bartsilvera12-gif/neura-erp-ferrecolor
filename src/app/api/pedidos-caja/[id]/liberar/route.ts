import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";

/**
 * POST /api/pedidos-caja/[id]/liberar
 *
 * Transiciona pedido de 'en_caja' -> 'pendiente' (el cajero abandona y lo
 * libera para que otro lo tome). Limpia abierto_por*.
 */
export async function POST(
  request: NextRequest,
  ctxParams: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const { supabase: sb, auth } = ctx;

    const upd = await sb
      .from("pedidos_caja")
      .update({
        estado: "pendiente",
        abierto_por_id: null,
        abierto_por_email: null,
        abierto_at: null,
      })
      .eq("empresa_id", auth.empresa_id)
      .eq("id", id)
      .eq("estado", "en_caja");
    if (upd.error) return NextResponse.json(errorResponse(upd.error.message), { status: 400 });

    return NextResponse.json(successResponse({ ok: true }));
  } catch (err) {
    const msg = err instanceof Error ? err.message : "No se pudo liberar el pedido.";
    return NextResponse.json(errorResponse(msg), { status: 500 });
  }
}
