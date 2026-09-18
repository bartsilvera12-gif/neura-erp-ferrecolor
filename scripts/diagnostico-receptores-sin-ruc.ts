/**
 * Diagnóstico (SOLO LECTURA): ¿a cuántos clientes se les facturó como "consumidor final"
 * (sin RUC) en vez de "contribuyente", y cuáles son los que hay que revisar/corregir?
 *
 * Motivo: el generador SIFEN (src/lib/sifen/rde-xml.ts) emite iNatRec=2 (consumidor final,
 * "Cédula paraguaya") cuando el cliente NO tiene `ruc` cargado. El campo `ruc` actual del
 * cliente es un PROXY de cómo se facturó (la verdad exacta está en el XML firmado / iNatRec).
 *
 * La base es multi-tenant: cada empresa = un esquema Postgres. Este script apunta a un esquema.
 *
 * Uso:
 *   npx tsx scripts/diagnostico-receptores-sin-ruc.ts            # esquema por defecto: ferrecolor
 *   npx tsx scripts/diagnostico-receptores-sin-ruc.ts otroschema
 *
 * Requiere en .env.local (o env): SUPABASE_DB_URL | DIRECT_URL | DATABASE_URL
 * No modifica nada.
 */
import { config } from "dotenv";
import path from "node:path";
import pg from "pg";

config({ path: path.resolve(process.cwd(), ".env.local") });

const url =
  process.env.SUPABASE_DB_URL?.trim() ||
  process.env.DIRECT_URL?.trim() ||
  process.env.DATABASE_URL?.trim();

if (!url) {
  console.error("Falta SUPABASE_DB_URL | DIRECT_URL | DATABASE_URL en el entorno.");
  process.exit(2);
}

const schemaArg = (process.argv[2] ?? "ferrecolor").trim();

/** Valida identificador de esquema para interpolar sin riesgo de inyección. */
function safeIdent(s: string): string {
  if (!/^[a-zA-Z_][a-zA-Z0-9_]*$/.test(s)) {
    throw new Error(`Identificador de esquema inválido: ${s}`);
  }
  return s;
}

async function main() {
  const S = safeIdent(schemaArg);
  const client = new pg.Client({
    connectionString: url,
    ssl: url!.includes("supabase") ? { rejectUnauthorized: false } : undefined,
  });
  await client.connect();
  try {
    const emp = await client.query(
      `SELECT id, nombre_empresa, ruc FROM ${S}.empresas ORDER BY created_at NULLS LAST LIMIT 3`
    );
    console.log(`== Esquema/empresa: ${S} ==`);
    console.table(emp.rows);

    // 1) Clientes por tipo, flag es_contribuyente y presencia de RUC.
    const resumenClientes = await client.query(
      `SELECT
         COALESCE(c.tipo_cliente,'(sin tipo)') AS tipo_cliente,
         c.es_contribuyente,
         CASE WHEN c.ruc IS NULL OR btrim(c.ruc) = '' THEN 'SIN_RUC' ELSE 'CON_RUC' END AS ruc_cargado,
         count(*) AS clientes
       FROM ${S}.clientes c
       WHERE c.deleted_at IS NULL
       GROUP BY 1, 2, 3
       ORDER BY 1, 2, 3`
    );
    console.log("\n== Clientes por tipo / es_contribuyente / RUC cargado ==");
    console.table(resumenClientes.rows);

    // 2) Facturas electrónicas por naturaleza del receptor (proxy = RUC en la factura) y estado SIFEN.
    const resumenFacturas = await client.query(
      `SELECT
         CASE WHEN f.cliente_ruc IS NULL OR btrim(f.cliente_ruc) = '' THEN 'consumidor_final (sin RUC)'
              ELSE 'contribuyente (con RUC)' END AS receptor,
         COALESCE(fe.estado_sifen,'(sin estado)') AS estado_sifen,
         count(*) AS facturas
       FROM ${S}.factura_electronica fe
       JOIN ${S}.facturas f ON f.id = fe.factura_id
       GROUP BY 1, 2
       ORDER BY 1, 2`
    );
    console.log("\n== Facturas electrónicas por naturaleza del receptor (RUC en factura) y estado SIFEN ==");
    console.table(resumenFacturas.rows);

    // 3) LISTA a revisar: clientes facturados SIN RUC con facturas electrónicas APROBADAS por SET.
    const listaRevisar = await client.query(
      `SELECT
         COALESCE(c.tipo_cliente,'(sin tipo)') AS tipo,
         c.nombre,
         c.documento AS ci_doc,
         c.es_contribuyente AS es_contrib,
         CASE WHEN c.ruc IS NULL OR btrim(c.ruc)='' THEN '' ELSE c.ruc END AS ruc_actual_ficha,
         count(*)            AS fact_aprob,
         max(f.fecha)::date  AS ultima,
         sum(f.monto)        AS total_facturado
       FROM ${S}.factura_electronica fe
       JOIN ${S}.facturas f ON f.id = fe.factura_id
       JOIN ${S}.clientes  c ON c.id = f.cliente_id
       WHERE fe.estado_sifen = 'aprobado'
         AND (f.cliente_ruc IS NULL OR btrim(f.cliente_ruc) = '')
       GROUP BY c.id, c.tipo_cliente, c.nombre, c.documento, c.es_contribuyente, c.ruc
       ORDER BY total_facturado DESC NULLS LAST, fact_aprob DESC
       LIMIT 60`
    );
    console.log(
      `\n== Clientes facturados SIN RUC con facturas APROBADAS (a revisar; top 60): ${listaRevisar.rowCount} ==`
    );
    console.table(listaRevisar.rows);

    // 4) Totales: cuánto IVA quedó "no imputable" para las facturas emitidas sin RUC.
    const totalIva = await client.query(
      `SELECT
         count(DISTINCT f.id)        AS facturas_consumidor_final_aprobadas,
         count(DISTINCT f.cliente_id) AS clientes_afectados,
         COALESCE(sum(fi.iva),0)     AS iva_no_imputable_total
       FROM ${S}.factura_electronica fe
       JOIN ${S}.facturas f       ON f.id = fe.factura_id
       LEFT JOIN ${S}.factura_items fi ON fi.factura_id = f.id
       WHERE fe.estado_sifen = 'aprobado'
         AND (f.cliente_ruc IS NULL OR btrim(f.cliente_ruc) = '')`
    );
    console.log("\n== Totales (facturas a consumidor final aprobadas) ==");
    console.table(totalIva.rows);

    console.log(
      "\nNota: 'sin RUC' es un PROXY de cómo se facturó (el dato exacto está en el iNatRec del XML firmado).\n" +
        "Facturar a consumidor final es correcto para clientes que NO son contribuyentes; el problema son\n" +
        "los que SÍ tienen RUC y esperaban imputar el IVA."
    );
  } finally {
    await client.end();
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
