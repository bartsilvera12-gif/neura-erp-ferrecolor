/**
 * Agregados SQL server-side para el módulo Reportes (schema reservacaacupe).
 * Fase 1: Estado de cuenta + Proveedores. Solo lectura sobre
 * ventas / compras / gastos / proveedores. Mismo patrón de pool que compras-pg.
 *
 * `start`/`end` = límites timestamptz del mes (para ventas/compras, fecha tz).
 * `mesInicio` = "YYYY-MM-01" (para gastos.fecha que es DATE).
 *
 * NOTA — modelo de compras de Reserva (PLANO): una compra multiproducto son N
 * filas en `compras` que comparten `numero_control` (no hay tabla `compras_items`).
 * Por eso, para contar "compras" reales se agrupa/cuenta por `numero_control`,
 * mientras que los SUM(total) ya son correctos (suman los totales de línea).
 */
import { getChatPostgresPool, quoteSchemaTable } from "@/lib/supabase/chat-pg-pool";
import { assertAllowedChatDataSchema } from "@/lib/supabase/chat-data-schema";
import type {
  EstadoCuentaReporte,
  MovimientoEstadoCuenta,
  ProveedoresReporte,
  ProveedorReporteRow,
} from "@/lib/reportes/types";

function pool() {
  const p = getChatPostgresPool();
  if (!p) throw new Error("Pool no disponible.");
  return p;
}

export interface MesBounds {
  mes: string;
  start: string;
  end: string;
  mesInicio: string; // YYYY-MM-01
}

const num = (v: unknown): number => Number(v ?? 0) || 0;

// ── Estado de cuenta ─────────────────────────────────────────────────────────

export async function getEstadoCuenta(
  schemaRaw: string,
  empresaId: string,
  b: MesBounds
): Promise<EstadoCuentaReporte> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tVentas = quoteSchemaTable(schema, "ventas");
  const tCompras = quoteSchemaTable(schema, "compras");
  const tGastos = quoteSchemaTable(schema, "gastos");
  const p = pool();

  const ventasQ = p.query<{ total: number }>(
    `SELECT COALESCE(SUM(total),0)::float8 AS total FROM ${tVentas}
      WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz`,
    [empresaId, b.start, b.end]
  );
  const comprasQ = p.query<{ total: number }>(
    `SELECT COALESCE(SUM(total),0)::float8 AS total FROM ${tCompras}
      WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz`,
    [empresaId, b.start, b.end]
  );
  const gastosQ = p.query<{ total: number }>(
    `SELECT COALESCE(SUM(monto),0)::float8 AS total FROM ${tGastos}
      WHERE empresa_id=$1::uuid AND fecha>=$2::date AND fecha < ($2::date + interval '1 month')`,
    [empresaId, b.mesInicio]
  );
  const porCobrarQ = p.query<{ total: number }>(
    `SELECT COALESCE(SUM(total),0)::float8 AS total FROM ${tVentas}
      WHERE empresa_id=$1::uuid AND tipo_venta='CREDITO' AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz`,
    [empresaId, b.start, b.end]
  );
  const porPagarQ = p.query<{ total: number }>(
    `SELECT COALESCE(SUM(total),0)::float8 AS total FROM ${tCompras}
      WHERE empresa_id=$1::uuid AND tipo_pago='credito' AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz`,
    [empresaId, b.start, b.end]
  );
  // Compras agrupadas por numero_control (modelo plano): una fila por compra real.
  const movsQ = p.query<MovimientoEstadoCuenta>(
    `SELECT fecha, tipo, referencia, descripcion, entrada, salida FROM (
        SELECT fecha, 'Venta'::text AS tipo, numero_control AS referencia,
               'Venta a cliente'::text AS descripcion, total::float8 AS entrada, 0::float8 AS salida
          FROM ${tVentas}
         WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz
        UNION ALL
        SELECT MIN(fecha) AS fecha, 'Compra'::text, numero_control,
               MIN(proveedor_nombre), 0::float8, SUM(total)::float8
          FROM ${tCompras}
         WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz
         GROUP BY numero_control
        UNION ALL
        SELECT fecha::timestamptz, 'Gasto'::text, COALESCE(categoria,''),
               COALESCE(descripcion,''), 0::float8, monto::float8
          FROM ${tGastos}
         WHERE empresa_id=$1::uuid AND fecha>=$4::date AND fecha < ($4::date + interval '1 month')
      ) m ORDER BY fecha ASC`,
    [empresaId, b.start, b.end, b.mesInicio]
  );

  const [ventas, compras, gastos, porCobrar, porPagar, movs] = await Promise.all([
    ventasQ, comprasQ, gastosQ, porCobrarQ, porPagarQ, movsQ,
  ]);

  const ingresosVentas = num(ventas.rows[0]?.total);
  const comprasTotal = num(compras.rows[0]?.total);
  const gastosTotal = num(gastos.rows[0]?.total);

  return {
    mes: b.mes,
    ingresosVentas,
    compras: comprasTotal,
    gastos: gastosTotal,
    resultado: ingresosVentas - comprasTotal - gastosTotal,
    porCobrar: num(porCobrar.rows[0]?.total),
    porPagar: num(porPagar.rows[0]?.total),
    movimientos: movs.rows.map((m) => ({
      fecha: m.fecha,
      tipo: m.tipo,
      referencia: m.referencia,
      descripcion: m.descripcion,
      entrada: num(m.entrada),
      salida: num(m.salida),
    })),
  };
}

// ── Proveedores ──────────────────────────────────────────────────────────────

export async function getReporteProveedores(
  schemaRaw: string,
  empresaId: string,
  b: MesBounds
): Promise<ProveedoresReporte> {
  const schema = assertAllowedChatDataSchema(schemaRaw);
  const tProv = quoteSchemaTable(schema, "proveedores");
  const tC = quoteSchemaTable(schema, "compras");
  const p = pool();

  const totalProvQ = p.query<{ n: number }>(
    `SELECT count(*)::int AS n FROM ${tProv} WHERE empresa_id=$1::uuid`, [empresaId]);
  const mesQ = p.query<{ proveedores: number; total: number }>(
    `SELECT count(DISTINCT proveedor_id)::int AS proveedores, COALESCE(SUM(total),0)::float8 AS total
       FROM ${tC} WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz`,
    [empresaId, b.start, b.end]);
  // Última compra: total de la compra agrupada por numero_control (modelo plano).
  const ultimaQ = p.query<{ numero_control: string; proveedor_nombre: string; total: number; fecha: string }>(
    `SELECT numero_control, MIN(proveedor_nombre) AS proveedor_nombre,
            SUM(total)::float8 AS total, MAX(fecha) AS fecha
       FROM ${tC} WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz
      GROUP BY numero_control
      ORDER BY MAX(fecha) DESC LIMIT 1`, [empresaId, b.start, b.end]);
  // Proveedores con sus métricas del mes (LEFT JOIN para incluir los sin compras).
  // `cantidad` = compras reales (numero_control distintos), no líneas.
  const provListQ = p.query<ProveedorReporteRow>(
    `SELECT pr.id, pr.nombre, pr.ruc, pr.telefono,
            COALESCE(cc.cantidad,0)::int AS cantidad,
            COALESCE(cc.total,0)::float8 AS total,
            cc.ultima_compra
       FROM ${tProv} pr
       LEFT JOIN (
         SELECT proveedor_id,
                count(DISTINCT numero_control)::int AS cantidad,
                SUM(total)::float8 AS total,
                MAX(fecha) AS ultima_compra
           FROM ${tC} WHERE empresa_id=$1::uuid AND fecha>=$2::timestamptz AND fecha<=$3::timestamptz
          GROUP BY proveedor_id
       ) cc ON cc.proveedor_id = pr.id
      WHERE pr.empresa_id=$1::uuid
      ORDER BY COALESCE(cc.total,0) DESC, pr.nombre ASC`,
    [empresaId, b.start, b.end]);

  const [totalProv, mes, ultima, provList] = await Promise.all([totalProvQ, mesQ, ultimaQ, provListQ]);

  const conCompras = num(mes.rows[0]?.proveedores);
  const totalComprado = num(mes.rows[0]?.total);

  return {
    mes: b.mes,
    totalProveedores: num(totalProv.rows[0]?.n),
    conCompras,
    totalComprado,
    compraPromedio: conCompras > 0 ? totalComprado / conCompras : 0,
    ultimaCompra: ultima.rows[0] ? { ...ultima.rows[0], total: num(ultima.rows[0].total) } : null,
    proveedores: provList.rows.map((r) => ({ ...r, cantidad: num(r.cantidad), total: num(r.total) })),
  };
}
