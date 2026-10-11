import { NextRequest } from "next/server";
import { getTenantSupabaseFromAuth } from "@/lib/supabase/tenant-api";
import { fetchDataSchemaForEmpresaId } from "@/lib/supabase/empresa-data-schema";
import { getReporteRG90 } from "@/lib/reportes/server/rg90-pg";
import { asuncionMesBoundsUtc, normalizarMes } from "@/lib/fechas/asuncion-bounds";
import { sheetFromRows, buildXlsxBufferSheets, xlsxResponseHeaders } from "@/lib/excel/export";
import type { Rg90VentaRow } from "@/lib/reportes/rg90/types";

const TIPO_LABEL: Record<string, string> = { factura: "Factura", nota_credito: "Nota de crédito" };
const ID_LABEL: Record<number, string> = { 11: "RUC", 12: "Cédula", 15: "Sin nombre" };
const COND_LABEL: Record<number, string> = { 1: "Contado", 2: "Crédito" };

/**
 * GET /api/reportes/rg90/export?mes=YYYY-MM → XLSX (Libro de Ventas RG90).
 * Hojas: Resumen + Libro de Ventas (todos los comprobantes del período).
 * Incluye electrónicos e impresos para revisión contable y cuadre de totales.
 */
export async function GET(request: NextRequest) {
  const ctx = await getTenantSupabaseFromAuth(request);
  if (!ctx) return new Response("Unauthorized", { status: 401 });
  try {
    const schema = await fetchDataSchemaForEmpresaId(ctx.auth.empresa_id);
    const mes = normalizarMes(new URL(request.url).searchParams.get("mes"));
    const { start, end } = asuncionMesBoundsUtc(mes);
    const r = await getReporteRG90(schema, ctx.auth.empresa_id, { mes, start, end, mesInicio: `${mes}-01` });

    const resumen = [
      { concepto: "Reporte", valor: "Libro de Ventas (RG90)" },
      { concepto: "Período", valor: mes },
      { concepto: "RUC emisor", valor: r.rucEmisor || "—" },
      { concepto: "Modo de facturación", valor: r.modoFacturacion },
      { concepto: "Comprobantes (total)", valor: r.totales.comprobantes },
      { concepto: "— Facturas (tipo 109)", valor: r.totalesFacturas.comprobantes },
      { concepto: "— Notas de crédito (tipo 110)", valor: r.totalesNotasCredito.comprobantes },
      // Totales por tipo y neto del período (Facturas − NC).
      { concepto: "Total facturas", valor: r.totalesFacturas.total },
      { concepto: "Total notas de crédito", valor: r.totalesNotasCredito.total },
      { concepto: "Total neto del período (Facturas − NC)", valor: r.neto.total },
      // Desglose IVA neto (facturas − notas de crédito).
      { concepto: "Gravado 10% neto (IVA incl.)", valor: r.neto.gravado10 },
      { concepto: "Gravado 5% neto (IVA incl.)", valor: r.neto.gravado5 },
      { concepto: "Exentas / no gravado neto", valor: r.neto.exento },
      { concepto: "Comprobantes impresos (para TXT Marangatu)", valor: r.totalesImpresos.comprobantes },
      { concepto: "Total impresos (GS)", valor: r.totalesImpresos.total },
      { concepto: "Comprobantes en moneda extranjera (excluidos del TXT)", valor: r.excluidosMonedaExtranjera },
    ];

    const libroCols = [
      { header: "Fecha", value: (x: Rg90VentaRow) => (x.fecha ? new Date(`${x.fecha}T00:00:00`) : ""), width: 12 },
      { header: "Tipo", value: (x: Rg90VentaRow) => TIPO_LABEL[x.tipo] ?? x.tipo, width: 16 },
      { header: "Cód. comp.", value: (x: Rg90VentaRow) => x.codigoComprobante, width: 10 },
      { header: "N° comprobante", value: (x: Rg90VentaRow) => x.numeroComprobante, width: 18 },
      { header: "Timbrado", value: (x: Rg90VentaRow) => x.timbrado, width: 12 },
      { header: "Tipo ident.", value: (x: Rg90VentaRow) => ID_LABEL[x.codigoTipoIdentificacion] ?? x.codigoTipoIdentificacion, width: 12 },
      { header: "N° identificación", value: (x: Rg90VentaRow) => x.numeroIdentificacion, width: 16 },
      { header: "Nombre / razón social", value: (x: Rg90VentaRow) => x.nombre, width: 32 },
      { header: "Condición", value: (x: Rg90VentaRow) => COND_LABEL[x.codigoCondicion] ?? x.codigoCondicion, width: 10 },
      { header: "Gravado 10%", value: (x: Rg90VentaRow) => x.gravado10, width: 14 },
      { header: "Gravado 5%", value: (x: Rg90VentaRow) => x.gravado5, width: 14 },
      { header: "Exentas", value: (x: Rg90VentaRow) => x.exento, width: 14 },
      { header: "Total", value: (x: Rg90VentaRow) => x.total, width: 16 },
      { header: "Moneda", value: (x: Rg90VentaRow) => x.moneda, width: 8 },
      { header: "Electrónico", value: (x: Rg90VentaRow) => (x.electronico ? "Sí" : "No"), width: 11 },
      { header: "Comp. asociado (NC)", value: (x: Rg90VentaRow) => x.comprobanteAsociado ?? "", width: 18 },
    ];

    const buf = buildXlsxBufferSheets([
      sheetFromRows("Resumen", resumen, [
        { header: "Concepto", value: (x) => x.concepto, width: 46 },
        { header: "Valor", value: (x) => x.valor, width: 24 },
      ]),
      sheetFromRows("Libro de Ventas", r.rows, libroCols),
    ]);
    return new Response(new Uint8Array(buf), { status: 200, headers: xlsxResponseHeaders(`rg90-libro-ventas-${mes}`) });
  } catch (err) {
    console.error("[/api/reportes/rg90/export]", err instanceof Error ? err.message : err);
    return new Response("No se pudo generar el Excel", { status: 500 });
  }
}
