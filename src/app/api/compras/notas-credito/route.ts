import { NextRequest, NextResponse } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { successResponse, errorResponse } from "@/lib/api/response";
import { API_ERRORS } from "@/lib/api/errors";
import {
  listNotasCreditoCompra,
  crearNotaCreditoCompra,
} from "@/lib/compras/server/notas-credito-compra-pg";

/** GET /api/compras/notas-credito — lista NC de compra con items. */
export async function GET(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const notas = await listNotasCreditoCompra(schema, ctx.auth.empresa_id);
    return NextResponse.json(successResponse({ notas }));
  } catch (err) {
    console.error("[/api/compras/notas-credito GET]", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudieron cargar las notas de crédito de compra."), { status: 500 });
  }
}

/** POST /api/compras/notas-credito — crea NC de compra en borrador (sin impacto en stock). */
export async function POST(request: NextRequest) {
  try {
    const ctx = await getTenantSupabaseFromAuth(request);
    if (!ctx) return NextResponse.json(errorResponse(API_ERRORS.UNAUTHORIZED), { status: 401 });
    const empresaId = ctx.auth.empresa_id;
    const schema = await fetchDataSchemaForEmpresaId(empresaId);

    const body = (await request.json().catch(() => ({}))) as Record<string, unknown>;
    const proveedorId = String(body.proveedor_id ?? "").trim();
    if (!proveedorId) return NextResponse.json(errorResponse("Falta el proveedor."), { status: 400 });

    const rawItems = Array.isArray(body.items) ? body.items : [];
    const items = rawItems
      .map((it) => {
        const o = it as Record<string, unknown>;
        return { compra_id: String(o.compra_id ?? "").trim(), cantidad: Number(o.cantidad) || 0 };
      })
      .filter((it) => it.compra_id && it.cantidad > 0);
    if (items.length === 0)
      return NextResponse.json(errorResponse("Seleccioná al menos un producto con cantidad a acreditar."), { status: 400 });

    const str = (k: string) => {
      const v = body[k];
      return v != null && String(v).trim() !== "" ? String(v).trim() : null;
    };

    try {
      const nota = await crearNotaCreditoCompra(
        schema,
        empresaId,
        {
          proveedor_id: proveedorId,
          nro_comprobante: str("nro_comprobante"),
          nro_timbrado: str("nro_timbrado") ? str("nro_timbrado")!.toUpperCase() : null,
          motivo: str("motivo"),
          items,
        },
        {
          created_by: ctx.auth.usuarioCatalogId ?? null,
          usuario_nombre: ctx.auth.user?.email ?? null,
        }
      );
      return NextResponse.json(successResponse({ nota }));
    } catch (e) {
      const msg = e instanceof Error ? e.message : "No se pudo crear la nota de crédito de compra.";
      const code = (e as { code?: string })?.code;
      console.error("[/api/compras/notas-credito POST]", { schema, empresaId, msg, code });
      if (code === "23503")
        return NextResponse.json(errorResponse("Proveedor, compra o producto inválido."), { status: 400 });
      // Errores de validación de negocio llevan mensaje claro desde la capa PG.
      return NextResponse.json(errorResponse(msg), { status: 400 });
    }
  } catch (err) {
    console.error("[/api/compras/notas-credito POST] outer", err instanceof Error ? err.message : err);
    return NextResponse.json(errorResponse("No se pudo crear la nota de crédito de compra."), { status: 500 });
  }
}
