import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth, getTenantSupabaseFromAuthWithRol } from "@/lib/supabase/tenant-api";
import { isAdmin } from "@/lib/middleware/auth";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import { applyTokenSearch } from "@/lib/productos/token-search";

const MOV_COLS =
  "id, empresa_id, producto_id, producto_nombre, producto_sku, tipo, cantidad, costo_unitario, origen, " +
  "referencia, fecha, created_at, updated_at, created_by, usuario_nombre, estado, solicitado_por, " +
  "solicitado_por_nombre, aprobado_por, aprobado_at, rechazado_por, rechazado_at, rechazo_motivo";

/**
 * GET /api/inventario/movimientos
 *
 * Paginado + filtros server-side (compat Hostinger sin pool PG, via PostgREST).
 *
 * Query params:
 *   - q            : texto a buscar en producto_nombre/producto_sku (ILIKE)
 *   - tipo         : ENTRADA | SALIDA | AJUSTE
 *   - origen       : compra | venta | ajuste_manual | inventario_inicial
 *   - fecha_desde  : YYYY-MM-DD (incluye)
 *   - fecha_hasta  : YYYY-MM-DD (incluye, hasta fin de dia)
 *   - limit        : default 25, max 200
 *   - offset       : default 0
 *
 * Response: { movimientos: Movimiento[], total: number }
 *
 * El total usa count: "planned" (estimado via pg_stats) — mismo trade-off que
 * productos: precision suficiente para paginacion y ~10x mas rapido que
 * "exact" cuando hay miles de filas. Si la tabla esta vacia o muy chica,
 * planned puede devolver 0; lo corregimos con un fallback.
 */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;

    const url = new URL(request.url);
    const q = (url.searchParams.get("q") ?? "").trim();
    const tipo = (url.searchParams.get("tipo") ?? "").trim();
    const origen = (url.searchParams.get("origen") ?? "").trim();
    const estado = (url.searchParams.get("estado") ?? "").trim();
    const fechaDesde = (url.searchParams.get("fecha_desde") ?? "").trim();
    const fechaHasta = (url.searchParams.get("fecha_hasta") ?? "").trim();
    const limit = Math.max(1, Math.min(200, Number(url.searchParams.get("limit") ?? 25) || 25));
    const offset = Math.max(0, Number(url.searchParams.get("offset") ?? 0) || 0);

    let query = ctx.supabase
      .from("movimientos_inventario")
      .select(MOV_COLS, { count: "planned" })
      .eq("empresa_id", empresaId);

    if (tipo) query = query.eq("tipo", tipo);
    if (origen) query = query.eq("origen", origen);
    if (estado) query = query.eq("estado", estado);

    if (q.length > 0) {
      // Búsqueda por tokens (cada palabra en cualquier orden) sobre nombre y SKU.
      query = applyTokenSearch(query, q, ["producto_nombre", "producto_sku"]);
    }

    if (fechaDesde) {
      // gte: incluye el dia desde 00:00.
      query = query.gte("fecha", `${fechaDesde}T00:00:00`);
    }
    if (fechaHasta) {
      // lte: incluye el dia hasta 23:59:59.999.
      query = query.lte("fecha", `${fechaHasta}T23:59:59.999`);
    }

    query = query
      .order("fecha", { ascending: false })
      .range(offset, offset + limit - 1);

    const { data, error, count } = await query;
    if (error) throw new Error(error.message);

    // Fallback: si planned devolvio 0 pero hay datos en esta pagina, hacemos
    // un count exacto barato (solo cuando hace falta). Cubre tablas pequeñas
    // que pg_stats aun no estimo.
    let total = typeof count === "number" ? count : 0;
    if (total === 0 && (data?.length ?? 0) > 0) {
      const exact = await ctx.supabase
        .from("movimientos_inventario")
        .select("id", { count: "exact", head: true })
        .eq("empresa_id", empresaId);
      total = exact.count ?? data?.length ?? 0;
    }

    return NextResponse.json(
      successResponse({ movimientos: data ?? [], total })
    );
  } catch (err) {
    console.error("[/api/inventario/movimientos GET]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudieron cargar los movimientos."), { status: 500 });
  }
}

/**
 * POST /api/inventario/movimientos
 *
 * Crea un movimiento de stock. Autorización por rol:
 *  - ADMIN: el movimiento se aprueba al toque (estado 'aprobado') y se aplica al
 *    stock del producto (salvo inventario_inicial, que ya nace con el stock).
 *  - VENDEDOR: queda como SOLICITUD (estado 'pendiente') y NO toca el stock hasta
 *    que un administrador la apruebe desde Inventario → Movimientos.
 *
 * Reemplaza el alta directa browser→DB (antes en saveMovimiento), que no tenía
 * control de rol.
 */
export async function POST(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuthWithRol(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;
    const sb = ctx.supabase;
    const esAdmin = isAdmin(ctx.auth);

    let body: Record<string, unknown>;
    try {
      body = (await request.json()) as Record<string, unknown>;
    } catch {
      return NextResponse.json(errorResponse("JSON inválido."), { status: 400 });
    }

    const productoId = String(body.producto_id ?? "").trim();
    const tipo = String(body.tipo ?? "").trim().toUpperCase();
    const origen = String(body.origen ?? "ajuste_manual").trim();
    const cantidad = Number(body.cantidad);
    if (!productoId) return NextResponse.json(errorResponse("Falta el producto."), { status: 400 });
    if (tipo !== "ENTRADA" && tipo !== "SALIDA" && tipo !== "AJUSTE") {
      return NextResponse.json(errorResponse("Tipo de movimiento inválido."), { status: 400 });
    }
    if (!Number.isFinite(cantidad) || cantidad === 0) {
      return NextResponse.json(errorResponse("Ingresá una cantidad válida."), { status: 400 });
    }

    // Producto (stock actual + nombre/sku para el snapshot).
    const pQ = await sb
      .from("productos")
      .select("id, nombre, sku, stock_actual")
      .eq("empresa_id", empresaId)
      .eq("id", productoId)
      .maybeSingle();
    if (pQ.error) throw new Error(pQ.error.message);
    if (!pQ.data) return NextResponse.json(errorResponse("Producto no encontrado."), { status: 404 });
    const prod = pQ.data as { nombre: string; sku: string | null; stock_actual: number | string };

    // Delta: ENTRADA suma, SALIDA resta, AJUSTE lleva el signo en la cantidad.
    const delta = tipo === "ENTRADA" ? Math.abs(cantidad) : tipo === "SALIDA" ? -Math.abs(cantidad) : cantidad;
    const estado = esAdmin ? "aprobado" : "pendiente";

    const nowIso = new Date().toISOString();
    const fecha = typeof body.fecha === "string" && body.fecha.trim() ? body.fecha : nowIso;
    const usuarioId = ctx.auth.usuarioCatalogId ?? null;
    const usuarioNombre = ctx.auth.nombre ?? ctx.auth.user?.email ?? null;

    const insertRow: Record<string, unknown> = {
      empresa_id: empresaId,
      producto_id: productoId,
      producto_nombre: String(body.producto_nombre ?? prod.nombre ?? ""),
      producto_sku: String(body.producto_sku ?? prod.sku ?? ""),
      tipo,
      cantidad,
      costo_unitario: Number(body.costo_unitario) || 0,
      origen,
      referencia: body.referencia != null && String(body.referencia).trim() !== "" ? String(body.referencia) : null,
      fecha,
      estado,
      created_by: usuarioId,
      usuario_nombre: usuarioNombre,
    };
    if (esAdmin) {
      insertRow.aprobado_por = usuarioId;
      insertRow.aprobado_at = nowIso;
    } else {
      insertRow.solicitado_por = usuarioId;
      insertRow.solicitado_por_nombre = usuarioNombre;
    }

    const ins = await sb.from("movimientos_inventario").insert(insertRow).select(MOV_COLS).single();
    if (ins.error) throw new Error(ins.error.message);

    // Aplicar stock SOLO si se aprobó (admin) y no es inventario_inicial.
    if (esAdmin && origen !== "inventario_inicial") {
      const nuevoStock = Math.max(0, (Number(prod.stock_actual) || 0) + delta);
      const upd = await sb
        .from("productos")
        .update({ stock_actual: nuevoStock })
        .eq("id", productoId)
        .eq("empresa_id", empresaId);
      if (upd.error) {
        console.error("[/api/inventario/movimientos POST] update stock:", upd.error.message);
      }
    }

    return NextResponse.json(successResponse({ movimiento: ins.data, estado }));
  } catch (err) {
    console.error("[/api/inventario/movimientos POST]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo registrar el movimiento."), { status: 500 });
  }
}
