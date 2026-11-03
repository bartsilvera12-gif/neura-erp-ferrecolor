/**
 * Pagos a proveedores, con pagos parciales.
 *
 * Antes la compra era pagada o no pagada, todo o nada. Ahora cada pago se
 * guarda por separado y el saldo se DERIVA: total de la compra menos la suma de
 * los pagos no anulados. `compras.estado_pago` se recalcula a partir de eso
 * (pendiente | parcial | pagada) y queda como reflejo, no como fuente de verdad:
 * si fuera un contador podria desincronizarse de los pagos reales.
 *
 * Una compra son N filas que comparten `numero_control` (una por producto), asi
 * que el pago se ata al numero_control: se paga la factura, no el renglon.
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";

export class PagoProveedorError extends Error {
  status: number;
  constructor(message: string, status = 400) {
    super(message);
    this.name = "PagoProveedorError";
    this.status = status;
  }
}

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new PagoProveedorError("Pool de base de datos no disponible.", 500);
  return p;
}

export type MetodoPagoProveedor = "efectivo" | "transferencia" | "tarjeta" | "cheque" | "otro";

function metodoValido(m: unknown): MetodoPagoProveedor {
  return m === "transferencia" || m === "tarjeta" || m === "cheque" || m === "otro" ? m : "efectivo";
}

export type SaldoCompra = {
  numero_control: string;
  proveedor_nombre: string | null;
  total: number;
  pagado: number;
  saldo: number;
  estado_pago: "pendiente" | "parcial" | "pagada";
};

/** Total, pagado y saldo de una compra. Lanza si no existe o está anulada. */
export async function getSaldoCompra(
  schema: string,
  empresaId: string,
  numeroControl: string
): Promise<SaldoCompra> {
  const tC = quoteSchemaTable(schema, "compras");
  const tP = quoteSchemaTable(schema, "pagos_proveedores");
  const c = await pool().connect();
  try {
    const r = await c.query(
      `SELECT MIN(proveedor_nombre) AS proveedor_nombre,
              SUM(total)::float8 AS total,
              COUNT(*) FILTER (WHERE anulada_at IS NOT NULL)::int AS anuladas,
              COUNT(*)::int AS filas
         FROM ${tC} WHERE empresa_id = $1::uuid AND numero_control = $2`,
      [empresaId, numeroControl]
    );
    const row = r.rows[0] as { proveedor_nombre: string | null; total: number; anuladas: number; filas: number };
    if (!row || row.filas === 0) throw new PagoProveedorError("Compra no encontrada.", 404);
    if (row.anuladas > 0) throw new PagoProveedorError("La compra está anulada; no admite pagos.", 409);

    const pg = await c.query(
      `SELECT COALESCE(SUM(monto),0)::float8 AS pagado FROM ${tP}
        WHERE empresa_id = $1::uuid AND numero_control = $2 AND anulado_at IS NULL`,
      [empresaId, numeroControl]
    );
    const total = Math.round(Number(row.total) || 0);
    const pagado = Math.round(Number((pg.rows[0] as { pagado: number }).pagado) || 0);
    const saldo = Math.max(0, total - pagado);
    return {
      numero_control: numeroControl,
      proveedor_nombre: row.proveedor_nombre,
      total,
      pagado,
      saldo,
      estado_pago: saldo <= 0 ? "pagada" : pagado > 0 ? "parcial" : "pendiente",
    };
  } finally {
    c.release();
  }
}

export interface RegistrarPagoProveedorInput {
  schema: string;
  empresaId: string;
  numeroControl: string;
  monto: number;
  metodoPago?: MetodoPagoProveedor;
  fechaPago?: string | null;
  referencia?: string | null;
  observaciones?: string | null;
  /** Descontar de la caja abierta (egreso). */
  descontarCaja?: boolean;
  usuarioId?: string | null;
  usuarioNombre?: string | null;
  usuarioEmail?: string | null;
}

/**
 * Registra un pago (total o parcial) y recalcula el estado de la compra.
 * Todo en una transacción: si el egreso de caja falla, el pago no queda.
 */
export async function registrarPagoProveedor(
  input: RegistrarPagoProveedorInput
): Promise<{ pago_id: string; pagado: number; saldo: number; estado_pago: string }> {
  const monto = Math.round(Number(input.monto) || 0);
  if (!(monto > 0)) throw new PagoProveedorError("El monto del pago debe ser mayor a cero.");

  const tC = quoteSchemaTable(input.schema, "compras");
  const tP = quoteSchemaTable(input.schema, "pagos_proveedores");
  const tCajas = quoteSchemaTable(input.schema, "cajas");
  const tMov = quoteSchemaTable(input.schema, "caja_movimientos");
  const metodo = metodoValido(input.metodoPago);

  const client = await pool().connect();
  try {
    await client.query("BEGIN");

    // FOR UPDATE sobre las filas de la compra: sin el lock, dos pagos
    // simultaneos leen el mismo saldo y entre los dos pagan de mas.
    const cQ = await client.query(
      `SELECT id, proveedor_id, proveedor_nombre, total::float8 AS total, anulada_at
         FROM ${tC} WHERE empresa_id = $1::uuid AND numero_control = $2 FOR UPDATE`,
      [input.empresaId, input.numeroControl]
    );
    if (cQ.rows.length === 0) throw new PagoProveedorError("Compra no encontrada.", 404);
    const filas = cQ.rows as unknown as Array<{
      proveedor_id: string | null; proveedor_nombre: string | null; total: number; anulada_at: string | null;
    }>;
    if (filas.some((f) => f.anulada_at)) {
      throw new PagoProveedorError("La compra está anulada; no admite pagos.", 409);
    }
    const total = Math.round(filas.reduce((s, f) => s + (Number(f.total) || 0), 0));

    const pgQ = await client.query(
      `SELECT COALESCE(SUM(monto),0)::float8 AS pagado FROM ${tP}
        WHERE empresa_id = $1::uuid AND numero_control = $2 AND anulado_at IS NULL`,
      [input.empresaId, input.numeroControl]
    );
    const pagadoAntes = Math.round(Number((pgQ.rows[0] as { pagado: number }).pagado) || 0);
    const saldoAntes = total - pagadoAntes;
    if (saldoAntes <= 0) throw new PagoProveedorError("La compra ya está totalmente pagada.", 409);
    if (monto > saldoAntes) {
      throw new PagoProveedorError(
        `El monto (${monto.toLocaleString("es-PY")}) supera el saldo pendiente (${saldoAntes.toLocaleString("es-PY")}).`
      );
    }

    // Egreso de caja. Igual que en gastos: solo desde una caja abierta.
    let cajaMovimientoId: string | null = null;
    if (input.descontarCaja) {
      const kQ = await client.query(
        `SELECT id FROM ${tCajas} WHERE empresa_id = $1::uuid AND estado = 'abierta'
          ORDER BY fecha_apertura DESC LIMIT 1`,
        [input.empresaId]
      );
      if (kQ.rows.length === 0) {
        throw new PagoProveedorError(
          "No hay caja abierta para descontar el pago. Abrí una caja o desactivá «Descontar de caja».",
          409
        );
      }
      const prov = filas[0].proveedor_nombre ?? "";
      const concepto = `Pago compra ${input.numeroControl}${prov ? ` - ${prov}` : ""}`.slice(0, 200);
      const mQ = await client.query(
        `INSERT INTO ${tMov} (empresa_id, caja_id, tipo, concepto, monto, medio_pago, usuario_id, usuario_email)
         VALUES ($1::uuid,$2::uuid,'egreso',$3,$4::numeric,$5,$6::uuid,$7) RETURNING id`,
        [
          input.empresaId, (kQ.rows[0] as { id: string }).id, concepto, monto,
          metodo === "cheque" ? "otro" : metodo,
          input.usuarioId || null, input.usuarioEmail || null,
        ]
      );
      cajaMovimientoId = String((mQ.rows[0] as { id: string }).id);
    }

    const insQ = await client.query(
      `INSERT INTO ${tP}
         (empresa_id, numero_control, proveedor_id, proveedor_nombre, fecha_pago, monto,
          metodo_pago, referencia, observaciones, caja_movimiento_id, usuario_id, usuario_nombre)
       VALUES ($1::uuid,$2,$3::uuid,$4,COALESCE($5::timestamptz, now()),$6::numeric,$7,$8,$9,$10::uuid,$11::uuid,$12)
       RETURNING id`,
      [
        input.empresaId, input.numeroControl, filas[0].proveedor_id, filas[0].proveedor_nombre,
        input.fechaPago || null, monto, metodo,
        input.referencia?.trim() || null, input.observaciones?.trim() || null,
        cajaMovimientoId, input.usuarioId || null, input.usuarioNombre?.trim() || null,
      ]
    );

    const pagado = pagadoAntes + monto;
    const saldo = Math.max(0, total - pagado);
    const estado = saldo <= 0 ? "pagada" : "parcial";

    // estado_pago queda como reflejo del saldo derivado.
    await client.query(
      `UPDATE ${tC}
          SET estado_pago = $1,
              pagada_at = CASE WHEN $1 = 'pagada' THEN COALESCE(pagada_at, now()) ELSE NULL END,
              pago_caja_movimiento_id = COALESCE($2::uuid, pago_caja_movimiento_id)
        WHERE empresa_id = $3::uuid AND numero_control = $4 AND anulada_at IS NULL`,
      [estado, cajaMovimientoId, input.empresaId, input.numeroControl]
    );

    await client.query("COMMIT");
    return {
      pago_id: String((insQ.rows[0] as { id: string }).id),
      pagado, saldo, estado_pago: estado,
    };
  } catch (e) {
    try { await client.query("ROLLBACK"); } catch { /* conexion ya rota */ }
    throw e;
  } finally {
    client.release();
  }
}

export type PagoReporte = {
  id: string;
  fecha_pago: string;
  numero_control: string;
  proveedor_nombre: string | null;
  fecha_compra: string | null;
  total_compra: number;
  monto: number;
  metodo_pago: string;
  referencia: string | null;
  salio_de_caja: boolean;
  usuario_nombre: string | null;
  /** true si el pago es de un mes posterior al de la compra. */
  de_mes_anterior: boolean;
  /** Saldo que le quedaba a la compra DESPUES de este pago. */
  saldo_restante: number;
};

export type ReportePagosProveedores = {
  periodo: { desde: string; hasta: string };
  total_pagado: number;
  cantidad_pagos: number;
  cantidad_facturas: number;
  pagado_de_meses_anteriores: number;
  por_proveedor: Array<{ proveedor_nombre: string; pagos: number; total: number }>;
  por_metodo: Array<{ metodo_pago: string; pagos: number; total: number }>;
  pagos: PagoReporte[];
};

/**
 * Pagos a proveedores de un periodo, agrupados por FECHA DE PAGO.
 *
 * Agrupar por fecha de pago y no por fecha de compra es lo correcto para esta
 * pregunta: una factura de agosto pagada en septiembre es plata que salio en
 * septiembre. Esos casos se marcan con `de_mes_anterior`.
 */
export async function getReportePagosProveedores(
  schema: string,
  empresaId: string,
  desde: string,
  hasta: string
): Promise<ReportePagosProveedores> {
  const tP = quoteSchemaTable(schema, "pagos_proveedores");
  const tC = quoteSchemaTable(schema, "compras");
  const hastaTs = `${hasta}T23:59:59.999Z`;

  const c = await pool().connect();
  try {
    const r = await c.query(
      `WITH compra AS (
         SELECT numero_control,
                MIN(fecha) AS fecha_compra,
                SUM(total)::float8 AS total_compra
           FROM ${tC}
          WHERE empresa_id = $1::uuid AND anulada_at IS NULL
          GROUP BY numero_control
       )
       SELECT p.id::text,
              -- A texto ISO en SQL: el driver devuelve Date y String(Date) da
              -- "Wed Oct 07 2026...", sobre el que slice() corta cualquier cosa.
              -- Ademas to_char usa la zona de la sesion, no UTC, asi que el dia
              -- no se corre para pagos de la noche.
              to_char(p.fecha_pago, 'YYYY-MM-DD') AS fecha_pago,
              p.numero_control,
              p.proveedor_nombre,
              to_char(c.fecha_compra, 'YYYY-MM-DD') AS fecha_compra,
              COALESCE(c.total_compra, 0)::float8 AS total_compra,
              p.monto::float8 AS monto,
              p.metodo_pago,
              p.referencia,
              (p.caja_movimiento_id IS NOT NULL) AS salio_de_caja,
              p.usuario_nombre,
              -- Lo pagado a esa compra hasta este pago inclusive, para mostrar
              -- cuanto le quedaba despues.
              COALESCE((
                SELECT SUM(q.monto) FROM ${tP} q
                 WHERE q.empresa_id = p.empresa_id
                   AND q.numero_control = p.numero_control
                   AND q.anulado_at IS NULL
                   AND (q.fecha_pago < p.fecha_pago
                        OR (q.fecha_pago = p.fecha_pago AND q.id <= p.id))
              ), 0)::float8 AS acumulado
         FROM ${tP} p
         LEFT JOIN compra c ON c.numero_control = p.numero_control
        WHERE p.empresa_id = $1::uuid
          AND p.anulado_at IS NULL
          AND p.fecha_pago >= $2::timestamptz
          AND p.fecha_pago <= $3::timestamptz
        ORDER BY p.fecha_pago DESC`,
      [empresaId, desde, hastaTs]
    );

    const pagos: PagoReporte[] = (r.rows as unknown as Array<Record<string, unknown>>).map((x) => {
      const monto = Math.round(Number(x.monto) || 0);
      const totalCompra = Math.round(Number(x.total_compra) || 0);
      const acumulado = Math.round(Number(x.acumulado) || 0);
      const fechaPago = String(x.fecha_pago);
      const fechaCompra = x.fecha_compra ? String(x.fecha_compra) : null;
      return {
        id: String(x.id),
        fecha_pago: fechaPago,
        numero_control: String(x.numero_control),
        proveedor_nombre: (x.proveedor_nombre as string) ?? null,
        fecha_compra: fechaCompra,
        total_compra: totalCompra,
        monto,
        metodo_pago: String(x.metodo_pago ?? "efectivo"),
        referencia: (x.referencia as string) ?? null,
        salio_de_caja: x.salio_de_caja === true,
        usuario_nombre: (x.usuario_nombre as string) ?? null,
        // Comparacion por año-mes sobre 'YYYY-MM-DD': la clienta pregunta
        // justamente por esto (factura de agosto pagada en septiembre).
        de_mes_anterior:
          fechaCompra != null &&
          /^\d{4}-\d{2}/.test(fechaCompra) &&
          /^\d{4}-\d{2}/.test(fechaPago) &&
          fechaCompra.slice(0, 7) < fechaPago.slice(0, 7),
        saldo_restante: Math.max(0, totalCompra - acumulado),
      };
    });

    const agrupar = <K extends string>(clave: (p: PagoReporte) => K) => {
      const m = new Map<K, { pagos: number; total: number }>();
      for (const p of pagos) {
        const k = clave(p);
        const a = m.get(k) ?? { pagos: 0, total: 0 };
        a.pagos += 1;
        a.total += p.monto;
        m.set(k, a);
      }
      return [...m.entries()].sort((a, b) => b[1].total - a[1].total);
    };

    return {
      periodo: { desde, hasta },
      total_pagado: pagos.reduce((s, p) => s + p.monto, 0),
      cantidad_pagos: pagos.length,
      cantidad_facturas: new Set(pagos.map((p) => p.numero_control)).size,
      pagado_de_meses_anteriores: pagos.filter((p) => p.de_mes_anterior).reduce((s, p) => s + p.monto, 0),
      por_proveedor: agrupar((p) => (p.proveedor_nombre ?? "Sin proveedor")).map(([proveedor_nombre, v]) => ({
        proveedor_nombre, ...v,
      })),
      por_metodo: agrupar((p) => p.metodo_pago).map(([metodo_pago, v]) => ({ metodo_pago, ...v })),
      pagos,
    };
  } finally {
    c.release();
  }
}
