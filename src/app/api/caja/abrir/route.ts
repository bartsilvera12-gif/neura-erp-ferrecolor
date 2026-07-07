import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { abrirCaja } from "@/lib/caja/server";

/** POST /api/caja/abrir — abre la caja con monto inicial. */
export async function POST(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });

    let body: unknown;
    try {
      body = await request.json();
    } catch {
      return NextResponse.json(errorResponse("JSON inválido."), { status: 400 });
    }
    const o = (body ?? {}) as Record<string, unknown>;
    const montoApertura = Number(o.monto_apertura);
    if (!Number.isFinite(montoApertura) || montoApertura < 0) {
      return NextResponse.json(errorResponse("Monto de apertura inválido."), { status: 400 });
    }
    const observacion =
      o.observacion == null || o.observacion === "" ? null : String(o.observacion).slice(0, 2000);
    const numeroRaw = Number(o.numero_caja);
    const numeroCaja = Number.isFinite(numeroRaw) && numeroRaw >= 1 ? Math.floor(numeroRaw) : null;

    const caja = await abrirCaja(ctx.supabase, {
      empresaId: ctx.auth.empresa_id,
      montoApertura,
      observacion,
      usuarioId: ctx.auth.usuarioCatalogId ?? null,
      numeroCaja,
    });
    return NextResponse.json(successResponse({ caja }));
  } catch (err) {
    const msg = err instanceof Error ? err.message : "No se pudo abrir la caja.";
    const status = /ya está activa/i.test(msg) ? 409 : 500;
    return NextResponse.json(errorResponse(msg), { status });
  }
}
