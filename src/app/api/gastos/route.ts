import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";

/**
 * GET /api/gastos
 * Gastos operativos del tenant (service role).
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) {
      return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    }
    const { supabase, auth } = ctx;
    const { data, error } = await supabase
      .from("gastos")
      .select("*")
      .eq("empresa_id", auth.empresa_id)
      .order("fecha", { ascending: false });

    if (error) {
      return NextResponse.json(errorResponse(error.message), { status: 400 });
    }
    return NextResponse.json(successResponse(data ?? []));
  } catch (err) {
    const msg = err instanceof Error ? err.message : "Error";
    return NextResponse.json(errorResponse(msg), { status: 500 });
  }
}

/**
 * POST /api/gastos — crea un gasto operativo.
 * Body: { categoria, descripcion, monto, tipo: 'fijo'|'variable', recurrente,
 *         frecuencia?, fecha (YYYY-MM-DD) }
 */
export async function POST(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) {
      return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    }
    const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;

    const monto = Number(body.monto);
    if (!Number.isFinite(monto) || monto <= 0) {
      return NextResponse.json(errorResponse("El monto debe ser mayor a 0."), { status: 400 });
    }
    const tipo = body.tipo === "fijo" ? "fijo" : "variable";
    const fecha = typeof body.fecha === "string" && body.fecha.match(/^\d{4}-\d{2}-\d{2}/)
      ? body.fecha.slice(0, 10)
      : null;
    if (!fecha) {
      return NextResponse.json(errorResponse("Fecha inválida."), { status: 400 });
    }
    const categoria = body.categoria != null ? String(body.categoria).trim() : "";
    const descripcion = body.descripcion != null ? String(body.descripcion).trim() : "";
    const recurrente = body.recurrente === true;
    const frecuencia = body.frecuencia != null ? String(body.frecuencia).trim() : "";

    const { data, error } = await ctx.supabase
      .from("gastos")
      .insert({
        empresa_id: ctx.auth.empresa_id,
        categoria: categoria || null,
        descripcion: descripcion || null,
        monto,
        tipo,
        recurrente,
        frecuencia: frecuencia || null,
        fecha,
      })
      .select()
      .single();

    if (error) {
      return NextResponse.json(errorResponse(error.message), { status: 400 });
    }
    return NextResponse.json(successResponse(data));
  } catch (err) {
    const msg = err instanceof Error ? err.message : "Error";
    return NextResponse.json(errorResponse(msg), { status: 500 });
  }
}
