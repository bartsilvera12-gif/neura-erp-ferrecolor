import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  updateProductoPg,
  rowToProductoApi,
  DuplicadoError,
} from "@/lib/inventario/server/productos-pg";

/**
 * PATCH /api/productos/[id]
 *
 * Actualizacion parcial via PG directo (soporta tenants no expuestos).
 * Aplica solo los campos presentes en el body. La capa PG valida ownership
 * (id + empresa_id en el WHERE).
 */
export async function PATCH(
  request: NextRequest,
  ctxParams: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await ctxParams.params;
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) {
      return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    }
    const empresaId = ctx.auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    let body: Record<string, unknown>;
    try {
      body = (await request.json()) as Record<string, unknown>;
    } catch {
      return NextResponse.json(errorResponse("JSON inválido."), { status: 400 });
    }

    const patch: Parameters<typeof updateProductoPg>[3] = {};
    if (body.nombre !== undefined) patch.nombre = String(body.nombre).trim();
    if (body.sku !== undefined) patch.sku = String(body.sku).trim();
    if (body.costo_promedio !== undefined) patch.costo_promedio = Number(body.costo_promedio) || 0;
    if (body.precio_venta !== undefined) patch.precio_venta = Number(body.precio_venta) || 0;
    if (body.stock_actual !== undefined) patch.stock_actual = Number(body.stock_actual) || 0;
    if (body.stock_minimo !== undefined) patch.stock_minimo = Number(body.stock_minimo) || 0;
    if (body.unidad_medida !== undefined) patch.unidad_medida = String(body.unidad_medida).trim() || "Unidad";
    if (body.metodo_valuacion !== undefined) {
      const mv = body.metodo_valuacion;
      patch.metodo_valuacion = mv === "FIFO" || mv === "LIFO" ? mv : "CPP";
    }
    if (body.codigo_barras !== undefined) {
      const cb = body.codigo_barras != null ? String(body.codigo_barras).trim() : "";
      patch.codigo_barras = cb || null;
    }
    if (body.codigo_barras_interno !== undefined) {
      patch.codigo_barras_interno = body.codigo_barras_interno === true;
    }
    if (body.imagen_path !== undefined) {
      const v = body.imagen_path != null ? String(body.imagen_path) : "";
      patch.imagen_path = v || null;
    }
    if (body.imagen_url !== undefined) {
      const v = body.imagen_url != null ? String(body.imagen_url) : "";
      patch.imagen_url = v || null;
    }

    try {
      const row = await updateProductoPg(schema, empresaId, id, patch);
      if (!row) {
        return NextResponse.json(errorResponse(API_ERRORS.NOT_FOUND), { status: 404 });
      }
      return NextResponse.json(successResponse({ producto: rowToProductoApi(row) }));
    } catch (err) {
      if (err instanceof DuplicadoError) {
        return NextResponse.json(errorResponse(err.message), { status: 409 });
      }
      console.error("[/api/productos/[id] PATCH]", {
        schema,
        empresaId,
        id,
        message: err instanceof Error ? err.message : String(err),
        code: (err as { code?: string })?.code,
      });
      return NextResponse.json(
        errorResponse("No se pudo actualizar el producto. Revisá los datos e intentá nuevamente."),
        { status: 500 }
      );
    }
  } catch (err) {
    console.error("[/api/productos/[id] PATCH] outer", err instanceof Error ? err.message : err);
    return NextResponse.json(
      errorResponse("No se pudo actualizar el producto."),
      { status: 500 }
    );
  }
}
