import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { getProyeccionInventario } from "@/lib/reportes/server/proyeccion-inventario-pg";
import { asuncionRangeBoundsUtc } from "@/lib/fechas/asuncion-bounds";
import { productoMatchesQuery } from "@/lib/productos/token-search";
import type { EstadoStock } from "@/lib/reportes/proyeccion";

const TZ = "America/Asuncion";
const DIAS_OPCIONES = [30, 60, 90];
const PAGE_SIZES = [25, 50, 100, 200];
const ESTADOS: EstadoStock[] = ["sin_stock", "sin_movimiento", "critico", "bajo", "normal", "sobrestock"];

/** Bordes UTC de "los últimos N días" (Asunción) + etiquetas YYYY-MM-DD. */
function ultimosDiasBounds(dias: number) {
  const hoy = new Date();
  const inicio = new Date(hoy);
  inicio.setDate(inicio.getDate() - dias);
  const hasta = hoy.toLocaleDateString("en-CA", { timeZone: TZ });
  const desde = inicio.toLocaleDateString("en-CA", { timeZone: TZ });
  const { start, end } = asuncionRangeBoundsUtc(desde, hasta);
  return { start, end, desde, hasta };
}

/** GET /api/reportes/proyeccion-inventario?dias=30|60|90&page=&pageSize=&estado=&q= */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);

    const sp = new URL(request.url).searchParams;
    const rawDias = parseInt(sp.get("dias") ?? "30", 10);
    const dias = DIAS_OPCIONES.includes(rawDias) ? rawDias : 30;
    const b = ultimosDiasBounds(dias);

    const full = await getProyeccionInventario(schema, ctx.auth.empresa_id, { ...b, dias });

    // Filtros + paginado server-side (el cálculo es global; se pagina la salida).
    const estado = sp.get("estado") as EstadoStock | null;
    const q = (sp.get("q") ?? "").trim();
    const rawSize = parseInt(sp.get("pageSize") ?? "25", 10);
    const pageSize = PAGE_SIZES.includes(rawSize) ? rawSize : 25;
    const page = Math.max(1, parseInt(sp.get("page") ?? "1", 10) || 1);

    let filtrados = full.productos;
    if (estado && ESTADOS.includes(estado)) filtrados = filtrados.filter((p) => p.estado === estado);
    if (q) filtrados = filtrados.filter((p) => productoMatchesQuery(q, p.nombre, p.sku));

    const total = filtrados.length;
    const start = (page - 1) * pageSize;
    const productos = filtrados.slice(start, start + pageSize);

    return NextResponse.json(
      successResponse({
        desde: full.desde,
        hasta: full.hasta,
        dias: full.dias,
        totales: full.totales,
        page,
        pageSize,
        total,
        productos,
      })
    );
  } catch (err) {
    console.error("[/api/reportes/proyeccion-inventario]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo calcular la proyección de inventario."), { status: 500 });
  }
}
