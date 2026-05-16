import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  insertProducto,
  insertMovimientoInicial,
  rowToProductoApi,
  DuplicadoError,
} from "@/lib/inventario/server/productos-pg";

/**
 * POST /api/productos
 *
 * Alta server-side via PG directo (soporta tenants `erp_*` NO expuestos por
 * PostgREST, evita PGRST106 "Invalid schema"). Si stock_actual > 0, graba
 * movimiento de inventario_inicial en el mismo handler.
 */
export async function POST(request: NextRequest) {
  try {
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

    const nombre = String(body.nombre ?? "").trim();
    const sku = String(body.sku ?? "").trim();
    if (!nombre) return NextResponse.json(errorResponse("El nombre es obligatorio."), { status: 400 });
    if (!sku) return NextResponse.json(errorResponse("El SKU es obligatorio."), { status: 400 });

    const codigoBarrasRaw = body.codigo_barras != null ? String(body.codigo_barras).trim() : "";
    const codigoBarras = codigoBarrasRaw || null;
    const codigoBarrasInterno = codigoBarras != null && body.codigo_barras_interno === true;
    const stockActual = Number(body.stock_actual ?? 0) || 0;
    const costoPromedio = Number(body.costo_promedio ?? 0) || 0;
    const stockMinimo = Number(body.stock_minimo ?? 0) || 0;
    const precioVenta = Number(body.precio_venta ?? 0) || 0;
    const unidadMedida = String(body.unidad_medida ?? "Unidad").trim() || "Unidad";
    const metodoValuacion =
      body.metodo_valuacion === "FIFO" || body.metodo_valuacion === "LIFO"
        ? (body.metodo_valuacion as "FIFO" | "LIFO")
        : "CPP";

    try {
      const row = await insertProducto(schema, empresaId, {
        nombre,
        sku,
        costo_promedio: costoPromedio,
        precio_venta: precioVenta,
        stock_actual: stockActual,
        stock_minimo: stockMinimo,
        unidad_medida: unidadMedida,
        metodo_valuacion: metodoValuacion,
        codigo_barras: codigoBarras,
        codigo_barras_interno: codigoBarrasInterno,
      });

      // Inventario inicial (mismo schema, via PG directo).
      if (stockActual > 0) {
        try {
          await insertMovimientoInicial(schema, empresaId, {
            producto_id: row.id,
            producto_nombre: row.nombre,
            producto_sku: row.sku,
            cantidad: stockActual,
            costo_unitario: costoPromedio,
          });
        } catch (movErr) {
          console.error("[/api/productos] inventario_inicial fallo", {
            schema,
            empresaId,
            productoId: row.id,
            message: movErr instanceof Error ? movErr.message : String(movErr),
          });
          // No revertimos el producto; el alta principal queda.
        }
      }

      return NextResponse.json(successResponse({ producto: rowToProductoApi(row) }));
    } catch (err) {
      if (err instanceof DuplicadoError) {
        return NextResponse.json(errorResponse(err.message), { status: 409 });
      }
      console.error("[/api/productos POST]", {
        schema,
        empresaId,
        message: err instanceof Error ? err.message : String(err),
        code: (err as { code?: string })?.code,
      });
      return NextResponse.json(
        errorResponse("No se pudo guardar el producto. Revisá los datos e intentá nuevamente."),
        { status: 500 }
      );
    }
  } catch (err) {
    console.error("[/api/productos POST] outer", err instanceof Error ? err.message : err);
    return NextResponse.json(
      errorResponse("No se pudo guardar el producto. Revisá los datos e intentá nuevamente."),
      { status: 500 }
    );
  }
}
