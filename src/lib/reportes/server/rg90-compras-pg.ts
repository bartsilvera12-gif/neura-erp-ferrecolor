/**
 * Agregado server-side del RG90 — Libro de COMPRAS (RG 90/2021 SET/DNIT).
 *
 * Reúne los comprobantes de compra del período (facturas de compra + notas de
 * crédito de compra), excluyendo anulados y los marcados "No RG90"
 * (`compras.incluir_rg90 = false`). Resuelve por comprobante el desglose
 * gravado 10% / 5% / exento + total (desde `compras.iva_tipo`), timbrado y
 * número del proveedor, e identificación del proveedor.
 *
 * Fuente: `compras` (PLANO: N líneas por numero_control) + `proveedores`, y
 * `notas_credito_compra` (+ items). Solo lectura.
 *
 * TOLERANCIA: si la columna `incluir_rg90` aún no existe (migración sin aplicar),
 * se asume todo incluido y `flagDisponible = false` (no rompe la página).
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";
import { assertAllowedChatDataSchema } from "@/lib/supabase/chat-data-schema";
import type { MesBounds } from "./reportes-pg";
import {
  COMP_FACTURA,
  COMP_NOTA_CREDITO,
  condicionDesdeTipo,
  formatNumeroComprobante,
  identificacionComprador,
  soloDigitos,
} from "@/lib/reportes/rg90/tablas";
import type {
  Rg90ComprasReporte,
  Rg90CompraRow,
  Rg90CompraTotales,
} from "@/lib/reportes/rg90-compras/types";

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool no disponible.");
  return p;
}

const num = (v: unknown): number => Number(v ?? 0) || 0;
const intGs = (v: unknown): number => Math.round(num(v));
const esGs = (m: string): boolean => { const x = (m || "GS").toUpperCase(); return x === "GS" || x === "PYG"; };
const monedaNorm = (m: string): string => (esGs(m) ? "GS" : "USD");

/** Primer día del mes siguiente (YYYY-MM-01). */
function mesSiguienteInicio(mesInicio: string): string {
  const [y, m] = mesInicio.split("-").map(Number);
  const ny = m === 12 ? y + 1 : y;
  const nm = m === 12 ? 1 : m + 1;
  return `${ny}-${String(nm).padStart(2, "0")}-01`;
}

async function rucEmisorDe(schema: string, empresaId: string): Promise<string> {
  const p = pool();
  const tS = quoteSchemaTable(schema, "empresa_sifen_config");
  const tA = quoteSchemaTable(schema, "empresa_autoimpresor_config");
  const [s, a] = await Promise.all([
    p.query<{ ruc: string }>(`SELECT ruc FROM ${tS} WHERE empresa_id=$1::uuid LIMIT 1`, [empresaId]).catch(() => ({ rows: [] as { ruc: string }[] })),
    p.query<{ ruc_emisor: string }>(`SELECT ruc_emisor FROM ${tA} WHERE empresa_id=$1::uuid LIMIT 1`, [empresaId]).catch(() => ({ rows: [] as { ruc_emisor: string }[] })),
  ]);
  return (s.rows[0]?.ruc || a.rows[0]?.ruc_emisor || "").trim();
}

async function columnaIncluirRg90Existe(schema: string): Promise<boolean> {
  const p = pool();
  const r = await p.query<{ n: number }>(
    `SELECT count(*)::int AS n FROM information_schema.columns
      WHERE table_schema=$1 AND table_name='compras' AND column_name='incluir_rg90'`,
    [schema]
  ).catch(() => ({ rows: [{ n: 0 }] }));
  return num(r.rows[0]?.n) > 0;
}

const vacio = (): Rg90CompraTotales => ({ comprobantes: 0, facturas: 0, notasCredito: 0, gravado10: 0, gravado5: 0, exento: 0, total: 0 });
function acumular(acc: Rg90CompraTotales, r: Rg90CompraRow): Rg90CompraTotales {
  acc.comprobantes += 1;
  if (r.tipo === "factura") acc.facturas += 1; else acc.notasCredito += 1;
  acc.gravado10 += r.gravado10;
  acc.gravado5 += r.gravado5;
  acc.exento += r.exento;
  acc.total += r.total;
  return acc;
}

export async function getReporteRG90Compras(
  schemaRaw: string,
  empresaId: string,
  b: MesBounds
): Promise<Rg90ComprasReporte> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const p = pool();
  const [rucEmisor, flag] = await Promise.all([rucEmisorDe(schema, empresaId), columnaIncluirRg90Existe(schema)]);
  const mesFin = mesSiguienteInicio(b.mesInicio);

  const tC = quoteSchemaTable(schema, "compras");
  const tP = quoteSchemaTable(schema, "proveedores");
  const tNC = quoteSchemaTable(schema, "notas_credito_compra");
  const tNCI = quoteSchemaTable(schema, "notas_credito_compra_items");

  const femision = `COALESCE(c.fecha_factura::date, (c.fecha AT TIME ZONE 'America/Asuncion')::date)`;
  const incAgg = flag ? "bool_and(COALESCE(c.incluir_rg90, true))" : "true";

  // ── Facturas de compra agrupadas por numero_control ──────────────────────────
  const comprasQ = p.query<{
    numero_control: string; fecha: string; numero_factura: string | null; nro_timbrado: string | null;
    prov_ruc: string | null; proveedor_nombre: string | null; moneda: string | null; tipo_pago: string | null;
    incluir_rg90: boolean; g10: number; g5: number; ex: number; tot: number;
  }>(
    `SELECT c.numero_control,
            MIN(${femision})::text AS fecha,
            MIN(c.numero_factura) AS numero_factura,
            MIN(c.nro_timbrado) AS nro_timbrado,
            MIN(p.ruc) AS prov_ruc,
            MIN(c.proveedor_nombre) AS proveedor_nombre,
            MIN(c.moneda) AS moneda,
            MIN(c.tipo_pago) AS tipo_pago,
            ${incAgg} AS incluir_rg90,
            COALESCE(SUM(c.total) FILTER (WHERE c.iva_tipo='10'),0)::float8 AS g10,
            COALESCE(SUM(c.total) FILTER (WHERE c.iva_tipo='5'),0)::float8 AS g5,
            COALESCE(SUM(c.total) FILTER (WHERE c.iva_tipo='exenta'),0)::float8 AS ex,
            COALESCE(SUM(c.total),0)::float8 AS tot
       FROM ${tC} c
       LEFT JOIN ${tP} p ON p.id=c.proveedor_id AND p.empresa_id=c.empresa_id
      WHERE c.empresa_id=$1::uuid AND COALESCE(c.estado,'') <> 'anulada'
        AND ${femision} >= $2::date AND ${femision} < $3::date
      GROUP BY c.numero_control
      ORDER BY MIN(${femision}) ASC, c.numero_control ASC`,
    [empresaId, b.mesInicio, mesFin]
  );

  // ── Notas de crédito de compra (confirmadas) del período ─────────────────────
  const ncQ = p.query<{
    id: string; fecha: string; nro_comprobante: string | null; nro_timbrado: string | null;
    prov_ruc: string | null; proveedor_nombre: string | null; moneda: string | null;
    origen_numero: string | null; origen_timbrado: string | null; origen_tipo_pago: string | null;
    origen_incluir: boolean; subtotal: number; monto_iva: number; total: number;
  }>(
    `SELECT nc.id,
            (nc.fecha AT TIME ZONE 'America/Asuncion')::date::text AS fecha,
            nc.nro_comprobante, nc.nro_timbrado,
            p.ruc AS prov_ruc, nc.proveedor_nombre, nc.moneda,
            oc.numero_factura AS origen_numero, oc.nro_timbrado AS origen_timbrado,
            oc.tipo_pago AS origen_tipo_pago,
            COALESCE(oc.incluir_rg90_val, true) AS origen_incluir,
            nc.subtotal::float8 AS subtotal, nc.monto_iva::float8 AS monto_iva, nc.total::float8 AS total
       FROM ${tNC} nc
       LEFT JOIN ${tP} p ON p.id=nc.proveedor_id AND p.empresa_id=nc.empresa_id
       LEFT JOIN LATERAL (
         SELECT c.numero_factura, c.nro_timbrado, c.tipo_pago, ${flag ? "COALESCE(c.incluir_rg90,true)" : "true"} AS incluir_rg90_val
           FROM ${tNCI} it JOIN ${tC} c ON c.id=it.compra_id
          WHERE it.nota_credito_compra_id=nc.id
          LIMIT 1
       ) oc ON true
      WHERE nc.empresa_id=$1::uuid AND nc.estado='confirmada'
        AND (nc.fecha AT TIME ZONE 'America/Asuncion')::date >= $2::date
        AND (nc.fecha AT TIME ZONE 'America/Asuncion')::date <  $3::date
      ORDER BY nc.fecha ASC`,
    [empresaId, b.mesInicio, mesFin]
  );

  // Desglose IVA de las NC desde sus items (gravado incluido = subtotal + iva).
  const ncItemsQ = p.query<{ nc_id: string; iva_tipo: string; total: number }>(
    `SELECT it.nota_credito_compra_id AS nc_id, it.iva_tipo,
            COALESCE(SUM(it.subtotal + it.monto_iva),0)::float8 AS total
       FROM ${tNCI} it
       JOIN ${tNC} nc ON nc.id=it.nota_credito_compra_id
      WHERE nc.empresa_id=$1::uuid AND nc.estado='confirmada'
        AND (nc.fecha AT TIME ZONE 'America/Asuncion')::date >= $2::date
        AND (nc.fecha AT TIME ZONE 'America/Asuncion')::date <  $3::date
      GROUP BY it.nota_credito_compra_id, it.iva_tipo`,
    [empresaId, b.mesInicio, mesFin]
  );

  const [compras, ncs, ncItems] = await Promise.all([comprasQ, ncQ, ncItemsQ]);

  // Mapa de desglose IVA por NC.
  const splitNc = new Map<string, { g10: number; g5: number; ex: number }>();
  for (const it of ncItems.rows) {
    let s = splitNc.get(it.nc_id);
    if (!s) { s = { g10: 0, g5: 0, ex: 0 }; splitNc.set(it.nc_id, s); }
    const t = num(it.total);
    if (it.iva_tipo === "10") s.g10 += t;
    else if (it.iva_tipo === "5") s.g5 += t;
    else s.ex += t;
  }

  const rowsAll: Rg90CompraRow[] = [];

  // Facturas de compra → filas.
  for (const c of compras.rows) {
    const ident = identificacionComprador({ ruc: c.prov_ruc, documento: null });
    rowsAll.push({
      id: c.numero_control,
      tipo: "factura",
      fecha: String(c.fecha).slice(0, 10),
      codigoComprobante: COMP_FACTURA,
      numeroComprobante: formatNumeroComprobante(c.numero_factura, "", ""),
      timbrado: soloDigitos(c.nro_timbrado),
      codigoTipoIdentificacion: ident.codigo,
      numeroIdentificacion: ident.numero,
      nombre: (c.proveedor_nombre || "").trim(),
      codigoCondicion: condicionDesdeTipo(c.tipo_pago),
      gravado10: intGs(c.g10),
      gravado5: intGs(c.g5),
      exento: intGs(c.ex),
      total: intGs(c.tot),
      moneda: monedaNorm(c.moneda || "GS"),
      incluirRg90: c.incluir_rg90 !== false,
      comprobanteAsociado: null,
      timbradoAsociado: null,
    });
  }

  // Notas de crédito de compra → filas.
  for (const nc of ncs.rows) {
    const ident = identificacionComprador({ ruc: nc.prov_ruc, documento: null });
    const s = splitNc.get(nc.id) ?? { g10: intGs(nc.total), g5: 0, ex: 0 };
    const total = intGs(num(s.g10) + num(s.g5) + num(s.ex)) || intGs(nc.total);
    rowsAll.push({
      id: nc.id,
      tipo: "nota_credito",
      fecha: String(nc.fecha).slice(0, 10),
      codigoComprobante: COMP_NOTA_CREDITO,
      numeroComprobante: formatNumeroComprobante(nc.nro_comprobante, "", ""),
      timbrado: soloDigitos(nc.nro_timbrado),
      codigoTipoIdentificacion: ident.codigo,
      numeroIdentificacion: ident.numero,
      nombre: (nc.proveedor_nombre || "").trim(),
      codigoCondicion: condicionDesdeTipo(nc.origen_tipo_pago),
      gravado10: intGs(s.g10),
      gravado5: intGs(s.g5),
      exento: intGs(s.ex),
      total,
      moneda: monedaNorm(nc.moneda || "GS"),
      incluirRg90: nc.origen_incluir !== false,
      comprobanteAsociado: nc.origen_numero ? formatNumeroComprobante(nc.origen_numero, "", "") : null,
      timbradoAsociado: nc.origen_timbrado ? soloDigitos(nc.origen_timbrado) : null,
    });
  }

  rowsAll.sort((a, z) => (a.fecha < z.fecha ? -1 : a.fecha > z.fecha ? 1 : a.numeroComprobante.localeCompare(z.numeroComprobante)));

  const rows = rowsAll.filter((r) => r.incluirRg90);
  const rowsNoRg90 = rowsAll.filter((r) => !r.incluirRg90);

  const totales = rows.reduce(acumular, vacio());
  const totalesFacturas = rows.filter((r) => r.tipo === "factura").reduce(acumular, vacio());
  const totalesNotasCredito = rows.filter((r) => r.tipo === "nota_credito").reduce(acumular, vacio());
  const neto = {
    gravado10: totalesFacturas.gravado10 - totalesNotasCredito.gravado10,
    gravado5: totalesFacturas.gravado5 - totalesNotasCredito.gravado5,
    exento: totalesFacturas.exento - totalesNotasCredito.exento,
    total: totalesFacturas.total - totalesNotasCredito.total,
  };
  const totalesNoRg90 = rowsNoRg90.reduce(acumular, vacio());
  const excluidosMonedaExtranjera = rows.filter((r) => r.moneda !== "GS").length;

  return {
    mes: b.mes,
    rucEmisor,
    flagDisponible: flag,
    rows,
    rowsNoRg90,
    totales,
    totalesFacturas,
    totalesNotasCredito,
    neto,
    totalesNoRg90,
    excluidosMonedaExtranjera,
  };
}
