import { NextRequest } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getReporteRG90Compras } from "@/lib/reportes/server/rg90-compras-pg";
import { asuncionMesBoundsUtc, normalizarMes } from "@/lib/fechas/asuncion-bounds";
import { rucSinDv } from "@/lib/reportes/rg90/tablas";
import {
  filtrarComprasParaTxt,
  nombreArchivoRg90Compras,
  rg90TxtResponseHeaders,
  serializarRg90Compras,
  type Rg90Delimitador,
} from "@/lib/reportes/rg90-compras/txt";

/**
 * GET /api/reportes/rg90-compras/txt?mes=YYYY-MM&formato=csv|txt&usd=1
 *   → archivo de importación a Marangatu (registro de compras RG90).
 *
 * Incluye solo comprobantes marcados "Incluir en RG90", en GS (salvo usd=1).
 */
export async function GET(request: NextRequest) {
  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new Response("Unauthorized", { status: 401 });
  try {
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const url = new URL(request.url);
    const mes = normalizarMes(url.searchParams.get("mes"));
    const delimitador: Rg90Delimitador = url.searchParams.get("formato") === "txt" ? "txt" : "csv";
    const incluirMonedaExtranjera = url.searchParams.get("usd") === "1";

    const { start, end } = asuncionMesBoundsUtc(mes);
    const r = await getReporteRG90Compras(schema, ctx.auth.empresa_id, { mes, start, end, mesInicio: `${mes}-01` });

    const rows = filtrarComprasParaTxt(r, { incluirMonedaExtranjera });
    const contenido = serializarRg90Compras(rows, { delimitador });
    const filename = nombreArchivoRg90Compras(rucSinDv(r.rucEmisor), mes);

    const body = "﻿" + contenido; // BOM UTF-8
    return new Response(body, { status: 200, headers: rg90TxtResponseHeaders(filename, delimitador) });
  } catch (err) {
    console.error("[/api/reportes/rg90-compras/txt]", err instanceof Error ? err.message : err);
    return new Response("No se pudo generar el archivo RG90 de compras", { status: 500 });
  }
}
