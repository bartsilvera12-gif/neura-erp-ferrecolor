import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { searchProductosPg } from "@/lib/inventario/server/productos-pg";
import { signProductoImagen } from "@/lib/inventario/imagen-storage";

interface ProductoSearchHit {
  id: string;
  nombre: string;
  sku: string;
  codigo_barras: string | null;
  codigo_barras_interno: boolean;
  precio_venta: number;
  stock_actual: number;
  unidad_medida: string;
  imagen_path: string | null;
  imagen_url: string | null;
}

const DEFAULT_LIMIT = 30;
const MAX_LIMIT = 100;

/**
 * GET /api/productos/search?q=...&limit=30
 *
 * Busqueda case-insensitive en nombre/sku/codigo_barras via PG directo
 * (soporta tenants no expuestos por PostgREST). Devuelve signed URL para
 * imagen cuando existe imagen_path.
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) {
      return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    }
    const { supabase, auth } = ctx;
    const empresaId = auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    const url = new URL(request.url);
    const qRaw = (url.searchParams.get("q") ?? "").trim();
    const q = qRaw.slice(0, 100);
    const limitParam = parseInt(url.searchParams.get("limit") ?? "", 10);
    const limit = Math.max(1, Math.min(MAX_LIMIT, Number.isFinite(limitParam) ? limitParam : DEFAULT_LIMIT));

    const rows = await searchProductosPg(schema, empresaId, q, limit);

    // Storage no depende de PostgREST schema; el client `supabase` sirve para firmar.
    const hits: ProductoSearchHit[] = await Promise.all(
      rows.map(async (r) => {
        const signed = r.imagen_path
          ? await signProductoImagen(supabase, r.imagen_path, 3600)
          : null;
        return {
          id: r.id,
          nombre: r.nombre,
          sku: r.sku,
          codigo_barras: r.codigo_barras,
          codigo_barras_interno: r.codigo_barras_interno === true,
          precio_venta: Number(r.precio_venta ?? 0),
          stock_actual: Number(r.stock_actual ?? 0),
          unidad_medida: r.unidad_medida,
          imagen_path: r.imagen_path,
          imagen_url: signed ?? r.imagen_url ?? null,
        };
      })
    );

    return NextResponse.json(successResponse({ items: hits, count: hits.length, q }));
  } catch (err) {
    console.error("[/api/productos/search]", err instanceof Error ? err.message : err);
    return NextResponse.json(
      errorResponse("No se pudo realizar la búsqueda. Intentá nuevamente."),
      { status: 500 }
    );
  }
}
