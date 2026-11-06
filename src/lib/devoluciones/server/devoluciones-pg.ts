/**
 * Motor de devoluciones de ventas.
 *
 * Toda confirmacion/anulacion corre en UNA sola transaccion PostgreSQL
 * (pool directo, BEGIN/COMMIT) con SELECT ... FOR UPDATE sobre la venta, sus
 * lineas y los productos afectados, para que dos devoluciones simultaneas no
 * puedan pasarse de la cantidad disponible ni duplicar stock/caja.
 *
 * Idempotencia: `idempotency_key` unica por empresa. Un doble clic o un reintento
 * devuelve la devolucion ya creada sin volver a impactar stock ni caja.
 *
 * NO modifica ni borra la venta original (solo su campo `estado`).
 * NO emite Nota de Credito ni toca SIFEN.
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";
import { assertAllowedChatDataSchema } from "@/lib/supabase/chat-data-schema";
import {
  DevolucionBloqueadaError,
  calcIvaIncluido,
  round2,
  type CrearDevolucionInput,
  type Devolucion,
  type DevolucionCambioRow,
  type DevolucionItemRow,
  type EstadoDevolucion,
  type MetodoReembolso,
  type ResolucionDevolucion,
  type TipoDevolucion,
  type VentaDevolvible,
} from "@/lib/devoluciones/types";
import { computeLiquidacion } from "@/lib/devoluciones/liquidacion";
import {
  clasificarContextoFiscal,
  type ContextoFiscal,
} from "@/lib/devoluciones/contexto-fiscal";
import {
  buildSifenCancelacionPreview,
  normalizePlazoCancelacionHoras,
} from "@/lib/sifen/sifen-cancelacion-rules";

interface PgClientLike {
  query: (sql: string, params?: unknown[]) => Promise<{ rows: Record<string, unknown>[] }>;
}

export interface UsuarioCtx {
  id: string | null;
  nombre: string | null;
}

function num(v: unknown): number {
  const n = typeof v === "number" ? v : parseFloat(String(v ?? "0"));
  return Number.isFinite(n) ? n : 0;
}
function str(v: unknown): string | null {
  return v == null ? null : String(v);
}
/**
 * Normaliza timestamps a ISO. node-postgres devuelve `Date`, y String(Date) da
 * "Thu Jul 16 2026 ... (hora estándar de Paraguay)", que Postgres NO parsea.
 */
function iso(v: unknown): string | null {
  if (v == null) return null;
  if (v instanceof Date) return v.toISOString();
  return String(v);
}

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool de base de datos no disponible.");
  return p;
}

/** Normaliza el tipo de IVA a los valores validos de ventas ('EXENTA'|'5%'|'10%'). */
function normTipoIva(raw: unknown): string {
  const t = String(raw ?? "").trim().toUpperCase();
  if (t === "5%" || t === "5") return "5%";
  if (t === "EXENTA" || t === "EXENTO" || t === "0%" || t === "0") return "EXENTA";
  return "10%";
}

// ── Lectura: venta devolvible ───────────────────────────────────────────────

/**
 * Venta + lineas con lo ya devuelto (solo devoluciones confirmadas cuentan).
 * Devuelve null si la venta no existe en la empresa.
 */
export async function getVentaDevolvible(
  schemaRaw: string,
  empresaId: string,
  ventaId: string
): Promise<VentaDevolvible | null> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tV = quoteSchemaTable(schema, "ventas");
  const tVI = quoteSchemaTable(schema, "ventas_items");
  const tDI = quoteSchemaTable(schema, "devoluciones_venta_items");
  const tD = quoteSchemaTable(schema, "devoluciones_venta");
  const tFA = quoteSchemaTable(schema, "factura_autoimpresor");
  const tC = quoteSchemaTable(schema, "clientes");
  const tCxc = quoteSchemaTable(schema, "cuentas_por_cobrar");

  const vQ = await pool().query(
    `SELECT v.id::text, v.numero_control, v.fecha, v.estado, v.metodo_pago, v.total,
            v.cliente_id::text AS cliente_id,
            COALESCE(NULLIF(TRIM(c.empresa), ''), NULLIF(TRIM(c.nombre_contacto), ''), NULLIF(TRIM(c.nombre), '')) AS cliente_nombre,
            EXISTS (SELECT 1 FROM ${tFA} fa WHERE fa.venta_id = v.id AND fa.empresa_id = v.empresa_id) AS tiene_factura
       FROM ${tV} v
       LEFT JOIN ${tC} c ON c.id = v.cliente_id AND c.empresa_id = v.empresa_id
      WHERE v.id = $1::uuid AND v.empresa_id = $2::uuid
      LIMIT 1`,
    [ventaId, empresaId]
  );
  const v = vQ.rows[0];
  if (!v) return null;

  // Cuenta por cobrar de la venta: define si es a credito y cuanto sigue pendiente.
  const cxcQ = await pool().query(
    `SELECT saldo FROM ${tCxc}
      WHERE venta_id = $1::uuid AND empresa_id = $2::uuid AND estado <> 'anulado'
      ORDER BY created_at ASC LIMIT 1`,
    [ventaId, empresaId]
  );
  const cxc = cxcQ.rows[0];
  const esCredito = !!cxc;
  const saldoPendiente = cxc ? round2(Math.max(0, num(cxc.saldo))) : 0;

  // Contexto fiscal real: factura ERP + documento electrónico SIFEN + autoimpresor.
  const fiscal = await fetchContextoFiscal(pool(), schema, empresaId, ventaId);

  const lQ = await pool().query(
    `SELECT vi.id::text AS venta_item_id, vi.producto_id::text AS producto_id,
            vi.producto_nombre, vi.sku, vi.tipo_iva, vi.precio_venta, vi.cantidad,
            COALESCE((
              SELECT SUM(di.cantidad_devuelta)
                FROM ${tDI} di
                JOIN ${tD} d ON d.id = di.devolucion_id AND d.estado = 'confirmada'
               WHERE di.venta_item_id = vi.id AND di.empresa_id = vi.empresa_id
            ), 0) AS devuelto
       FROM ${tVI} vi
      WHERE vi.venta_id = $1::uuid AND vi.empresa_id = $2::uuid
      ORDER BY vi.created_at ASC`,
    [ventaId, empresaId]
  );

  return {
    venta_id: String(v.id),
    numero_control: String(v.numero_control ?? ""),
    fecha: iso(v.fecha) ?? "",
    estado: String(v.estado ?? ""),
    metodo_pago: str(v.metodo_pago),
    total: num(v.total),
    cliente_id: str(v.cliente_id),
    cliente_nombre: str(v.cliente_nombre),
    tiene_factura_fiscal: fiscal.tiene_factura_fiscal,
    requiere_nota_credito: fiscal.requiere_nota_credito,
    aviso_fiscal: fiscal.aviso,
    aviso_fiscal_texto: fiscal.aviso_texto,
    es_credito: esCredito,
    saldo_pendiente: saldoPendiente,
    lineas: lQ.rows.map((r) => {
      const vendida = num(r.cantidad);
      const devuelta = num(r.devuelto);
      return {
        venta_item_id: String(r.venta_item_id),
        producto_id: String(r.producto_id),
        producto_nombre: String(r.producto_nombre ?? ""),
        sku: str(r.sku),
        tipo_iva: String(r.tipo_iva ?? "10%"),
        precio_unitario: num(r.precio_venta),
        cantidad_vendida: vendida,
        cantidad_devuelta: devuelta,
        cantidad_disponible: round2(Math.max(0, vendida - devuelta)),
      };
    }),
  };
}

// ── Helpers de caja ─────────────────────────────────────────────────────────

/**
 * Caja abierta a usar. Prefiere la misma caja de la venta si sigue abierta;
 * si no, la abierta mas reciente. null si no hay ninguna abierta.
 */
async function cajaAbierta(
  client: PgClientLike,
  schema: string,
  empresaId: string,
  ventaCajaId: string | null
): Promise<string | null> {
  const t = quoteSchemaTable(schema, "cajas");
  if (ventaCajaId) {
    const q = await client.query(
      `SELECT id::text FROM ${t} WHERE id = $1::uuid AND empresa_id = $2::uuid AND estado = 'abierta' LIMIT 1`,
      [ventaCajaId, empresaId]
    );
    if (q.rows[0]) return String(q.rows[0].id);
  }
  const q = await client.query(
    `SELECT id::text FROM ${t} WHERE empresa_id = $1::uuid AND estado = 'abierta'
      ORDER BY fecha_apertura DESC LIMIT 1`,
    [empresaId]
  );
  return q.rows[0] ? String(q.rows[0].id) : null;
}

/** Siguiente DEV-000001 de la empresa. Requiere advisory lock tomado antes. */
async function siguienteNumero(client: PgClientLike, schema: string, empresaId: string): Promise<string> {
  const t = quoteSchemaTable(schema, "devoluciones_venta");
  const q = await client.query(
    `SELECT numero_devolucion FROM ${t}
      WHERE empresa_id = $1::uuid AND numero_devolucion ~ '^DEV-[0-9]+$'
      ORDER BY (regexp_replace(numero_devolucion, '\\D', '', 'g'))::bigint DESC
      LIMIT 1`,
    [empresaId]
  );
  let next = 1;
  const last = q.rows[0]?.numero_devolucion;
  if (last) {
    const m = String(last).match(/^DEV-(\d+)$/);
    if (m) next = parseInt(m[1], 10) + 1;
  }
  return `DEV-${String(next).padStart(6, "0")}`;
}

// ── Contexto fiscal (factura ERP + SIFEN + autoimpresor) ───────────────────

export interface ContextoFiscalVenta extends ContextoFiscal {
  factura_id: string | null;
  factura_estado: string | null;
  factura_saldo: number;
  factura_monto: number;
}

/**
 * Determina el estado fiscal de la venta para decidir el aviso de nota de crédito
 * y si la factura ERP puede anularse/ajustarse al devolver. Funciona tanto con el
 * pool como con el client de una transacción (ambos exponen .query).
 */
async function fetchContextoFiscal(
  run: PgClientLike,
  schema: string,
  empresaId: string,
  ventaId: string
): Promise<ContextoFiscalVenta> {
  const tV = quoteSchemaTable(schema, "ventas");
  const tF = quoteSchemaTable(schema, "facturas");
  const tFE = quoteSchemaTable(schema, "factura_electronica");
  const tFA = quoteSchemaTable(schema, "factura_autoimpresor");
  const tPg = quoteSchemaTable(schema, "pagos");
  const tCfg = quoteSchemaTable(schema, "empresa_sifen_config");

  const q = await run.query(
    `SELECT
        v.factura_id::text AS factura_id,
        f.estado  AS factura_estado,
        f.saldo   AS factura_saldo,
        f.monto   AS factura_monto,
        fe.estado_sifen,
        fe.sifen_aprobado_at,
        fe.sifen_cancelado_at,
        EXISTS (SELECT 1 FROM ${tFA} fa WHERE fa.venta_id = v.id AND fa.empresa_id = v.empresa_id) AS tiene_autoimpresor,
        COALESCE((SELECT COUNT(*) FROM ${tPg} p WHERE p.factura_id = f.id AND p.empresa_id = v.empresa_id), 0) AS pagos_count,
        (SELECT c.sifen_plazo_cancelacion_horas FROM ${tCfg} c WHERE c.empresa_id = v.empresa_id LIMIT 1) AS plazo_horas
       FROM ${tV} v
       LEFT JOIN ${tF} f  ON f.id = v.factura_id AND f.empresa_id = v.empresa_id
       LEFT JOIN ${tFE} fe ON fe.factura_id = f.id AND fe.empresa_id = v.empresa_id
      WHERE v.id = $1::uuid AND v.empresa_id = $2::uuid
      LIMIT 1`,
    [ventaId, empresaId]
  );
  const r = q.rows[0] ?? {};
  const facturaId = str(r.factura_id);
  const facturaEstado = str(r.factura_estado);
  const tieneFactura = facturaId != null && facturaEstado != null;
  const sifenEstado = str(r.estado_sifen);

  const preview = buildSifenCancelacionPreview({
    estadoSifen: sifenEstado,
    sifenAprobadoAtIso: iso(r.sifen_aprobado_at),
    sifenCanceladoAtIso: iso(r.sifen_cancelado_at),
    plazoHoras: normalizePlazoCancelacionHoras(r.plazo_horas ?? 48),
    pagosCount: num(r.pagos_count),
    nowMs: Date.now(),
  });

  const ctx = clasificarContextoFiscal({
    tieneFactura,
    facturaEstado,
    tieneAutoimpresor: r.tiene_autoimpresor === true,
    sifenEstado,
    puedeCancelarDE: preview.puede_cancelar,
  });

  return {
    ...ctx,
    factura_id: facturaId,
    factura_estado: facturaEstado,
    factura_saldo: num(r.factura_saldo),
    factura_monto: num(r.factura_monto),
  };
}

// ── Motor: crear devolucion ────────────────────────────────────────────────

/**
 * Confirma una devolucion. Atomico: o se escribe todo (devolucion + items +
 * stock + movimientos de inventario + movimiento de caja + estado de la venta)
 * o no se escribe nada.
 */
export async function crearDevolucion(
  schemaRaw: string,
  empresaId: string,
  usuario: UsuarioCtx,
  input: CrearDevolucionInput
): Promise<Devolucion> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tV = quoteSchemaTable(schema, "ventas");
  const tVI = quoteSchemaTable(schema, "ventas_items");
  const tD = quoteSchemaTable(schema, "devoluciones_venta");
  const tDI = quoteSchemaTable(schema, "devoluciones_venta_items");
  const tDC = quoteSchemaTable(schema, "devoluciones_venta_cambios");
  const tP = quoteSchemaTable(schema, "productos");
  const tMI = quoteSchemaTable(schema, "movimientos_inventario");
  const tCM = quoteSchemaTable(schema, "caja_movimientos");

  if (!input.items || input.items.length === 0) {
    throw new DevolucionBloqueadaError("sin_items", "Seleccioná al menos un producto a devolver.");
  }

  const client = await pool().connect();
  try {
    await client.query("BEGIN");

    // ── Idempotencia: si ya se confirmo con esta clave, devolverla tal cual.
    if (input.idempotency_key) {
      const ya = await client.query(
        `SELECT id::text FROM ${tD} WHERE empresa_id = $1::uuid AND idempotency_key = $2 LIMIT 1`,
        [empresaId, input.idempotency_key]
      );
      if (ya.rows[0]) {
        await client.query("COMMIT");
        const dev = await getDevolucion(schema, empresaId, String(ya.rows[0].id));
        if (dev) return dev;
      }
    }

    // ── 1) Venta bloqueada.
    const vQ = await client.query(
      `SELECT id::text, numero_control, fecha, estado, caja_id::text AS caja_id,
              cliente_id::text AS cliente_id
         FROM ${tV} WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
      [input.venta_id, empresaId]
    );
    const venta = vQ.rows[0];
    if (!venta) throw new DevolucionBloqueadaError("venta_no_encontrada", "La venta no existe.");
    if (String(venta.estado) === "anulada") {
      throw new DevolucionBloqueadaError("venta_anulada", "La venta está anulada; no admite devoluciones.");
    }

    // ── 2) Lineas bloqueadas + cantidades ya devueltas.
    const liQ = await client.query(
      `SELECT vi.id::text AS id, vi.producto_id::text AS producto_id, vi.producto_nombre, vi.sku,
              vi.tipo_iva, vi.precio_venta, vi.cantidad,
              COALESCE((
                SELECT SUM(di.cantidad_devuelta) FROM ${tDI} di
                  JOIN ${tD} d ON d.id = di.devolucion_id AND d.estado = 'confirmada'
                 WHERE di.venta_item_id = vi.id AND di.empresa_id = vi.empresa_id
              ), 0) AS devuelto
         FROM ${tVI} vi
        WHERE vi.venta_id = $1::uuid AND vi.empresa_id = $2::uuid
        FOR UPDATE OF vi`,
      [input.venta_id, empresaId]
    );
    const porItem = new Map(liQ.rows.map((r) => [String(r.id), r]));

    // ── 3) Validar cantidades e importar importes DESDE LA VENTA ORIGINAL.
    let totalDevuelto = 0;
    const itemsCalc = input.items.map((it) => {
      const linea = porItem.get(it.venta_item_id);
      if (!linea) {
        throw new DevolucionBloqueadaError("cantidad_excedida", "Una de las líneas no pertenece a esta venta.");
      }
      const vendida = num(linea.cantidad);
      const yaDevuelta = num(linea.devuelto);
      const disponible = round2(vendida - yaDevuelta);
      const cant = num(it.cantidad);
      if (cant <= 0) {
        throw new DevolucionBloqueadaError("cantidad_excedida", "La cantidad a devolver debe ser mayor a cero.");
      }
      if (cant > disponible + 1e-9) {
        throw new DevolucionBloqueadaError(
          "cantidad_excedida",
          `No podés devolver ${cant} de "${String(linea.producto_nombre)}": disponible ${disponible} (vendido ${vendida}, ya devuelto ${yaDevuelta}).`
        );
      }
      const precio = num(linea.precio_venta);
      const tipoIva = String(linea.tipo_iva ?? "10%");
      const total = round2(precio * cant);
      const iva = round2(calcIvaIncluido(tipoIva, total));
      totalDevuelto = round2(totalDevuelto + total);
      // Un producto danado NUNCA reintegra stock.
      const reintegra = it.condicion === "danado" ? false : it.reintegra_stock !== false;
      return {
        venta_item_id: it.venta_item_id,
        producto_id: String(linea.producto_id),
        producto_nombre: String(linea.producto_nombre ?? ""),
        sku: str(linea.sku),
        cantidad_vendida: vendida,
        cantidad_devuelta: cant,
        precio_unitario: precio,
        tipo_iva: tipoIva,
        monto_iva: iva,
        total_devuelto: total,
        condicion: it.condicion,
        reintegra_stock: reintegra,
      };
    });

    // ── 4) Cambios (productos entregados), con precio actual del producto.
    let totalEntregado = 0;
    const cambiosCalc: Array<{
      producto_id: string; producto_nombre: string; sku: string | null;
      cantidad: number; precio_unitario: number; tipo_iva: string;
      monto_iva: number; total: number; controla_stock: boolean;
      costo: number; stock: number;
    }> = [];
    if (input.resolucion === "cambio") {
      for (const cb of input.cambios ?? []) {
        const pQ = await client.query(
          `SELECT id::text, nombre, sku, precio_venta, costo_promedio, stock_actual, controla_stock
             FROM ${tP} WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
          [cb.producto_id, empresaId]
        );
        const p = pQ.rows[0];
        if (!p) throw new DevolucionBloqueadaError("stock_insuficiente_cambio", "El producto del cambio no existe.");
        const cant = num(cb.cantidad);
        if (cant <= 0) continue;
        const controla = p.controla_stock !== false;
        const stock = num(p.stock_actual);
        if (controla && stock < cant) {
          throw new DevolucionBloqueadaError(
            "stock_insuficiente_cambio",
            `Sin stock suficiente de "${String(p.nombre)}": hay ${stock}, se requieren ${cant}.`
          );
        }
        const precio = num(p.precio_venta);
        const total = round2(precio * cant);
        // IVA real del producto entregado (lo elige el cajero); default 10%.
        const tipoIvaCambio = normTipoIva(cb.tipo_iva);
        const iva = round2(calcIvaIncluido(tipoIvaCambio, total));
        totalEntregado = round2(totalEntregado + total);
        cambiosCalc.push({
          producto_id: String(p.id),
          producto_nombre: String(p.nombre ?? ""),
          sku: str(p.sku),
          cantidad: cant,
          precio_unitario: precio,
          tipo_iva: tipoIvaCambio,
          monto_iva: iva,
          total,
          controla_stock: controla,
          costo: num(p.costo_promedio),
          stock,
        });
      }
    }

    // ── 4b) Cuenta por cobrar de la venta (bloqueada): saldo y si es a crédito.
    const tCxc = quoteSchemaTable(schema, "cuentas_por_cobrar");
    const cxcQ = await client.query(
      `SELECT id::text, saldo, total, estado FROM ${tCxc}
        WHERE venta_id = $1::uuid AND empresa_id = $2::uuid AND estado <> 'anulado'
        ORDER BY created_at ASC LIMIT 1
        FOR UPDATE`,
      [input.venta_id, empresaId]
    );
    const cxcRow = cxcQ.rows[0];
    const esCredito = !!cxcRow;
    const saldoPendiente = cxcRow ? round2(Math.max(0, num(cxcRow.saldo))) : 0;

    // ── 5) Liquidación: reparto entre CAJA (dinero real) y DEUDA (CxC).
    const resolucion: ResolucionDevolucion = input.resolucion;
    const metodo: MetodoReembolso = input.metodo ?? "efectivo";
    if (metodo === "credito" && !esCredito) {
      throw new DevolucionBloqueadaError(
        "credito_no_disponible",
        "La diferencia solo puede ir a cuenta (crédito) si la venta original fue a crédito con cuenta del cliente."
      );
    }
    const liq = computeLiquidacion({
      totalDevuelto,
      totalEntregado,
      saldoPendiente,
      resolucion,
      metodo,
      esCredito,
    });
    const diferencia = liq.diferencia;

    // ── 6) Caja: necesaria solo si hay movimiento de dinero (no aplica a crédito).
    const requiereEfectivo = liq.caja !== null && metodo === "efectivo";
    const cajaId = liq.caja !== null ? await cajaAbierta(client, schema, empresaId, str(venta.caja_id)) : null;
    if (requiereEfectivo && !cajaId) {
      throw new DevolucionBloqueadaError(
        "sin_caja_abierta",
        "No hay una caja abierta. Abrí una caja antes de realizar esta devolución."
      );
    }

    // ── 7) Tipo total/parcial: total si tras esta devolucion no queda nada.
    let quedaPendiente = false;
    for (const [id, linea] of porItem) {
      const devueltoAhora = itemsCalc.find((x) => x.venta_item_id === id)?.cantidad_devuelta ?? 0;
      const restante = round2(num(linea.cantidad) - num(linea.devuelto) - devueltoAhora);
      if (restante > 1e-9) quedaPendiente = true;
    }
    const tipo: TipoDevolucion = quedaPendiente ? "parcial" : "total";

    // ── 8) Numero correlativo (advisory lock por empresa dentro de la tx).
    await client.query(`SELECT pg_advisory_xact_lock(hashtext($1))`, [`devolucion:${empresaId}`]);
    const numero = await siguienteNumero(client, schema, empresaId);

    // ── 9) Contexto fiscal: aviso de NC y si la factura ERP se puede anular/ajustar.
    const fiscal = await fetchContextoFiscal(client, schema, empresaId, input.venta_id);
    const requiereNC = fiscal.requiere_nota_credito;
    // Solo tocamos la factura ERP si NO es un documento aprobado por SET
    // (factura_editable) y hay algo que ajustar: devolución total o baja de saldo.
    const tocaFactura =
      fiscal.factura_editable && !!fiscal.factura_id && (!quedaPendiente || liq.reduccionDeuda > 0);

    // ── 10) Cabecera.
    const insD = await client.query(
      `INSERT INTO ${tD} (
         empresa_id, numero_devolucion, venta_id, venta_numero_control, venta_fecha,
         cliente_id, tipo, resolucion, estado, motivo,
         total_devuelto, total_entregado, diferencia, metodo_reembolso,
         caja_id, requiere_nota_credito, idempotency_key, created_by, usuario_nombre,
         cxc_reduccion, cxc_aumento, factura_estado_previo, factura_saldo_previo
       ) VALUES (
         $1::uuid, $2, $3::uuid, $4, $5::timestamptz,
         $6::uuid, $7, $8, 'confirmada', $9,
         $10, $11, $12, $13,
         $14::uuid, $15::boolean, $16, $17::uuid, $18,
         $19, $20, $21, $22
       ) RETURNING id::text`,
      [
        empresaId, numero, input.venta_id, str(venta.numero_control), iso(venta.fecha),
        str(venta.cliente_id), tipo, resolucion, input.motivo?.trim() || null,
        totalDevuelto, totalEntregado, diferencia, diferencia !== 0 ? metodo : null,
        cajaId, requiereNC, input.idempotency_key || null, usuario.id, usuario.nombre,
        liq.reduccionDeuda, liq.aumentoDeuda,
        tocaFactura ? fiscal.factura_estado : null,
        tocaFactura ? fiscal.factura_saldo : null,
      ]
    );
    const devolucionId = String(insD.rows[0].id);

    // ── 11) Items + reintegro de stock + movimiento ENTRADA.
    for (const it of itemsCalc) {
      await client.query(
        `INSERT INTO ${tDI} (
           empresa_id, devolucion_id, venta_item_id, producto_id, producto_nombre, sku,
           cantidad_vendida, cantidad_devuelta, precio_unitario, tipo_iva, monto_iva,
           total_devuelto, condicion, reintegra_stock
         ) VALUES ($1::uuid,$2::uuid,$3::uuid,$4::uuid,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14::boolean)`,
        [
          empresaId, devolucionId, it.venta_item_id, it.producto_id, it.producto_nombre, it.sku,
          it.cantidad_vendida, it.cantidad_devuelta, it.precio_unitario, it.tipo_iva, it.monto_iva,
          it.total_devuelto, it.condicion, it.reintegra_stock,
        ]
      );
      if (!it.reintegra_stock) continue; // danado o marcado como no reintegrable
      const pQ = await client.query(
        `SELECT costo_promedio, controla_stock FROM ${tP}
          WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
        [it.producto_id, empresaId]
      );
      const p = pQ.rows[0];
      if (!p || p.controla_stock === false) continue; // sin control de stock: nada que mover
      await client.query(
        `UPDATE ${tP} SET stock_actual = stock_actual + $3, updated_at = now()
          WHERE id = $1::uuid AND empresa_id = $2::uuid`,
        [it.producto_id, empresaId, it.cantidad_devuelta]
      );
      await client.query(
        `INSERT INTO ${tMI} (
           empresa_id, producto_id, producto_nombre, producto_sku, tipo, cantidad,
           costo_unitario, origen, referencia, venta_id, devolucion_id, created_by, usuario_nombre
         ) VALUES ($1::uuid,$2::uuid,$3,$4,'ENTRADA',$5,$6,'devolucion_venta',$7,$8::uuid,$9::uuid,$10::uuid,$11)`,
        [
          empresaId, it.producto_id, it.producto_nombre, it.sku ?? "", it.cantidad_devuelta,
          num(p.costo_promedio), numero, input.venta_id, devolucionId, usuario.id, usuario.nombre,
        ]
      );
    }

    // ── 12) Cambios: descuento de stock + movimiento SALIDA.
    for (const cb of cambiosCalc) {
      await client.query(
        `INSERT INTO ${tDC} (
           empresa_id, devolucion_id, producto_id, producto_nombre, sku,
           cantidad, precio_unitario, tipo_iva, monto_iva, total
         ) VALUES ($1::uuid,$2::uuid,$3::uuid,$4,$5,$6,$7,$8,$9,$10)`,
        [empresaId, devolucionId, cb.producto_id, cb.producto_nombre, cb.sku,
         cb.cantidad, cb.precio_unitario, cb.tipo_iva, cb.monto_iva, cb.total]
      );
      if (!cb.controla_stock) continue;
      await client.query(
        `UPDATE ${tP} SET stock_actual = stock_actual - $3, updated_at = now()
          WHERE id = $1::uuid AND empresa_id = $2::uuid`,
        [cb.producto_id, empresaId, cb.cantidad]
      );
      await client.query(
        `INSERT INTO ${tMI} (
           empresa_id, producto_id, producto_nombre, producto_sku, tipo, cantidad,
           costo_unitario, origen, referencia, venta_id, devolucion_id, created_by, usuario_nombre
         ) VALUES ($1::uuid,$2::uuid,$3,$4,'SALIDA',$5,$6,'devolucion_venta',$7,$8::uuid,$9::uuid,$10::uuid,$11)`,
        [
          empresaId, cb.producto_id, cb.producto_nombre, cb.sku ?? "", cb.cantidad,
          cb.costo, numero, input.venta_id, devolucionId, usuario.id, usuario.nombre,
        ]
      );
    }

    // ── 13) Movimiento de caja por la diferencia.
    //  diferencia < 0 -> egreso (le devolvemos plata al cliente)
    //  diferencia > 0 -> ingreso (el cliente paga la diferencia)
    //  Tarjeta/transferencia se registran con su medio_pago: el resumen de caja
    //  solo suma efectivo, asi que no afectan el efectivo fisico esperado.
    let cajaMovId: string | null = null;
    if (liq.caja && cajaId) {
      const tipoMov = liq.caja.tipo;
      const concepto =
        tipoMov === "ingreso"
          ? `Diferencia a cobrar por devolución ${numero}`
          : `Reembolso por devolución ${numero}`;
      const insM = await client.query(
        `INSERT INTO ${tCM} (
           empresa_id, caja_id, tipo, concepto, monto, medio_pago, usuario_id,
           observacion, devolucion_id, venta_id
         ) VALUES ($1::uuid,$2::uuid,$3,$4,$5,$6,$7::uuid,$8,$9::uuid,$10::uuid)
         RETURNING id::text`,
        [
          empresaId, cajaId, tipoMov, concepto, liq.caja.monto, metodo, usuario.id,
          `Venta ${String(venta.numero_control ?? "")} · devolución ${numero}`,
          devolucionId, input.venta_id,
        ]
      );
      cajaMovId = String(insM.rows[0].id);
      await client.query(`UPDATE ${tD} SET caja_movimiento_id = $2::uuid WHERE id = $1::uuid`, [devolucionId, cajaMovId]);
    }

    // ── 14) Estado de la venta (la venta NO se borra ni se sobrescribe).
    const nuevoEstado = quedaPendiente ? "parcialmente_devuelta" : "devuelta_total";
    await client.query(
      `UPDATE ${tV} SET estado = $3, updated_at = now() WHERE id = $1::uuid AND empresa_id = $2::uuid`,
      [input.venta_id, empresaId, nuevoEstado]
    );

    // ── 14b) Venta a CRÉDITO: aplicar el reparto calculado a la cuenta por cobrar.
    //
    // A diferencia del comportamiento anterior (que bajaba la deuda por TODO lo
    // devuelto, borrando deuda impaga o reembolsando dinero no cobrado), ahora el
    // saldo solo se mueve por lo que la liquidación determinó: baja por la parte
    // impaga de lo devuelto (reduccionDeuda) y sube si la diferencia de un cambio
    // se dejó a cuenta (aumentoDeuda, método "credito"). El dinero realmente
    // pagado se reembolsa por caja, nunca descontando de la deuda.
    if (esCredito && (liq.reduccionDeuda > 0 || liq.aumentoDeuda > 0)) {
      await client.query(
        `UPDATE ${tCxc}
            SET saldo = GREATEST(0, COALESCE(saldo, 0) - $3::numeric + $4::numeric),
                total = GREATEST(0, COALESCE(total, 0) + $4::numeric),
                estado = CASE
                  WHEN GREATEST(0, COALESCE(saldo, 0) - $3::numeric + $4::numeric) <= 0 THEN 'anulado'
                  WHEN GREATEST(0, COALESCE(saldo, 0) - $3::numeric + $4::numeric) < COALESCE(total, 0) + $4::numeric THEN 'parcial'
                  ELSE 'pendiente'
                END,
                updated_at = now()
          WHERE empresa_id = $2::uuid
            AND venta_id = $1::uuid
            AND estado <> 'anulado'`,
        [input.venta_id, empresaId, liq.reduccionDeuda, liq.aumentoDeuda]
      );
    }

    // ── 14c) Factura ERP (solo si NO es documento aprobado por SET).
    //  - Devolución total  -> anular la factura (no fiscal / no enviada a SET),
    //    así no queda "Pendiente" con la deuda ya en 0 ni se puede enviar luego.
    //  - Devolución parcial -> bajar el saldo por la parte impaga devuelta.
    // El estado/saldo previo se guardó en la cabecera para poder revertir.
    if (tocaFactura) {
      const tF = quoteSchemaTable(schema, "facturas");
      if (!quedaPendiente) {
        await client.query(
          `UPDATE ${tF} SET estado = 'Anulado', saldo = 0, updated_at = now()
            WHERE id = $1::uuid AND empresa_id = $2::uuid AND estado <> 'Anulado'`,
          [fiscal.factura_id, empresaId]
        );
      } else if (liq.reduccionDeuda > 0) {
        await client.query(
          `UPDATE ${tF} SET saldo = GREATEST(0, COALESCE(saldo, 0) - $3::numeric), updated_at = now()
            WHERE id = $1::uuid AND empresa_id = $2::uuid AND estado <> 'Anulado'`,
          [fiscal.factura_id, empresaId, liq.reduccionDeuda]
        );
      }
    }

    await client.query("COMMIT");

    const dev = await getDevolucion(schema, empresaId, devolucionId);
    if (!dev) throw new Error("No se pudo leer la devolución recién creada.");
    return dev;
  } catch (e) {
    await client.query("ROLLBACK").catch(() => {});
    throw e;
  } finally {
    client.release();
  }
}

// ── Anulacion (movimientos inversos, tambien transaccional) ─────────────────

export async function anularDevolucion(
  schemaRaw: string,
  empresaId: string,
  usuario: UsuarioCtx,
  devolucionId: string,
  motivo: string | null
): Promise<Devolucion> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tD = quoteSchemaTable(schema, "devoluciones_venta");
  const tDI = quoteSchemaTable(schema, "devoluciones_venta_items");
  const tDC = quoteSchemaTable(schema, "devoluciones_venta_cambios");
  const tV = quoteSchemaTable(schema, "ventas");
  const tVI = quoteSchemaTable(schema, "ventas_items");
  const tP = quoteSchemaTable(schema, "productos");
  const tMI = quoteSchemaTable(schema, "movimientos_inventario");
  const tCM = quoteSchemaTable(schema, "caja_movimientos");

  const client = await pool().connect();
  try {
    await client.query("BEGIN");

    const dQ = await client.query(
      `SELECT id::text, numero_devolucion, venta_id::text AS venta_id, estado, diferencia,
              metodo_reembolso, caja_id::text AS caja_id,
              caja_movimiento_id::text AS caja_movimiento_id,
              total_devuelto, cxc_reduccion, cxc_aumento,
              factura_estado_previo, factura_saldo_previo
         FROM ${tD} WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
      [devolucionId, empresaId]
    );
    const d = dQ.rows[0];
    if (!d) throw new DevolucionBloqueadaError("devolucion_no_encontrada", "La devolución no existe.");
    if (String(d.estado) === "anulada") {
      throw new DevolucionBloqueadaError("devolucion_ya_anulada", "La devolución ya está anulada.");
    }
    const numero = String(d.numero_devolucion);

    // Revertir stock de los items devueltos que SI habian reintegrado.
    const itQ = await client.query(
      `SELECT producto_id::text AS producto_id, producto_nombre, sku, cantidad_devuelta, reintegra_stock
         FROM ${tDI} WHERE devolucion_id = $1::uuid AND empresa_id = $2::uuid`,
      [devolucionId, empresaId]
    );
    for (const it of itQ.rows) {
      if (it.reintegra_stock !== true) continue;
      const pQ = await client.query(
        `SELECT costo_promedio, controla_stock FROM ${tP} WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
        [String(it.producto_id), empresaId]
      );
      const p = pQ.rows[0];
      if (!p || p.controla_stock === false) continue;
      await client.query(
        `UPDATE ${tP} SET stock_actual = stock_actual - $3, updated_at = now() WHERE id = $1::uuid AND empresa_id = $2::uuid`,
        [String(it.producto_id), empresaId, num(it.cantidad_devuelta)]
      );
      await client.query(
        `INSERT INTO ${tMI} (
           empresa_id, producto_id, producto_nombre, producto_sku, tipo, cantidad,
           costo_unitario, origen, referencia, venta_id, devolucion_id, created_by, usuario_nombre
         ) VALUES ($1::uuid,$2::uuid,$3,$4,'SALIDA',$5,$6,'devolucion_venta',$7,$8::uuid,$9::uuid,$10::uuid,$11)`,
        [
          empresaId, String(it.producto_id), String(it.producto_nombre), str(it.sku) ?? "",
          num(it.cantidad_devuelta), num(p.costo_promedio), `Anulación ${numero}`,
          String(d.venta_id), devolucionId, usuario.id, usuario.nombre,
        ]
      );
    }

    // Devolver al stock los productos que se habian entregado como cambio.
    const cbQ = await client.query(
      `SELECT producto_id::text AS producto_id, producto_nombre, sku, cantidad
         FROM ${tDC} WHERE devolucion_id = $1::uuid AND empresa_id = $2::uuid`,
      [devolucionId, empresaId]
    );
    for (const cb of cbQ.rows) {
      const pQ = await client.query(
        `SELECT costo_promedio, controla_stock FROM ${tP} WHERE id = $1::uuid AND empresa_id = $2::uuid FOR UPDATE`,
        [String(cb.producto_id), empresaId]
      );
      const p = pQ.rows[0];
      if (!p || p.controla_stock === false) continue;
      await client.query(
        `UPDATE ${tP} SET stock_actual = stock_actual + $3, updated_at = now() WHERE id = $1::uuid AND empresa_id = $2::uuid`,
        [String(cb.producto_id), empresaId, num(cb.cantidad)]
      );
      await client.query(
        `INSERT INTO ${tMI} (
           empresa_id, producto_id, producto_nombre, producto_sku, tipo, cantidad,
           costo_unitario, origen, referencia, venta_id, devolucion_id, created_by, usuario_nombre
         ) VALUES ($1::uuid,$2::uuid,$3,$4,'ENTRADA',$5,$6,'devolucion_venta',$7,$8::uuid,$9::uuid,$10::uuid,$11)`,
        [
          empresaId, String(cb.producto_id), String(cb.producto_nombre), str(cb.sku) ?? "",
          num(cb.cantidad), num(p.costo_promedio), `Anulación ${numero}`,
          String(d.venta_id), devolucionId, usuario.id, usuario.nombre,
        ]
      );
    }

    // Movimiento de caja inverso. Se basa en el movimiento REALMENTE registrado
    // (puede no haber ido a caja: p.ej. crédito, o reembolso de algo impago), no
    // en la diferencia. Para devoluciones previas a Fase A (sin caja_movimiento_id
    // guardado) se cae al comportamiento histórico basado en la diferencia.
    let movInvId: string | null = null;
    let origTipo: string | null = null;
    let origMonto = 0;
    if (d.caja_movimiento_id) {
      const omQ = await client.query(
        `SELECT tipo, monto FROM ${tCM} WHERE id = $1::uuid AND empresa_id = $2::uuid LIMIT 1`,
        [String(d.caja_movimiento_id), empresaId]
      );
      if (omQ.rows[0]) {
        origTipo = String(omQ.rows[0].tipo);
        origMonto = num(omQ.rows[0].monto);
      }
    }
    if (!origTipo && num(d.diferencia) !== 0 && d.caja_id) {
      origTipo = num(d.diferencia) > 0 ? "ingreso" : "egreso";
      origMonto = Math.abs(num(d.diferencia));
    }
    if (origTipo && origMonto > 0 && d.caja_id) {
      const cajaDestino = await cajaAbierta(client, schema, empresaId, str(d.caja_id));
      if (cajaDestino) {
        const tipoInv = origTipo === "ingreso" ? "egreso" : "ingreso"; // inverso del original
        const insM = await client.query(
          `INSERT INTO ${tCM} (
             empresa_id, caja_id, tipo, concepto, monto, medio_pago, usuario_id,
             observacion, devolucion_id, venta_id
           ) VALUES ($1::uuid,$2::uuid,$3,$4,$5,$6,$7::uuid,$8,$9::uuid,$10::uuid)
           RETURNING id::text`,
          [
            empresaId, cajaDestino, tipoInv, `Anulación de devolución ${numero}`,
            origMonto, str(d.metodo_reembolso) ?? "efectivo", usuario.id,
            `Reverso automático de ${numero}`, devolucionId, String(d.venta_id),
          ]
        );
        movInvId = String(insM.rows[0].id);
      }
    }

    // Marcar anulada (NO se borra: queda auditada).
    await client.query(
      `UPDATE ${tD} SET estado = 'anulada', anulada_at = now(), anulada_por = $2::uuid,
              anulada_motivo = $3, anulada_caja_movimiento_id = $4::uuid, updated_at = now()
        WHERE id = $1::uuid`,
      [devolucionId, usuario.id, motivo?.trim() || null, movInvId]
    );

    // Recalcular estado de la venta con las devoluciones que siguen confirmadas.
    const restQ = await client.query(
      `SELECT COALESCE(SUM(vi.cantidad), 0) AS vendida,
              COALESCE((
                SELECT SUM(di.cantidad_devuelta) FROM ${tDI} di
                  JOIN ${tD} dd ON dd.id = di.devolucion_id AND dd.estado = 'confirmada'
                 WHERE di.empresa_id = $2::uuid
                   AND di.venta_item_id IN (SELECT id FROM ${tVI} WHERE venta_id = $1::uuid AND empresa_id = $2::uuid)
              ), 0) AS devuelta
         FROM ${tVI} vi WHERE vi.venta_id = $1::uuid AND vi.empresa_id = $2::uuid`,
      [String(d.venta_id), empresaId]
    );
    const vendida = num(restQ.rows[0]?.vendida);
    const devuelta = num(restQ.rows[0]?.devuelta);
    const estadoVenta = devuelta <= 1e-9 ? "completada" : devuelta >= vendida - 1e-9 ? "devuelta_total" : "parcialmente_devuelta";
    await client.query(
      `UPDATE ${tV} SET estado = $3, updated_at = now() WHERE id = $1::uuid AND empresa_id = $2::uuid`,
      [String(d.venta_id), empresaId, estadoVenta]
    );

    // Al confirmar la devolución se ajustó la cuenta por cobrar (bajó por lo impago
    // y/o subió por un cambio a crédito). Al anular se revierte EXACTAMENTE ese
    // ajuste. Para devoluciones previas a Fase A (cxc_reduccion NULL) se usa el
    // comportamiento histórico: revertir por total_devuelto.
    const tCxcAnu = quoteSchemaTable(schema, "cuentas_por_cobrar");
    const reduccionAplicada = d.cxc_reduccion != null ? num(d.cxc_reduccion) : num(d.total_devuelto);
    const aumentoAplicado = d.cxc_aumento != null ? num(d.cxc_aumento) : 0;
    if (reduccionAplicada > 0 || aumentoAplicado > 0) {
      await client.query(
        `UPDATE ${tCxcAnu}
            SET saldo = GREATEST(0, COALESCE(saldo, 0) + $3::numeric - $4::numeric),
                total = GREATEST(0, COALESCE(total, 0) - $4::numeric),
                estado = CASE
                  WHEN GREATEST(0, COALESCE(saldo, 0) + $3::numeric - $4::numeric) <= 0 THEN estado
                  WHEN estado = 'anulado' THEN 'pendiente'
                  ELSE estado
                END,
                updated_at = now()
          WHERE empresa_id = $2::uuid AND venta_id = $1::uuid`,
        [String(d.venta_id), empresaId, reduccionAplicada, aumentoAplicado]
      );
    }

    // Restaurar la factura ERP al estado/saldo previo si la devolución la había
    // anulado o ajustado (solo aplica a facturas no aprobadas por SET).
    if (d.factura_estado_previo != null) {
      const tF = quoteSchemaTable(schema, "facturas");
      const fQ = await client.query(
        `SELECT factura_id::text AS factura_id FROM ${tV} WHERE id = $1::uuid AND empresa_id = $2::uuid LIMIT 1`,
        [String(d.venta_id), empresaId]
      );
      const facturaId = str(fQ.rows[0]?.factura_id);
      if (facturaId) {
        await client.query(
          `UPDATE ${tF} SET estado = $3, saldo = $4::numeric, updated_at = now()
            WHERE id = $1::uuid AND empresa_id = $2::uuid`,
          [facturaId, empresaId, String(d.factura_estado_previo), num(d.factura_saldo_previo)]
        );
      }
    }

    await client.query("COMMIT");
    const dev = await getDevolucion(schema, empresaId, devolucionId);
    if (!dev) throw new Error("No se pudo leer la devolución anulada.");
    return dev;
  } catch (e) {
    await client.query("ROLLBACK").catch(() => {});
    throw e;
  } finally {
    client.release();
  }
}

// ── Lecturas ───────────────────────────────────────────────────────────────

const D_COLS = `
  d.id::text, d.numero_devolucion, d.venta_id::text AS venta_id, d.venta_numero_control,
  d.venta_fecha, d.cliente_id::text AS cliente_id, d.tipo, d.resolucion, d.estado, d.motivo,
  d.total_devuelto, d.total_entregado, d.diferencia, d.metodo_reembolso,
  d.caja_id::text AS caja_id, d.caja_movimiento_id::text AS caja_movimiento_id,
  d.requiere_nota_credito, d.created_by::text AS created_by, d.usuario_nombre,
  d.created_at, d.anulada_at, d.anulada_motivo
`;

function mapDev(r: Record<string, unknown>, clienteNombre?: string | null): Devolucion {
  return {
    id: String(r.id),
    numero_devolucion: String(r.numero_devolucion),
    venta_id: String(r.venta_id),
    venta_numero_control: str(r.venta_numero_control),
    venta_fecha: iso(r.venta_fecha),
    cliente_id: str(r.cliente_id),
    cliente_nombre: clienteNombre ?? str(r.cliente_nombre),
    tipo: (r.tipo === "total" ? "total" : "parcial") as TipoDevolucion,
    resolucion: (r.resolucion === "cambio" ? "cambio" : "reembolso") as ResolucionDevolucion,
    estado: (r.estado === "anulada" ? "anulada" : "confirmada") as EstadoDevolucion,
    motivo: str(r.motivo),
    total_devuelto: num(r.total_devuelto),
    total_entregado: num(r.total_entregado),
    diferencia: num(r.diferencia),
    metodo_reembolso: (str(r.metodo_reembolso) as MetodoReembolso | null),
    caja_id: str(r.caja_id),
    caja_movimiento_id: str(r.caja_movimiento_id),
    requiere_nota_credito: r.requiere_nota_credito === true,
    created_by: str(r.created_by),
    usuario_nombre: str(r.usuario_nombre),
    created_at: iso(r.created_at) ?? "",
    anulada_at: iso(r.anulada_at),
    anulada_motivo: str(r.anulada_motivo),
  };
}

export async function getDevolucion(
  schemaRaw: string,
  empresaId: string,
  id: string
): Promise<Devolucion | null> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tD = quoteSchemaTable(schema, "devoluciones_venta");
  const tDI = quoteSchemaTable(schema, "devoluciones_venta_items");
  const tDC = quoteSchemaTable(schema, "devoluciones_venta_cambios");
  const tC = quoteSchemaTable(schema, "clientes");

  const q = await pool().query(
    `SELECT ${D_COLS},
            COALESCE(NULLIF(TRIM(c.empresa), ''), NULLIF(TRIM(c.nombre_contacto), ''), NULLIF(TRIM(c.nombre), '')) AS cliente_nombre
       FROM ${tD} d
       LEFT JOIN ${tC} c ON c.id = d.cliente_id AND c.empresa_id = d.empresa_id
      WHERE d.id = $1::uuid AND d.empresa_id = $2::uuid LIMIT 1`,
    [id, empresaId]
  );
  const r = q.rows[0];
  if (!r) return null;

  const itQ = await pool().query(
    `SELECT id::text, venta_item_id::text AS venta_item_id, producto_id::text AS producto_id,
            producto_nombre, sku, cantidad_vendida, cantidad_devuelta, precio_unitario,
            tipo_iva, monto_iva, total_devuelto, condicion, reintegra_stock
       FROM ${tDI} WHERE devolucion_id = $1::uuid AND empresa_id = $2::uuid ORDER BY created_at ASC`,
    [id, empresaId]
  );
  const cbQ = await pool().query(
    `SELECT id::text, producto_id::text AS producto_id, producto_nombre, sku,
            cantidad, precio_unitario, tipo_iva, monto_iva, total
       FROM ${tDC} WHERE devolucion_id = $1::uuid AND empresa_id = $2::uuid ORDER BY created_at ASC`,
    [id, empresaId]
  );

  const dev = mapDev(r, str(r.cliente_nombre));
  dev.items = itQ.rows.map((x): DevolucionItemRow => ({
    id: String(x.id),
    venta_item_id: String(x.venta_item_id),
    producto_id: String(x.producto_id),
    producto_nombre: String(x.producto_nombre ?? ""),
    sku: str(x.sku),
    cantidad_vendida: num(x.cantidad_vendida),
    cantidad_devuelta: num(x.cantidad_devuelta),
    precio_unitario: num(x.precio_unitario),
    tipo_iva: String(x.tipo_iva ?? ""),
    monto_iva: num(x.monto_iva),
    total_devuelto: num(x.total_devuelto),
    condicion: x.condicion === "danado" ? "danado" : "buen_estado",
    reintegra_stock: x.reintegra_stock === true,
  }));
  dev.cambios = cbQ.rows.map((x): DevolucionCambioRow => ({
    id: String(x.id),
    producto_id: String(x.producto_id),
    producto_nombre: String(x.producto_nombre ?? ""),
    sku: str(x.sku),
    cantidad: num(x.cantidad),
    precio_unitario: num(x.precio_unitario),
    tipo_iva: String(x.tipo_iva ?? ""),
    monto_iva: num(x.monto_iva),
    total: num(x.total),
  }));
  return dev;
}

export async function listarDevoluciones(
  schemaRaw: string,
  empresaId: string,
  opts: { limit?: number } = {}
): Promise<Devolucion[]> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tD = quoteSchemaTable(schema, "devoluciones_venta");
  const tC = quoteSchemaTable(schema, "clientes");
  const limit = Math.min(Math.max(opts.limit ?? 200, 1), 500);
  const q = await pool().query(
    `SELECT ${D_COLS},
            COALESCE(NULLIF(TRIM(c.empresa), ''), NULLIF(TRIM(c.nombre_contacto), ''), NULLIF(TRIM(c.nombre), '')) AS cliente_nombre
       FROM ${tD} d
       LEFT JOIN ${tC} c ON c.id = d.cliente_id AND c.empresa_id = d.empresa_id
      WHERE d.empresa_id = $1::uuid
      ORDER BY d.created_at DESC
      LIMIT ${limit}`,
    [empresaId]
  );
  return q.rows.map((r) => mapDev(r, str(r.cliente_nombre)));
}
