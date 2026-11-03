import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  getSaldoCompra, registrarPagoProveedor, PagoProveedorError,
  type MetodoPagoProveedor,
} from "@/lib/compras/server/pagos-proveedores-pg";

function fallo(err: unknown, msg: string) {
  if (err instanceof PagoProveedorError) {
    return NextResponse.json(errorResponse(err.message), { status: err.status });
  }
  const d = err instanceof Error ? err.message : String(err);
  console.error("[/api/compras/[numero_control]/pagos]", d);
  return NextResponse.json(errorResponse(`${msg}: ${d}`), { status: 500 });
}

/** GET — total, pagado y saldo de la compra. */
export async function GET(request: NextRequest, ctxParams: { params: Promise<{ numero_control: string }> }) {
  try {
    const { numero_control } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const saldo = await getSaldoCompra(schema, ctx.auth.empresa_id, decodeURIComponent(numero_control));
    return NextResponse.json(successResponse(saldo));
  } catch (err) {
    return fallo(err, "No se pudo cargar el saldo");
  }
}

/** POST — registra un pago total o parcial. Body: { monto, metodo_pago?, descontar_caja?, ... } */
export async function POST(request: NextRequest, ctxParams: { params: Promise<{ numero_control: string }> }) {
  try {
    const { numero_control } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);

    const res = await registrarPagoProveedor({
      schema,
      empresaId: ctx.auth.empresa_id,
      numeroControl: decodeURIComponent(numero_control),
      monto: Number(body.monto),
      metodoPago: (body.metodo_pago as MetodoPagoProveedor) ?? "efectivo",
      fechaPago: typeof body.fecha_pago === "string" ? body.fecha_pago : null,
      referencia: body.referencia ? String(body.referencia) : null,
      observaciones: body.observaciones ? String(body.observaciones) : null,
      descontarCaja: body.descontar_caja === true,
      usuarioId: ctx.auth.usuarioCatalogId ?? null,
      usuarioNombre: (ctx.auth.nombre ?? ctx.auth.user?.email ?? "").trim() || null,
      usuarioEmail: ctx.auth.user?.email ?? null,
    });
    return NextResponse.json(successResponse(res));
  } catch (err) {
    return fallo(err, "No se pudo registrar el pago");
  }
}
