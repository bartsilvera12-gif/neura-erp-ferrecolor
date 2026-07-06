import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { recibirOrdenCompra } from "@/lib/ordenes-compra/server/ordenes-compra-pg";

/**
 * POST /api/ordenes-compra/[numero]/recibir
 * Registra la compra real (impacta stock) tomando los ítems de la OC, con
 * numero de factura + timbrado. Marca la OC como 'recibida'.
 */
export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ numero: string }> }
) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const { numero } = await params;
    const empresaId = ctx.auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
    const req = (k: string) => body[k] != null && String(body[k]).trim() !== "";
    if (!req("nro_timbrado"))
      return NextResponse.json(errorResponse("Falta el N° de timbrado."), { status: 400 });
    if (!req("numero_factura"))
      return NextResponse.json(errorResponse("Falta el N° de factura."), { status: 400 });

    const str = (k: string) => (req(k) ? String(body[k]).trim() : null);

    try {
      const out = await recibirOrdenCompra(schema, empresaId, {
        numeroOc: decodeURIComponent(numero),
        nroTimbrado: String(body.nro_timbrado).trim(),
        numeroFactura: String(body.numero_factura).trim(),
        tipoPago: body.tipo_pago === "credito" ? "credito" : "contado",
        plazoDias:
          body.plazo_dias != null && String(body.plazo_dias).trim() !== ""
            ? parseInt(String(body.plazo_dias), 10) || null
            : null,
        comprobante: {
          url: str("comprobante_url"),
          storage_path: str("comprobante_storage_path"),
          nombre: str("comprobante_nombre"),
          mime_type: str("comprobante_mime_type"),
        },
        createdBy: ctx.auth.usuarioCatalogId ?? null,
        usuarioNombre: ctx.auth.user?.email ?? null,
      });
      return NextResponse.json(
        successResponse({ numero_control: out.numero_control, warning: out.movimiento_warning })
      );
    } catch (e) {
      const msg = e instanceof Error ? e.message : "No se pudo recibir la orden.";
      const status = /no encontrada/i.test(msg) ? 404 : /recibida o cancelada/i.test(msg) ? 409 : 500;
      console.error("[/api/ordenes-compra/[numero]/recibir]", { empresaId, msg });
      return NextResponse.json(errorResponse(msg), { status });
    }
  } catch (err) {
    console.error("[/api/ordenes-compra/[numero]/recibir] outer", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo recibir la orden de compra."), { status: 500 });
  }
}
