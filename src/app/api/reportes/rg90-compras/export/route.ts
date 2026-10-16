import { NextRequest } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getReporteRG90Compras } from "@/lib/reportes/server/rg90-compras-pg";
import { asuncionMesBoundsUtc, normalizarMes } from "@/lib/fechas/asuncion-bounds";
import { sheetFromRows, buildXlsxBufferSheets, xlsxResponseHeaders } from "@/lib/excel/export";
import type { Rg90CompraRow } from "@/lib/reportes/rg90-compras/types";

const TIPO_LABEL: Record<string, string> = { factura: "Factura", nota_credito: "Nota de crédito" };
const ID_LABEL: Record<number, string> = { 11: "RUC", 12: "Cédula", 15: "Sin nombre" };
const COND_LABEL: Record<number, string> = { 1: "Contado", 2: "Crédito" };

const libroCols = [
  { header: "Fecha", value: (x: Rg90CompraRow) => (x.fecha ? new Date(`${x.fecha}T00:00:00`) : ""), width: 12 },
  { header: "Tipo", value: (x: Rg90CompraRow) => TIPO_LABEL[x.tipo] ?? x.tipo, width: 16 },
  { header: "Cód. comp.", value: (x: Rg90CompraRow) => x.codigoComprobante, width: 10 },
  { header: "N° comprobante", value: (x: Rg90CompraRow) => x.numeroComprobante, width: 18 },
  { header: "Timbrado", value: (x: Rg90CompraRow) => x.timbrado, width: 12 },
  { header: "Tipo ident.", value: (x: Rg90CompraRow) => ID_LABEL[x.codigoTipoIdentificacion] ?? x.codigoTipoIdentificacion, width: 12 },
  { header: "RUC / ident.", value: (x: Rg90CompraRow) => x.numeroIdentificacion, width: 16 },
  { header: "Proveedor", value: (x: Rg90CompraRow) => x.nombre, width: 32 },
  { header: "Condición", value: (x: Rg90CompraRow) => COND_LABEL[x.codigoCondicion] ?? x.codigoCondicion, width: 10 },
  { header: "Gravado 10%", value: (x: Rg90CompraRow) => x.gravado10, width: 14 },
  { header: "Gravado 5%", value: (x: Rg90CompraRow) => x.gravado5, width: 14 },
  { header: "Exentas", value: (x: Rg90CompraRow) => x.exento, width: 14 },
  { header: "Total", value: (x: Rg90CompraRow) => x.total, width: 16 },
  { header: "Moneda", value: (x: Rg90CompraRow) => x.moneda, width: 8 },
  { header: "Comp. asociado (NC)", value: (x: Rg90CompraRow) => x.comprobanteAsociado ?? "", width: 18 },
];

/**
 * GET /api/reportes/rg90-compras/export?mes=YYYY-MM → XLSX (Libro de Compras RG90).
 * Hojas: Resumen + Libro de Compras (incluidas) + Compras No RG90 (aparte).
 */
export async function GET(request: NextRequest) {
  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new Response("Unauthorized", { status: 401 });
  try {
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const mes = normalizarMes(new URL(request.url).searchParams.get("mes"));
    const { start, end } = asuncionMesBoundsUtc(mes);
    const r = await getReporteRG90Compras(schema, ctx.auth.empresa_id, { mes, start, end, mesInicio: `${mes}-01` });

    const resumen = [
      { concepto: "Reporte", valor: "Libro de Compras (RG90)" },
      { concepto: "Período", valor: mes },
      { concepto: "RUC emisor", valor: r.rucEmisor || "—" },
      { concepto: "Campo 'Incluir en RG90' disponible", valor: r.flagDisponible ? "Sí" : "No (migración pendiente)" },
      { concepto: "Comprobantes incluidos", valor: r.totales.comprobantes },
      { concepto: "— Facturas (tipo 109)", valor: r.totalesFacturas.comprobantes },
      { concepto: "— Notas de crédito (tipo 110)", valor: r.totalesNotasCredito.comprobantes },
      { concepto: "Total facturas", valor: r.totalesFacturas.total },
      { concepto: "Total notas de crédito", valor: r.totalesNotasCredito.total },
      { concepto: "Total neto del período (Facturas − NC)", valor: r.neto.total },
      { concepto: "Gravado 10% neto (IVA incl.)", valor: r.neto.gravado10 },
      { concepto: "Gravado 5% neto (IVA incl.)", valor: r.neto.gravado5 },
      { concepto: "Exentas / no gravado neto", valor: r.neto.exento },
      { concepto: "Comprobantes No RG90 (reporte aparte)", valor: r.totalesNoRg90.comprobantes },
      { concepto: "Total No RG90", valor: r.totalesNoRg90.total },
      { concepto: "Comprobantes en moneda extranjera (excluidos del TXT)", valor: r.excluidosMonedaExtranjera },
    ];

    const buf = buildXlsxBufferSheets([
      sheetFromRows("Resumen", resumen, [
        { header: "Concepto", value: (x) => x.concepto, width: 48 },
        { header: "Valor", value: (x) => x.valor, width: 24 },
      ]),
      sheetFromRows("Libro de Compras", r.rows, libroCols),
      sheetFromRows("Compras No RG90", r.rowsNoRg90, libroCols),
    ]);
    return new Response(new Uint8Array(buf), { status: 200, headers: xlsxResponseHeaders(`rg90-libro-compras-${mes}`) });
  } catch (err) {
    console.error("[/api/reportes/rg90-compras/export]", err instanceof Error ? err.message : err);
    return new Response("No se pudo generar el Excel", { status: 500 });
  }
}
