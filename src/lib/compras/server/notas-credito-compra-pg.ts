/**
 * PG directo para Notas de Crédito de COMPRA (recibidas de proveedor).
 * Mismo patrón que compras-pg: pool singleton + queries parametrizadas + escape de schema.
 *
 * Reglas de negocio:
 *   - Crear deja la NC en estado 'borrador' SIN impacto en stock.
 *   - Confirmar (borrador -> confirmada) descuenta stock en una transacción con guard
 *     de estado, idempotente: si la NC ya no está en 'borrador', no hace nada (no duplica).
 *   - NO recalcula costo_promedio del producto (decisión de negocio); el costo queda en
 *     el movimiento SALIDA (origen='nota_credito_compra') para trazabilidad y libro RG 90.
 *   - Cada ítem referencia una fila `compras` concreta (compra_id).
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";
import { assertAllowedChatDataSchema } from "@/lib/supabase/chat-data-schema";
import type {
  CompraElegible,
  NotaCreditoCompra,
  NotaCreditoCompraItem,
  TipoIva,
} from "@/lib/compras/types";

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool no disponible.");
  return p;
}

function ivaFactor(iva: string): number {
  if (iva === "5") return 0.05;
  if (iva === "10") return 0.1;
  return 0; // exenta
}

/** IVA incluido en el costo (PYG) para un total bruto: en PY el costo suele ser con IVA incluido. */
function desglosarIva(totalBruto: number, iva: string): { subtotal: number; monto_iva: number } {
  const f = ivaFactor(iva);
  if (f === 0) return { subtotal: totalBruto, monto_iva: 0 };
  // total = subtotal * (1 + f)  =>  subtotal = total / (1 + f)
  const subtotal = totalBruto / (1 + f);
  return { subtotal, monto_iva: totalBruto - subtotal };
}

export interface AuditInput {
  created_by: string | null;
  usuario_nombre: string | null;
}

export interface CrearNotaCreditoCompraInput {
  proveedor_id: string;
  nro_comprobante: string | null;
  nro_timbrado: string | null;
  motivo: string | null;
  items: { compra_id: string; cantidad: number }[];
}

// ── Compras elegibles de un proveedor (con cantidad disponible) ───────────────

export async function listComprasElegibles(
  schemaRaw: string,
  empresaId: string,
  proveedorId: string
): Promise<CompraElegible[]> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tC = quoteSchemaTable(schema, "compras");
  const tI = quoteSchemaTable(schema, "notas_credito_compra_items");
  const tH = quoteSchemaTable(schema, "notas_credito_compra");

  const { rows } = await pool().query(
    `SELECT
        c.id                AS compra_id,
        c.numero_control    AS numero_control,
        c.producto_id       AS producto_id,
        c.producto_nombre   AS producto_nombre,
        c.iva_tipo          AS iva_tipo,
        c.moneda            AS moneda,
        c.costo_unitario    AS costo_unitario,
        c.cantidad          AS cantidad_comprada,
        c.fecha             AS fecha,
        COALESCE((
          SELECT SUM(i.cantidad)
          FROM ${tI} i
          JOIN ${tH} h ON h.id = i.nota_credito_compra_id
          WHERE i.compra_id = c.id AND h.estado <> 'anulada'
        ), 0)               AS cantidad_ya_acreditada
     FROM ${tC} c
     WHERE c.empresa_id = $1::uuid
       AND c.proveedor_id = $2::uuid
       AND c.estado <> 'anulada'
     ORDER BY c.fecha DESC`,
    [empresaId, proveedorId]
  );

  return rows
    .map((r): CompraElegible => {
      const comprada = Number(r.cantidad_comprada) || 0;
      const acreditada = Number(r.cantidad_ya_acreditada) || 0;
      return {
        compra_id: String(r.compra_id),
        numero_control: String(r.numero_control),
        producto_id: String(r.producto_id),
        producto_nombre: String(r.producto_nombre),
        producto_sku: "",
        iva_tipo: (r.iva_tipo as TipoIva) ?? "10",
        moneda: r.moneda === "USD" ? "USD" : "PYG",
        costo_unitario: Number(r.costo_unitario) || 0,
        cantidad_comprada: comprada,
        cantidad_ya_acreditada: acreditada,
        cantidad_disponible: Math.max(0, comprada - acreditada),
        fecha: typeof r.fecha === "string" ? r.fecha : new Date(r.fecha).toISOString(),
      };
    })
    .filter((c) => c.cantidad_disponible > 0);
}

// ── Listado con items ─────────────────────────────────────────────────────────

export async function listNotasCreditoCompra(
  schemaRaw: string,
  empresaId: string
): Promise<NotaCreditoCompra[]> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tH = quoteSchemaTable(schema, "notas_credito_compra");
  const tI = quoteSchemaTable(schema, "notas_credito_compra_items");

  const { rows: headers } = await pool().query(
    `SELECT id, numero_control, proveedor_id, proveedor_nombre, nro_comprobante,
            nro_timbrado, motivo, moneda, tipo_cambio, subtotal, monto_iva, total,
            estado, fecha, confirmada_at
       FROM ${tH}
      WHERE empresa_id = $1::uuid
      ORDER BY fecha DESC
      LIMIT 500`,
    [empresaId]
  );
  if (headers.length === 0) return [];

  const ids = headers.map((h) => String(h.id));
  const { rows: items } = await pool().query(
    `SELECT id, nota_credito_compra_id, compra_id, producto_id, producto_nombre,
            producto_sku, cantidad, costo_unitario, iva_tipo, subtotal, monto_iva,
            total, movimiento_id
       FROM ${tI}
      WHERE nota_credito_compra_id = ANY($1::uuid[])`,
    [ids]
  );

  const byNc = new Map<string, NotaCreditoCompraItem[]>();
  for (const it of items) {
    const key = String(it.nota_credito_compra_id);
    const arr = byNc.get(key) ?? [];
    arr.push({
      id: String(it.id),
      compra_id: String(it.compra_id),
      producto_id: String(it.producto_id),
      producto_nombre: String(it.producto_nombre),
      producto_sku: String(it.producto_sku ?? ""),
      cantidad: Number(it.cantidad) || 0,
      costo_unitario: Number(it.costo_unitario) || 0,
      iva_tipo: (it.iva_tipo as TipoIva) ?? "10",
      subtotal: Number(it.subtotal) || 0,
      monto_iva: Number(it.monto_iva) || 0,
      total: Number(it.total) || 0,
      movimiento_id: it.movimiento_id ? String(it.movimiento_id) : null,
    });
    byNc.set(key, arr);
  }

  return headers.map((h): NotaCreditoCompra => ({
    id: String(h.id),
    numero_control: String(h.numero_control),
    proveedor_id: String(h.proveedor_id),
    proveedor_nombre: String(h.proveedor_nombre),
    nro_comprobante: h.nro_comprobante ?? null,
    nro_timbrado: h.nro_timbrado ?? null,
    motivo: h.motivo ?? null,
    moneda: h.moneda === "USD" ? "USD" : "PYG",
    tipo_cambio: Number(h.tipo_cambio) || 1,
    subtotal: Number(h.subtotal) || 0,
    monto_iva: Number(h.monto_iva) || 0,
    total: Number(h.total) || 0,
    estado: h.estado,
    fecha: typeof h.fecha === "string" ? h.fecha : new Date(h.fecha).toISOString(),
    confirmada_at: h.confirmada_at
      ? (typeof h.confirmada_at === "string" ? h.confirmada_at : new Date(h.confirmada_at).toISOString())
      : null,
    items: byNc.get(String(h.id)) ?? [],
  }));
}

/** Próximo NCC-XXXXXX leyendo el máximo existente. */
async function nextNumeroControl(
  client: import("pg").PoolClient,
  schema: string,
  empresaId: string
): Promise<string> {
  const tH = quoteSchemaTable(schema, "notas_credito_compra");
  const { rows } = await client.query<{ maxn: number | null }>(
    `SELECT COALESCE(MAX(
       CASE WHEN numero_control ~ '^NCC-[0-9]+$'
            THEN (substring(numero_control from 5))::int ELSE 0 END
     ), 0) AS maxn
     FROM ${tH} WHERE empresa_id = $1::uuid`,
    [empresaId]
  );
  const next = Number(rows[0]?.maxn ?? 0) + 1;
  return `NCC-${String(next).padStart(6, "0")}`;
}

// ── Crear (borrador, sin impacto en stock) ────────────────────────────────────

export async function crearNotaCreditoCompra(
  schemaRaw: string,
  empresaId: string,
  d: CrearNotaCreditoCompraInput,
  audit: AuditInput
): Promise<NotaCreditoCompra> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tC = quoteSchemaTable(schema, "compras");
  const tH = quoteSchemaTable(schema, "notas_credito_compra");
  const tI = quoteSchemaTable(schema, "notas_credito_compra_items");

  if (!d.items.length) throw new Error("Seleccioná al menos un producto a acreditar.");

  const client = await pool().connect();
  try {
    await client.query("BEGIN");

    // Traer las compras referenciadas + cantidad ya acreditada, con lock.
    const compraIds = [...new Set(d.items.map((i) => i.compra_id))];
    const { rows: compras } = await client.query(
      `SELECT c.id, c.proveedor_id, c.proveedor_nombre, c.producto_id, c.producto_nombre,
              c.iva_tipo, c.moneda, c.costo_unitario, c.cantidad,
              COALESCE((
                SELECT SUM(i.cantidad) FROM ${tI} i
                JOIN ${tH} h ON h.id = i.nota_credito_compra_id
                WHERE i.compra_id = c.id AND h.estado <> 'anulada'
              ), 0) AS ya_acreditada
         FROM ${tC} c
        WHERE c.id = ANY($1::uuid[]) AND c.empresa_id = $2::uuid
        FOR UPDATE OF c`,
      [compraIds, empresaId]
    );
    const compraMap = new Map(compras.map((c) => [String(c.id), c]));

    // Validaciones + proveedor consistente.
    let proveedorId: string | null = null;
    let proveedorNombre = "";
    for (const it of d.items) {
      const c = compraMap.get(it.compra_id);
      if (!c) throw new Error(`Compra ${it.compra_id} no encontrada.`);
      if (String(c.proveedor_id) !== d.proveedor_id)
        throw new Error("Todas las compras deben ser del mismo proveedor seleccionado.");
      if (!(it.cantidad > 0)) throw new Error("La cantidad a acreditar debe ser mayor a 0.");
      const disponible = (Number(c.cantidad) || 0) - (Number(c.ya_acreditada) || 0);
      if (it.cantidad > disponible + 1e-9)
        throw new Error(
          `La cantidad a acreditar (${it.cantidad}) supera lo disponible (${disponible}) en ${c.numero_control ?? "la compra"}.`
        );
      proveedorId = String(c.proveedor_id);
      proveedorNombre = String(c.proveedor_nombre);
    }

    // Moneda/tc: se toma de la primera compra (en PY el costo_unitario ya está en PYG).
    const monedaNc = "PYG";
    const numero = await nextNumeroControl(client, schema, empresaId);

    // Calcular items + totales (costo en PYG, IVA incluido en el costo).
    const itemsCalc = d.items.map((it) => {
      const c = compraMap.get(it.compra_id)!;
      const costo = Number(c.costo_unitario) || 0;
      const ivaTipo = (c.iva_tipo as string) ?? "10";
      const bruto = costo * it.cantidad;
      const { subtotal, monto_iva } = desglosarIva(bruto, ivaTipo);
      return {
        compra_id: it.compra_id,
        producto_id: String(c.producto_id),
        producto_nombre: String(c.producto_nombre),
        cantidad: it.cantidad,
        costo_unitario: costo,
        iva_tipo: ivaTipo,
        subtotal,
        monto_iva,
        total: bruto,
      };
    });
    const subtotal = itemsCalc.reduce((a, b) => a + b.subtotal, 0);
    const montoIva = itemsCalc.reduce((a, b) => a + b.monto_iva, 0);
    const total = itemsCalc.reduce((a, b) => a + b.total, 0);

    const { rows: hRows } = await client.query(
      `INSERT INTO ${tH} (
         empresa_id, proveedor_id, proveedor_nombre, numero_control, nro_comprobante,
         nro_timbrado, motivo, moneda, tipo_cambio, subtotal, monto_iva, total,
         estado, fecha, created_by, usuario_nombre
       ) VALUES (
         $1::uuid, $2::uuid, $3, $4, $5,
         $6, $7, $8, 1, $9::numeric, $10::numeric, $11::numeric,
         'borrador', now(), $12::uuid, $13
       ) RETURNING id`,
      [
        empresaId,
        proveedorId,
        proveedorNombre,
        numero,
        d.nro_comprobante,
        d.nro_timbrado,
        d.motivo,
        monedaNc,
        subtotal,
        montoIva,
        total,
        audit.created_by,
        audit.usuario_nombre,
      ]
    );
    const ncId = String(hRows[0].id);

    for (const it of itemsCalc) {
      await client.query(
        `INSERT INTO ${tI} (
           nota_credito_compra_id, empresa_id, compra_id, producto_id, producto_nombre,
           producto_sku, cantidad, costo_unitario, iva_tipo, subtotal, monto_iva, total
         )
         SELECT $1::uuid, $2::uuid, $3::uuid, $4::uuid, $5,
                COALESCE((SELECT sku FROM ${quoteSchemaTable(schema, "productos")} WHERE id = $4::uuid), ''),
                $6::numeric, $7::numeric, $8, $9::numeric, $10::numeric, $11::numeric`,
        [
          ncId,
          empresaId,
          it.compra_id,
          it.producto_id,
          it.producto_nombre,
          it.cantidad,
          it.costo_unitario,
          it.iva_tipo,
          it.subtotal,
          it.monto_iva,
          it.total,
        ]
      );
    }

    await client.query("COMMIT");

    const [creada] = await listNotasCreditoCompra(schema, empresaId).then((all) =>
      all.filter((n) => n.id === ncId)
    );
    return creada;
  } catch (err) {
    await client.query("ROLLBACK").catch(() => null);
    throw err;
  } finally {
    client.release();
  }
}

// ── Confirmar (impacto en stock, idempotente) ─────────────────────────────────

export interface ConfirmarResult {
  nota: NotaCreditoCompra;
  ya_confirmada: boolean;           // true si no había nada que hacer (idempotencia)
  movimientos_creados: number;
}

export async function confirmarNotaCreditoCompra(
  schemaRaw: string,
  empresaId: string,
  ncId: string,
  audit: AuditInput
): Promise<ConfirmarResult> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tH = quoteSchemaTable(schema, "notas_credito_compra");
  const tI = quoteSchemaTable(schema, "notas_credito_compra_items");
  const tM = quoteSchemaTable(schema, "movimientos_inventario");
  const tP = quoteSchemaTable(schema, "productos");

  const client = await pool().connect();
  try {
    await client.query("BEGIN");

    // Guard de estado idempotente: solo una confirmación efectiva.
    const flip = await client.query(
      `UPDATE ${tH}
          SET estado = 'confirmada', confirmada_at = now(), updated_at = now()
        WHERE id = $1::uuid AND empresa_id = $2::uuid AND estado = 'borrador'
        RETURNING id, numero_control`,
      [ncId, empresaId]
    );

    if (flip.rowCount === 0) {
      // Ya estaba confirmada/anulada o no existe. No tocar stock.
      await client.query("ROLLBACK").catch(() => null);
      const all = await listNotasCreditoCompra(schema, empresaId);
      const nota = all.find((n) => n.id === ncId);
      if (!nota) throw new Error("Nota de crédito no encontrada.");
      return { nota, ya_confirmada: true, movimientos_creados: 0 };
    }

    const numero = String(flip.rows[0].numero_control);

    // Ítems a procesar.
    const { rows: items } = await client.query(
      `SELECT id, producto_id, producto_nombre, producto_sku, cantidad, costo_unitario
         FROM ${tI} WHERE nota_credito_compra_id = $1::uuid FOR UPDATE`,
      [ncId]
    );

    let movimientos = 0;
    for (const it of items) {
      const cant = Number(it.cantidad);

      // Lock de la fila del producto + stock/sku actuales (serializa concurrencia
      // sobre el mismo producto y da base para la regla de no-negativo).
      const { rows: pRows } = await client.query<{ stock_actual: string | number; sku: string }>(
        `SELECT stock_actual, COALESCE(sku, '') AS sku
           FROM ${tP} WHERE id = $1::uuid AND empresa_id = $2::uuid
           FOR UPDATE`,
        [it.producto_id, empresaId]
      );
      if (pRows.length === 0) {
        // Producto inexistente: abortar toda la confirmación (rollback).
        throw new Error(`Producto ${it.producto_nombre} no encontrado; no se confirmó la nota.`);
      }
      const stockActual = Number(pRows[0].stock_actual) || 0;
      const nuevoStock = stockActual - cant;

      // REGLA EXPLÍCITA: no se permite dejar stock negativo.
      if (nuevoStock < 0) {
        throw new Error(
          `No se puede confirmar: ${it.producto_nombre} quedaría en stock negativo ` +
          `(actual ${stockActual}, a descontar ${cant}). Ajustá el inventario o la cantidad.`
        );
      }

      // Movimiento SALIDA (origen=nota_credito_compra).
      const { rows: movRows } = await client.query<{ id: string }>(
        `INSERT INTO ${tM} (
           empresa_id, producto_id, producto_nombre, producto_sku,
           tipo, cantidad, costo_unitario, origen, referencia, fecha,
           created_by, usuario_nombre
         ) VALUES (
           $1::uuid, $2::uuid, $3, $4,
           'SALIDA', $5::numeric, $6::numeric, 'nota_credito_compra', $7, now(),
           $8::uuid, $9
         )
         RETURNING id`,
        [
          empresaId,
          it.producto_id,
          it.producto_nombre,
          pRows[0].sku,
          cant,
          Number(it.costo_unitario),
          numero,
          audit.created_by,
          audit.usuario_nombre,
        ]
      );
      const movId = movRows[0]?.id ?? null;
      if (movId) movimientos++;

      // Descontar stock al valor calculado (sin recalcular costo_promedio, por decisión de negocio).
      await client.query(
        `UPDATE ${tP}
            SET stock_actual = $1::numeric,
                updated_at = now()
          WHERE id = $2::uuid AND empresa_id = $3::uuid`,
        [nuevoStock, it.producto_id, empresaId]
      );

      // Trazabilidad: guardar el movimiento en el ítem.
      await client.query(
        `UPDATE ${tI} SET movimiento_id = $1::uuid WHERE id = $2::uuid`,
        [movId, it.id]
      );
    }

    await client.query("COMMIT");

    const all = await listNotasCreditoCompra(schema, empresaId);
    const nota = all.find((n) => n.id === ncId)!;
    return { nota, ya_confirmada: false, movimientos_creados: movimientos };
  } catch (err) {
    await client.query("ROLLBACK").catch(() => null);
    throw err;
  } finally {
    client.release();
  }
}
