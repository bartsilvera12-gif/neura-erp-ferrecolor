/**
 * Agregado server-side del RG90 — Libro de Ventas (RG 90/2021 SET/DNIT).
 *
 * Reúne los comprobantes de venta del período (facturas + notas de crédito),
 * excluyendo anulados, y resuelve por comprobante el desglose gravado 10% / 5%
 * / exento + total, el timbrado y número, y la identificación del comprador.
 *
 * Fuente: `facturas` + `factura_items` + `clientes`, `nota_credito`
 * (+ electrónicas) y la config fiscal de la empresa (`empresa_sifen_config`,
 * `empresa_autoimpresor_config`, `empresa_facturacion_modo`). Solo lectura.
 *
 * Reglas:
 *  - Anuladas excluidas (facturas.estado <> 'Anulado'; NC estado_erp anulados).
 *  - El RG90 se reporta en GS: los comprobantes en USD se marcan y no entran al TXT.
 *  - "electrónico" = empresa en modo SIFEN o comprobante con DE electrónico. El
 *    archivo de importación a Marangatu excluye los electrónicos (ver txt.ts).
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
  tasaIvaLinea,
} from "@/lib/reportes/rg90/tablas";
import type {
  Rg90Reporte,
  Rg90Totales,
  Rg90VentaRow,
} from "@/lib/reportes/rg90/types";

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool no disponible.");
  return p;
}

const num = (v: unknown): number => Number(v ?? 0) || 0;
const intGs = (v: unknown): number => Math.round(num(v));

interface ConfigFiscal {
  modo: string;
  rucEmisor: string;
  sifen: { timbrado: string; est: string; punto: string } | null;
  autoimpresor: { timbrado: string; est: string; punto: string } | null;
}

/** Desglose IVA por comprobante (acumulado de sus líneas). */
interface Split {
  gravado10: number;
  gravado5: number;
  exento: number;
  total: number;
}

const splitVacio = (): Split => ({ gravado10: 0, gravado5: 0, exento: 0, total: 0 });

function acumularLinea(s: Split, subtotal: number, iva: number, total: number, tipoIva: string | null) {
  const tasa = tasaIvaLinea({ subtotal, iva, tipoIva });
  if (tasa === 10) s.gravado10 += total;
  else if (tasa === 5) s.gravado5 += total;
  else s.exento += total;
  s.total += total;
}

/** Composición porcentual de una factura prorrateada a un monto (para NC parciales). */
function prorratear(origen: Split, monto: number): Split {
  const base = origen.total > 0 ? origen.total : 0;
  if (base <= 0) return { gravado10: 0, gravado5: 0, exento: Math.round(monto), total: Math.round(monto) };
  const m = Math.round(monto);
  const g10 = Math.round((origen.gravado10 / base) * m);
  const g5 = Math.round((origen.gravado5 / base) * m);
  const ex = m - g10 - g5; // el resto para que cuadre el total
  return { gravado10: g10, gravado5: g5, exento: ex, total: m };
}

/** Lee la config fiscal de la empresa (modo + timbrado/estab/punto + RUC). */
async function leerConfig(schema: string, empresaId: string): Promise<ConfigFiscal> {
  const p = pool();
  const tModo = quoteSchemaTable(schema, "empresa_facturacion_modo");
  const tSifen = quoteSchemaTable(schema, "empresa_sifen_config");
  const tAuto = quoteSchemaTable(schema, "empresa_autoimpresor_config");

  const [modoR, sifenR, autoR] = await Promise.all([
    p.query<{ modo: string }>(`SELECT modo FROM ${tModo} WHERE empresa_id=$1::uuid LIMIT 1`, [empresaId]).catch(() => ({ rows: [] as { modo: string }[] })),
    p.query<{ ruc: string; timbrado_numero: string; establecimiento: string; punto_expedicion: string }>(
      `SELECT ruc, timbrado_numero, establecimiento, punto_expedicion FROM ${tSifen} WHERE empresa_id=$1::uuid LIMIT 1`, [empresaId]
    ).catch(() => ({ rows: [] })),
    p.query<{ ruc_emisor: string; timbrado_numero: string; establecimiento_codigo: string; punto_expedicion_codigo: string }>(
      `SELECT ruc_emisor, timbrado_numero, establecimiento_codigo, punto_expedicion_codigo FROM ${tAuto} WHERE empresa_id=$1::uuid LIMIT 1`, [empresaId]
    ).catch(() => ({ rows: [] })),
  ]);

  const sifen = sifenR.rows[0]
    ? { timbrado: soloDigitos(sifenR.rows[0].timbrado_numero), est: sifenR.rows[0].establecimiento, punto: sifenR.rows[0].punto_expedicion }
    : null;
  const autoimpresor = autoR.rows[0]
    ? { timbrado: soloDigitos(autoR.rows[0].timbrado_numero), est: autoR.rows[0].establecimiento_codigo, punto: autoR.rows[0].punto_expedicion_codigo }
    : null;
  const rucEmisor = (sifenR.rows[0]?.ruc || autoR.rows[0]?.ruc_emisor || "").trim();

  return { modo: modoR.rows[0]?.modo || "sin_factura_fiscal", rucEmisor, sifen, autoimpresor };
}

/** Primer día del mes siguiente (YYYY-MM-01) para acotar columnas `date`. */
function mesSiguienteInicio(mesInicio: string): string {
  const [y, m] = mesInicio.split("-").map(Number);
  const ny = m === 12 ? y + 1 : y;
  const nm = m === 12 ? 1 : m + 1;
  return `${ny}-${String(nm).padStart(2, "0")}-01`;
}

/** Parsea estab/punto/número desde un CDC SIFEN (44 dígitos). */
function numeroDesdeCdc(cdc: string | null | undefined): string | null {
  const s = soloDigitos(cdc);
  if (s.length < 24) return null;
  const est = s.slice(11, 14);
  const pun = s.slice(14, 17);
  const num = s.slice(17, 24);
  return `${est}-${pun}-${num}`;
}

export async function getReporteRG90(
  schemaRaw: string,
  empresaId: string,
  b: MesBounds
): Promise<Rg90Reporte> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const p = pool();
  const cfg = await leerConfig(schema, empresaId);
  const modoSifen = cfg.modo === "sifen";

  const tF = quoteSchemaTable(schema, "facturas");
  const tFI = quoteSchemaTable(schema, "factura_items");
  const tFE = quoteSchemaTable(schema, "factura_electronica");
  const tCli = quoteSchemaTable(schema, "clientes");
  const tNC = quoteSchemaTable(schema, "nota_credito");
  const tNCE = quoteSchemaTable(schema, "nota_credito_electronica");

  const mesFin = mesSiguienteInicio(b.mesInicio);

  // ── Facturas del período (excluye anuladas) + flag electrónico + cliente ─────
  const facturasQ = p.query<{
    id: string; numero_factura: string; fecha: string; tipo: string; moneda: string; monto: number;
    cliente_ruc: string | null; cliente_razon_social: string | null;
    cli_ruc: string | null; cli_documento: string | null; cli_nombre: string | null; cli_empresa: string | null; cli_contacto: string | null;
    fe_estado: string | null; fe_cdc: string | null;
  }>(
    `SELECT f.id, f.numero_factura, f.fecha::text AS fecha, f.tipo, f.moneda, f.monto::float8 AS monto,
            f.cliente_razon_social, f.cliente_ruc,
            c.ruc AS cli_ruc, c.documento AS cli_documento, c.nombre AS cli_nombre, c.empresa AS cli_empresa, c.nombre_contacto AS cli_contacto,
            fe.estado_sifen AS fe_estado, fe.cdc AS fe_cdc
       FROM ${tF} f
       LEFT JOIN ${tCli} c ON c.id=f.cliente_id AND c.empresa_id=f.empresa_id
       LEFT JOIN ${tFE} fe ON fe.factura_id=f.id AND fe.empresa_id=f.empresa_id
      WHERE f.empresa_id=$1::uuid AND f.fecha>=$2::date AND f.fecha<$3::date
        AND COALESCE(f.estado,'') <> 'Anulado'
      ORDER BY f.fecha ASC, f.numero_factura ASC`,
    [empresaId, b.mesInicio, mesFin]
  );

  // ── Líneas de todas esas facturas (para el desglose IVA) ─────────────────────
  const itemsQ = p.query<{ factura_id: string; subtotal: number; iva: number; total: number; tipo_iva: string | null }>(
    `SELECT fi.factura_id, fi.subtotal::float8 AS subtotal, fi.iva::float8 AS iva, fi.total::float8 AS total, fi.tipo_iva
       FROM ${tFI} fi
       JOIN ${tF} f ON f.id=fi.factura_id AND f.empresa_id=fi.empresa_id
      WHERE fi.empresa_id=$1::uuid AND f.fecha>=$2::date AND f.fecha<$3::date
        AND COALESCE(f.estado,'') <> 'Anulado'`,
    [empresaId, b.mesInicio, mesFin]
  );

  // ── Notas de crédito del período (excluye anuladas) ──────────────────────────
  const ncQ = p.query<{
    id: string; factura_id: string; fecha: string; monto: number; moneda: string;
    cli_ruc: string | null; cli_documento: string | null; cli_nombre: string | null; cli_empresa: string | null; cli_contacto: string | null;
    f_tipo: string | null; f_numero: string | null; f_estado: string | null;
    nce_estado: string | null; nce_cdc: string | null;
  }>(
    `SELECT nc.id, nc.factura_id, (nc.created_at AT TIME ZONE 'America/Asuncion')::date::text AS fecha,
            nc.monto::float8 AS monto, nc.moneda_snapshot AS moneda,
            c.ruc AS cli_ruc, c.documento AS cli_documento, c.nombre AS cli_nombre, c.empresa AS cli_empresa, c.nombre_contacto AS cli_contacto,
            f.tipo AS f_tipo, f.numero_factura AS f_numero, f.estado AS f_estado,
            nce.estado_sifen AS nce_estado, nce.cdc AS nce_cdc
       FROM ${tNC} nc
       LEFT JOIN ${tCli} c ON c.id=nc.cliente_id AND c.empresa_id=nc.empresa_id
       LEFT JOIN ${tF} f ON f.id=nc.factura_id AND f.empresa_id=nc.empresa_id
       LEFT JOIN ${tNCE} nce ON nce.nota_credito_id=nc.id AND nce.empresa_id=nc.empresa_id
      WHERE nc.empresa_id=$1::uuid AND nc.created_at>=$2::timestamptz AND nc.created_at<=$3::timestamptz
        AND nc.estado_erp = 'aprobada'
      ORDER BY nc.created_at ASC`,
    [empresaId, b.start, b.end]
  );

  const [facturas, items, ncs] = await Promise.all([facturasQ, itemsQ, ncQ]);

  // Desglose IVA por factura.
  const splitPorFactura = new Map<string, Split>();
  for (const it of items.rows) {
    let s = splitPorFactura.get(it.factura_id);
    if (!s) { s = splitVacio(); splitPorFactura.set(it.factura_id, s); }
    acumularLinea(s, num(it.subtotal), num(it.iva), num(it.total), it.tipo_iva);
  }

  // Composición de las facturas de origen de NC que NO están en este mes
  // (para prorratear correctamente y que los totales cuadren).
  const origenFaltante = Array.from(
    new Set(ncs.rows.map((n) => n.factura_id).filter((id) => id && !splitPorFactura.has(id)))
  );
  if (origenFaltante.length > 0) {
    const itemsOrigen = await p.query<{ factura_id: string; subtotal: number; iva: number; total: number; tipo_iva: string | null }>(
      `SELECT fi.factura_id, fi.subtotal::float8 AS subtotal, fi.iva::float8 AS iva, fi.total::float8 AS total, fi.tipo_iva
         FROM ${tFI} fi
        WHERE fi.empresa_id=$1::uuid AND fi.factura_id = ANY($2::uuid[])`,
      [empresaId, origenFaltante]
    );
    for (const it of itemsOrigen.rows) {
      let s = splitPorFactura.get(it.factura_id);
      if (!s) { s = splitVacio(); splitPorFactura.set(it.factura_id, s); }
      acumularLinea(s, num(it.subtotal), num(it.iva), num(it.total), it.tipo_iva);
    }
  }

  const rows: Rg90VentaRow[] = [];

  // Facturas → filas.
  for (const f of facturas.rows) {
    const electronico = modoSifen || Boolean(f.fe_estado);
    const fuente = electronico ? cfg.sifen : cfg.autoimpresor ?? cfg.sifen;
    const numeroComprobante = electronico && f.fe_cdc
      ? numeroDesdeCdc(f.fe_cdc) ?? formatNumeroComprobante(f.numero_factura, fuente?.est, fuente?.punto)
      : formatNumeroComprobante(f.numero_factura, fuente?.est, fuente?.punto);
    const split = splitPorFactura.get(f.id) ?? { gravado10: intGs(f.monto), gravado5: 0, exento: 0, total: intGs(f.monto) };
    const ident = identificacionComprador({ ruc: f.cli_ruc ?? f.cliente_ruc, documento: f.cli_documento });
    const nombre = (f.cliente_razon_social || f.cli_empresa || f.cli_nombre || f.cli_contacto || "").trim();
    rows.push({
      id: f.id,
      tipo: "factura",
      fecha: String(f.fecha).slice(0, 10),
      codigoComprobante: COMP_FACTURA,
      numeroComprobante,
      timbrado: fuente?.timbrado ?? "",
      codigoTipoIdentificacion: ident.codigo,
      numeroIdentificacion: ident.numero,
      nombre,
      codigoCondicion: condicionDesdeTipo(f.tipo),
      gravado10: intGs(split.gravado10),
      gravado5: intGs(split.gravado5),
      exento: intGs(split.exento),
      total: intGs(split.total || f.monto),
      moneda: String(f.moneda || "GS").toUpperCase(),
      electronico,
      comprobanteAsociado: null,
      timbradoAsociado: null,
    });
  }

  // Notas de crédito → filas (monto prorrateado sobre la factura de origen).
  for (const nc of ncs.rows) {
    const electronico = modoSifen || Boolean(nc.nce_estado);
    const fuente = electronico ? cfg.sifen : cfg.autoimpresor ?? cfg.sifen;
    const origen = splitPorFactura.get(nc.factura_id) ?? null;
    const split = origen ? prorratear(origen, num(nc.monto)) : { gravado10: intGs(nc.monto), gravado5: 0, exento: 0, total: intGs(nc.monto) };
    const ident = identificacionComprador({ ruc: nc.cli_ruc, documento: nc.cli_documento });
    const nombre = (nc.cli_empresa || nc.cli_nombre || nc.cli_contacto || "").trim();
    const numeroComprobante = numeroDesdeCdc(nc.nce_cdc) ?? "";
    const asociado = nc.f_numero ? formatNumeroComprobante(nc.f_numero, fuente?.est, fuente?.punto) : null;
    rows.push({
      id: nc.id,
      tipo: "nota_credito",
      fecha: String(nc.fecha).slice(0, 10),
      codigoComprobante: COMP_NOTA_CREDITO,
      numeroComprobante,
      timbrado: fuente?.timbrado ?? "",
      codigoTipoIdentificacion: ident.codigo,
      numeroIdentificacion: ident.numero,
      nombre,
      codigoCondicion: condicionDesdeTipo(nc.f_tipo),
      gravado10: intGs(split.gravado10),
      gravado5: intGs(split.gravado5),
      exento: intGs(split.exento),
      total: intGs(split.total),
      moneda: String(nc.moneda || "GS").toUpperCase(),
      electronico,
      comprobanteAsociado: asociado,
      timbradoAsociado: fuente?.timbrado ?? null,
    });
  }

  // Orden final: por fecha, luego número.
  rows.sort((a, z) => (a.fecha < z.fecha ? -1 : a.fecha > z.fecha ? 1 : a.numeroComprobante.localeCompare(z.numeroComprobante)));

  const acumular = (acc: Rg90Totales, r: Rg90VentaRow) => {
    acc.comprobantes += 1;
    if (r.tipo === "factura") acc.facturas += 1; else acc.notasCredito += 1;
    acc.gravado10 += r.gravado10;
    acc.gravado5 += r.gravado5;
    acc.exento += r.exento;
    acc.total += r.total;
    return acc;
  };
  const vacio = (): Rg90Totales => ({ comprobantes: 0, facturas: 0, notasCredito: 0, gravado10: 0, gravado5: 0, exento: 0, total: 0 });

  const totales = rows.reduce(acumular, vacio());
  const impresos = rows.filter((r) => !r.electronico && r.moneda === "GS");
  const totalesImpresos = impresos.reduce(acumular, vacio());
  const excluidosMonedaExtranjera = rows.filter((r) => r.moneda !== "GS").length;

  return {
    mes: b.mes,
    rucEmisor: cfg.rucEmisor,
    modoFacturacion: cfg.modo,
    rows,
    totales,
    totalesImpresos,
    excluidosMonedaExtranjera,
  };
}
