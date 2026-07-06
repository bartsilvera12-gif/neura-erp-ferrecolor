/**
 * PG directo para Órdenes de Compra (OC). Mismo patrón que compras-pg:
 * pool singleton + queries parametrizadas + identifier escape.
 *
 * La OC NO impacta stock. Al "recibir" se delega en insertComprasConImpacto
 * (compras-pg) para crear la compra real y recién ahí mover inventario; luego
 * se marca la OC como 'recibida' con el numero_control de la compra.
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";
import { assertAllowedChatDataSchema } from "@/lib/supabase/chat-data-schema";
import {
  insertComprasConImpacto,
  type CompraHeaderInput,
  type CompraItemInput,
} from "@/lib/compras/server/compras-pg";

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool no disponible.");
  return p;
}

export interface OrdenCompraRow {
  id: string;
  empresa_id: string;
  numero_oc: string;
  proveedor_id: string;
  proveedor_nombre: string;
  producto_id: string;
  producto_nombre: string;
  cantidad: string | number;
  moneda: string;
  tipo_cambio: string | number;
  costo_unitario_original: string | number;
  costo_unitario: string | number;
  iva_tipo: string;
  subtotal: string | number;
  monto_iva: string | number;
  total: string | number;
  precio_venta: string | number;
  margen_venta: string | number | null;
  tipo_pago: string;
  plazo_dias: number | null;
  estado: string;
  observacion: string | null;
  compra_numero_control: string | null;
  recibida_at: string | null;
  cancelada_at: string | null;
  cancelada_motivo: string | null;
  fecha: string;
  created_at: string;
  updated_at: string;
  created_by: string | null;
  usuario_nombre: string | null;
}

const COLS = `
  id, empresa_id, numero_oc, proveedor_id, proveedor_nombre, producto_id, producto_nombre,
  cantidad, moneda, tipo_cambio, costo_unitario_original, costo_unitario,
  iva_tipo, subtotal, monto_iva, total, precio_venta, margen_venta,
  tipo_pago, plazo_dias, estado, observacion,
  compra_numero_control, recibida_at, cancelada_at, cancelada_motivo,
  fecha, created_at, updated_at, created_by, usuario_nombre
`;

export interface OrdenCompraHeaderInput {
  proveedor_id: string;
  proveedor_nombre: string;
  moneda: string;
  tipo_cambio: number;
  tipo_pago: string;
  plazo_dias: number | null;
  observacion: string | null;
  created_by: string | null;
  usuario_nombre: string | null;
}

export interface OrdenCompraItemInput {
  producto_id: string;
  producto_nombre: string;
  cantidad: number;
  costo_unitario_original: number;
  costo_unitario: number;
  iva_tipo: string;
  subtotal: number;
  monto_iva: number;
  total: number;
  precio_venta: number;
  margen_venta: number | null;
}

/** Lista todas las líneas de OC de la empresa (más recientes primero). */
export async function listOrdenesCompra(
  schemaRaw: string,
  empresaId: string
): Promise<OrdenCompraRow[]> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const t = quoteSchemaTable(schema, "ordenes_compra");
  const { rows } = await pool().query<OrdenCompraRow>(
    `SELECT ${COLS} FROM ${t} WHERE empresa_id = $1::uuid ORDER BY fecha DESC LIMIT 1000`,
    [empresaId]
  );
  return rows;
}

/** Devuelve todas las líneas de una OC por numero_oc. */
export async function getOrdenCompra(
  schemaRaw: string,
  empresaId: string,
  numeroOc: string
): Promise<OrdenCompraRow[]> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const t = quoteSchemaTable(schema, "ordenes_compra");
  const { rows } = await pool().query<OrdenCompraRow>(
    `SELECT ${COLS} FROM ${t}
      WHERE empresa_id = $1::uuid AND numero_oc = $2
      ORDER BY created_at ASC`,
    [empresaId, numeroOc]
  );
  return rows;
}

/** Próximo OC-XXXXXX leyendo el máximo existente. */
async function nextNumeroOc(
  client: import("pg").PoolClient,
  schema: string,
  empresaId: string
): Promise<string> {
  const t = quoteSchemaTable(schema, "ordenes_compra");
  const { rows } = await client.query<{ maxn: number | null }>(
    `SELECT COALESCE(MAX(
       CASE WHEN numero_oc ~ '^OC-[0-9]+$'
            THEN (substring(numero_oc from 4))::int
            ELSE 0 END
     ), 0) AS maxn
     FROM ${t} WHERE empresa_id = $1::uuid`,
    [empresaId]
  );
  const next = Number(rows[0]?.maxn ?? 0) + 1;
  return `OC-${String(next).padStart(6, "0")}`;
}

export interface OrdenCompraResult {
  numero_oc: string;
  ordenes: OrdenCompraRow[];
}

/** Crea una OC multiproducto (N filas con un único numero_oc). Sin impacto en stock. */
export async function insertOrdenCompra(
  schemaRaw: string,
  empresaId: string,
  header: OrdenCompraHeaderInput,
  items: OrdenCompraItemInput[]
): Promise<OrdenCompraResult> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  if (!Array.isArray(items) || items.length === 0) {
    throw new Error("La orden de compra no tiene productos.");
  }
  const t = quoteSchemaTable(schema, "ordenes_compra");
  const client = await pool().connect();
  const inserted: OrdenCompraRow[] = [];
  try {
    await client.query("BEGIN");
    const numero = await nextNumeroOc(client, schema, empresaId);
    for (const it of items) {
      const { rows } = await client.query<OrdenCompraRow>(
        `INSERT INTO ${t} (
           empresa_id, numero_oc, proveedor_id, proveedor_nombre, producto_id, producto_nombre,
           cantidad, moneda, tipo_cambio, costo_unitario_original, costo_unitario,
           iva_tipo, subtotal, monto_iva, total, precio_venta, margen_venta,
           tipo_pago, plazo_dias, estado, observacion, fecha, created_by, usuario_nombre
         ) VALUES (
           $1::uuid, $2, $3::uuid, $4, $5::uuid, $6,
           $7::numeric, $8, $9::numeric, $10::numeric, $11::numeric,
           $12, $13::numeric, $14::numeric, $15::numeric, $16::numeric, $17::numeric,
           $18, $19::integer, 'abierta', $20, now(), $21::uuid, $22
         )
         RETURNING ${COLS}`,
        [
          empresaId, numero, header.proveedor_id, header.proveedor_nombre,
          it.producto_id, it.producto_nombre,
          it.cantidad, header.moneda, header.tipo_cambio,
          it.costo_unitario_original, it.costo_unitario,
          it.iva_tipo, it.subtotal, it.monto_iva, it.total, it.precio_venta, it.margen_venta,
          header.tipo_pago, header.plazo_dias, header.observacion,
          header.created_by, header.usuario_nombre,
        ]
      );
      inserted.push(rows[0]);
    }
    await client.query("COMMIT");
    return { numero_oc: numero, ordenes: inserted };
  } catch (err) {
    await client.query("ROLLBACK").catch(() => null);
    throw err;
  } finally {
    client.release();
  }
}

/** Cancela una OC abierta (todas sus líneas). Idempotente si ya no está abierta. */
export async function cancelarOrdenCompra(
  schemaRaw: string,
  empresaId: string,
  numeroOc: string,
  motivo: string | null
): Promise<number> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const t = quoteSchemaTable(schema, "ordenes_compra");
  const { rowCount } = await pool().query(
    `UPDATE ${t}
        SET estado = 'cancelada', cancelada_at = now(),
            cancelada_motivo = $3, updated_at = now()
      WHERE empresa_id = $1::uuid AND numero_oc = $2 AND estado = 'abierta'`,
    [empresaId, numeroOc, (motivo ?? "").trim().slice(0, 500) || null]
  );
  return rowCount ?? 0;
}

export interface RecibirOrdenCompraParams {
  numeroOc: string;
  nroTimbrado: string;
  numeroFactura: string;
  tipoPago: string;
  plazoDias: number | null;
  comprobante: {
    url: string | null;
    storage_path: string | null;
    nombre: string | null;
    mime_type: string | null;
  };
  createdBy: string | null;
  usuarioNombre: string | null;
}

export interface RecibirOrdenCompraResult {
  numero_oc: string;
  numero_control: string;
  movimiento_warning: string | null;
}

/**
 * Recibe una OC: crea la COMPRA real (impacta stock) con los ítems tal cual la
 * OC, y marca la OC como 'recibida' con el numero_control de la compra.
 * Los ítems NO son editables: se toman de la OC (fuente de verdad en DB).
 */
export async function recibirOrdenCompra(
  schemaRaw: string,
  empresaId: string,
  params: RecibirOrdenCompraParams
): Promise<RecibirOrdenCompraResult> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const filas = await getOrdenCompra(schema, empresaId, params.numeroOc);
  if (filas.length === 0) throw new Error("Orden de compra no encontrada.");
  if (filas.some((f) => f.estado !== "abierta")) {
    throw new Error("La orden de compra ya fue recibida o cancelada.");
  }
  const cab = filas[0];

  const num = (v: unknown) => {
    const n = typeof v === "number" ? v : Number(v ?? 0);
    return Number.isFinite(n) ? n : 0;
  };

  const header: CompraHeaderInput = {
    proveedor_id: cab.proveedor_id,
    proveedor_nombre: cab.proveedor_nombre,
    moneda: cab.moneda === "USD" ? "USD" : "PYG",
    tipo_cambio: num(cab.tipo_cambio) || 1,
    tipo_pago: params.tipoPago === "credito" ? "credito" : "contado",
    plazo_dias: params.plazoDias,
    nro_timbrado: params.nroTimbrado.trim().toUpperCase(),
    numero_factura: params.numeroFactura.trim(),
    orden_compra_numero: params.numeroOc,
    comprobante_url: params.comprobante.url,
    comprobante_storage_path: params.comprobante.storage_path,
    comprobante_nombre: params.comprobante.nombre,
    comprobante_mime_type: params.comprobante.mime_type,
    created_by: params.createdBy,
    usuario_nombre: params.usuarioNombre,
  };

  const items: CompraItemInput[] = filas.map((f) => ({
    producto_id: f.producto_id,
    producto_nombre: f.producto_nombre,
    cantidad: num(f.cantidad),
    costo_unitario_original: num(f.costo_unitario_original),
    costo_unitario: num(f.costo_unitario),
    iva_tipo: f.iva_tipo,
    subtotal: num(f.subtotal),
    monto_iva: num(f.monto_iva),
    total: num(f.total),
    precio_venta: num(f.precio_venta),
    margen_venta: f.margen_venta != null ? num(f.margen_venta) : null,
  }));

  const out = await insertComprasConImpacto(schema, empresaId, header, items);

  // Marcar OC recibida (solo si sigue abierta — evita doble recepción).
  const t = quoteSchemaTable(schema, "ordenes_compra");
  await pool().query(
    `UPDATE ${t}
        SET estado = 'recibida', recibida_at = now(),
            compra_numero_control = $3, updated_at = now()
      WHERE empresa_id = $1::uuid AND numero_oc = $2 AND estado = 'abierta'`,
    [empresaId, params.numeroOc, out.numero_control]
  );

  return {
    numero_oc: params.numeroOc,
    numero_control: out.numero_control,
    movimiento_warning: out.movimiento_warning,
  };
}
