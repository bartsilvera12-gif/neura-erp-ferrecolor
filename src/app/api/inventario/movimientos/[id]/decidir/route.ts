import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuthWithRol } from "@/lib/supabase/tenant-api";
import { isAdmin } from "@/lib/middleware/auth";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";

/**
 * POST /api/inventario/movimientos/[id]/decidir
 *
 * Un administrador aprueba o rechaza una SOLICITUD de movimiento (estado
 * 'pendiente') pedida por un vendedor.
 *  - aprobar:  estado → 'aprobado' y se aplica el delta al stock del producto.
 *  - rechazar: estado → 'rechazado' (con motivo opcional). NO toca el stock.
 *
 * Solo admin. Idempotente: si ya no está pendiente, devuelve 409.
 *
 * Body: { accion: "aprobar" | "rechazar", motivo?: string }
 */
export async function POST(request: NextRequest, ctxParams: { params: Promise<{ id: string }> }) {
  try {
    const { id } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuthWithRol(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    if (!isAdmin(ctx.auth)) {
      return NextResponse.json(errorResponse("Solo un administrador puede aprobar o rechazar solicitudes."), { status: 403 });
    }
    const empresaId = ctx.auth.empresa_id;
    const sb = ctx.supabase;

    let body: { accion?: unknown; motivo?: unknown };
    try {
      body = (await request.json()) as { accion?: unknown; motivo?: unknown };
    } catch {
      return NextResponse.json(errorResponse("JSON inválido."), { status: 400 });
    }
    const accion = String(body.accion ?? "").trim();
    if (accion !== "aprobar" && accion !== "rechazar") {
      return NextResponse.json(errorResponse("Acción inválida (aprobar | rechazar)."), { status: 400 });
    }
    const motivo = body.motivo != null && String(body.motivo).trim() !== "" ? String(body.motivo).trim().slice(0, 500) : null;

    // Movimiento (debe estar pendiente y pertenecer a la empresa).
    const mQ = await sb
      .from("movimientos_inventario")
      .select("id, producto_id, tipo, cantidad, origen, estado")
      .eq("empresa_id", empresaId)
      .eq("id", id)
      .maybeSingle();
    if (mQ.error) throw new Error(mQ.error.message);
    if (!mQ.data) return NextResponse.json(errorResponse("Solicitud no encontrada."), { status: 404 });
    const mov = mQ.data as { producto_id: string; tipo: string; cantidad: number | string; origen: string; estado: string };
    if (mov.estado !== "pendiente") {
      return NextResponse.json(errorResponse("La solicitud ya fue resuelta."), { status: 409 });
    }

    const usuarioId = ctx.auth.usuarioCatalogId ?? null;
    const nowIso = new Date().toISOString();

    if (accion === "rechazar") {
      const upd = await sb
        .from("movimientos_inventario")
        .update({ estado: "rechazado", rechazado_por: usuarioId, rechazado_at: nowIso, rechazo_motivo: motivo })
        .eq("id", id)
        .eq("empresa_id", empresaId)
        .eq("estado", "pendiente");
      if (upd.error) throw new Error(upd.error.message);
      return NextResponse.json(successResponse({ ok: true, estado: "rechazado" }));
    }

    // Aprobar: aplicar el delta al stock (salvo inventario_inicial) y marcar aprobado.
    const cantidad = Number(mov.cantidad) || 0;
    const delta =
      mov.tipo === "ENTRADA" ? Math.abs(cantidad) : mov.tipo === "SALIDA" ? -Math.abs(cantidad) : cantidad;

    if (mov.origen !== "inventario_inicial") {
      const pQ = await sb
        .from("productos")
        .select("stock_actual")
        .eq("empresa_id", empresaId)
        .eq("id", mov.producto_id)
        .maybeSingle();
      if (pQ.error) throw new Error(pQ.error.message);
      if (!pQ.data) return NextResponse.json(errorResponse("El producto de la solicitud ya no existe."), { status: 404 });
      const stockActual = Number((pQ.data as { stock_actual: number | string }).stock_actual) || 0;
      const nuevoStock = Math.max(0, stockActual + delta);
      const updProd = await sb
        .from("productos")
        .update({ stock_actual: nuevoStock })
        .eq("id", mov.producto_id)
        .eq("empresa_id", empresaId);
      if (updProd.error) throw new Error(updProd.error.message);
    }

    // Marcar aprobado solo si sigue pendiente (evita doble aplicación por doble clic).
    const upd = await sb
      .from("movimientos_inventario")
      .update({ estado: "aprobado", aprobado_por: usuarioId, aprobado_at: nowIso })
      .eq("id", id)
      .eq("empresa_id", empresaId)
      .eq("estado", "pendiente")
      .select("id");
    if (upd.error) throw new Error(upd.error.message);
    if (!upd.data || (upd.data as unknown[]).length === 0) {
      return NextResponse.json(errorResponse("La solicitud ya fue resuelta."), { status: 409 });
    }

    return NextResponse.json(successResponse({ ok: true, estado: "aprobado" }));
  } catch (err) {
    console.error("[/api/inventario/movimientos/[id]/decidir POST]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo procesar la solicitud."), { status: 500 });
  }
}
