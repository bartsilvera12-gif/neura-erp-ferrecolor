/**
 * Tipos del modulo Caja (turno de venta).
 *
 * Una "caja" es un turno: se abre con un monto inicial, mientras esta
 * abierta se le asocian ventas (ventas.caja_id) y movimientos manuales,
 * y se cierra contando el efectivo (arqueo).
 *
 * En esta instancia hay UNA sola caja por empresa (sin numero_caja). El
 * indice unique parcial en DB garantiza que solo haya una abierta a la vez.
 */

export type EstadoCaja = "abierta" | "cerrada";
export type TipoMovimientoCaja = "ingreso" | "egreso" | "retiro" | "ajuste";
export type MedioPagoCaja = "efectivo" | "tarjeta" | "transferencia" | "otro";

export interface Caja {
  id: string;
  estado: EstadoCaja;
  abierta_por: string | null;
  cerrada_por: string | null;
  fecha_apertura: string;
  fecha_cierre: string | null;
  monto_apertura: number;
  monto_cierre_contado: number | null;
  monto_esperado_efectivo: number | null;
  diferencia: number | null;
  observacion_apertura: string | null;
  observacion_cierre: string | null;
}

export interface CajaMovimiento {
  id: string;
  caja_id: string;
  tipo: TipoMovimientoCaja;
  concepto: string;
  monto: number;
  medio_pago: MedioPagoCaja;
  usuario_id: string | null;
  observacion: string | null;
  created_at: string;
}

/**
 * Totales calculados de una caja (server-side, verdad del arqueo).
 *   efectivo_esperado = monto_apertura
 *                     + ventas efectivo
 *                     + ingresos efectivo
 *                     - egresos efectivo
 *                     - retiros efectivo
 *                     + ajustes efectivo (signado).
 * Tarjeta y transferencia suman al total_vendido pero NO al efectivo esperado.
 */
export interface CajaResumen {
  caja: Caja;
  cantidad_ventas: number;
  total_vendido: number;
  total_efectivo: number;
  total_tarjeta: number;
  total_transferencia: number;
  ingresos_efectivo: number;
  egresos_efectivo: number;
  retiros_efectivo: number;
  ajustes_efectivo: number;
  efectivo_esperado: number;
  movimientos: CajaMovimiento[];
}
