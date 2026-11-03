import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  getSaldoCompra, registrarPagoProveedor, PagoProveedorError,
} from "@/lib/compras/server/pagos-proveedores-pg";

/**
 * POST /api/compras/[numero_control]/pagar — LEGADO.
 *
 * Marcaba la compra como pagada escribiendo `estado_pago` directamente. Desde
 * que existen los pagos parciales eso dejaria la compra pagada SIN registro en
 * `pagos_proveedores`: invisible en el reporte de pagos y con el saldo mal
 * calculado.
 *
 * Ahora delega en registrarPagoProveedor por el saldo completo, asi el camino
 * viejo produce exactamente el mismo dato que el nuevo. Se conserva la ruta
 * para no romper nada que todavia la llame; lo nuevo usa
 * POST .../pagos, que ademas acepta pagos parciales.
 *
 * Body: { descontar_caja?: boolean }
 */
export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ numero_control: string }> }
) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });

    const { numero_control } = await params;
    const numeroControl = decodeURIComponent(numero_control);
    const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);

    const saldo = await getSaldoCompra(schema, ctx.auth.empresa_id, numeroControl);
    if (saldo.saldo <= 0) {
      return NextResponse.json(errorResponse("La compra ya está totalmente pagada."), { status: 400 });
    }

    const res = await registrarPagoProveedor({
      schema,
      empresaId: ctx.auth.empresa_id,
      numeroControl,
      monto: saldo.saldo,
      metodoPago: "efectivo",
      descontarCaja: body.descontar_caja === true,
      usuarioId: ctx.auth.usuarioCatalogId ?? null,
      usuarioNombre: (ctx.auth.nombre ?? ctx.auth.user?.email ?? "").trim() || null,
      usuarioEmail: ctx.auth.user?.email ?? null,
    });

    return NextResponse.json(successResponse({
      ok: true,
      numero_control: numeroControl,
      estado_pago: res.estado_pago,
      total: saldo.total,
      pagado: res.pagado,
      descontado_de_caja: body.descontar_caja === true,
    }));
  } catch (err) {
    if (err instanceof PagoProveedorError) {
      return NextResponse.json(errorResponse(err.message), { status: err.status });
    }
    const d = err instanceof Error ? err.message : String(err);
    console.error("[/api/compras/[numero_control]/pagar]", d);
    return NextResponse.json(errorResponse(`No se pudo marcar la compra como pagada: ${d}`), { status: 500 });
  }
}
