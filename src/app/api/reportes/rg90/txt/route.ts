import { NextRequest } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getReporteRG90 } from "@/lib/reportes/server/rg90-pg";
import { asuncionMesBoundsUtc, normalizarMes } from "@/lib/fechas/asuncion-bounds";
import { rucSinDv } from "@/lib/reportes/rg90/tablas";
import {
  filtrarParaTxt,
  nombreArchivoRg90,
  rg90TxtResponseHeaders,
  serializarRg90,
  type Rg90Delimitador,
} from "@/lib/reportes/rg90/txt";

/**
 * GET /api/reportes/rg90/txt?mes=YYYY-MM&formato=csv|txt&todos=1&usd=1
 *   → archivo de importación a Marangatu (registro de ventas RG90).
 *
 * Por defecto incluye SOLO comprobantes impresos en GS (la SET ya posee los
 * electrónicos). `todos=1` incluye electrónicos; `usd=1` incluye moneda extranjera.
 */
export async function GET(request: NextRequest) {
  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new Response("Unauthorized", { status: 401 });
  try {
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const url = new URL(request.url);
    const mes = normalizarMes(url.searchParams.get("mes"));
    const delimitador: Rg90Delimitador = url.searchParams.get("formato") === "txt" ? "txt" : "csv";
    const incluirElectronicos = url.searchParams.get("todos") === "1";
    const incluirMonedaExtranjera = url.searchParams.get("usd") === "1";

    const { start, end } = asuncionMesBoundsUtc(mes);
    const r = await getReporteRG90(schema, ctx.auth.empresa_id, { mes, start, end, mesInicio: `${mes}-01` });

    const rows = filtrarParaTxt(r, { incluirElectronicos, incluirMonedaExtranjera });
    const contenido = serializarRg90(rows, { delimitador });
    const filename = nombreArchivoRg90(rucSinDv(r.rucEmisor), mes);

    // BOM UTF-8 para compatibilidad con Excel/Marangatu.
    const body = "﻿" + contenido;
    return new Response(body, { status: 200, headers: rg90TxtResponseHeaders(filename, delimitador) });
  } catch (err) {
    console.error("[/api/reportes/rg90/txt]", err instanceof Error ? err.message : err);
    return new Response("No se pudo generar el archivo RG90", { status: 500 });
  }
}
