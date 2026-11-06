/**
 * Liquidación financiera de una devolución de venta.
 *
 * Función PURA (sin BD, sin efectos) que decide, a partir de:
 *   - cuánto vale lo devuelto (D),
 *   - cuánto vale lo entregado en un cambio (E),
 *   - cuánto sigue debiendo la venta (saldo pendiente S),
 *   - la resolución (reembolso / cambio) y el método,
 * cómo se reparte el movimiento entre CAJA (dinero real) y DEUDA (cuenta por cobrar).
 *
 * Reglas de negocio (ver reporte Ferrecolor):
 *  - Nunca se reembolsa más de lo que el cliente realmente pagó.
 *  - La parte NO pagada de lo devuelto solo baja la deuda; no genera egreso de caja.
 *  - En un cambio, la mercadería devuelta compensa la nueva: solo se liquida la
 *    DIFERENCIA, que puede cobrarse al momento o sumarse a la deuda (método "credito").
 *
 * Esta función es la única fuente de verdad; el motor PG y el Wizard la usan igual.
 */

export type ResolucionDevolucion = "reembolso" | "cambio";
export type MetodoReembolso = "efectivo" | "tarjeta" | "transferencia" | "credito";

function r2(n: number): number {
  return Math.round((n + Number.EPSILON) * 100) / 100;
}

export interface LiquidacionInput {
  /** Valor de la mercadería devuelta (>= 0). */
  totalDevuelto: number;
  /** Valor de la mercadería entregada en un cambio (>= 0; 0 si es reembolso). */
  totalEntregado: number;
  /** Saldo pendiente de la venta en cuentas_por_cobrar (>= 0; 0 si contado/pagada/sin CxC). */
  saldoPendiente: number;
  resolucion: ResolucionDevolucion;
  metodo: MetodoReembolso;
  /** La venta original fue a crédito con cuenta del cliente (existe CxC). */
  esCredito: boolean;
}

export interface Liquidacion {
  /** E - D. > 0: el cliente paga; < 0: a favor del cliente; 0: sin movimiento. */
  diferencia: number;
  /** Cuánto BAJA el saldo de la cuenta por cobrar (>= 0). */
  reduccionDeuda: number;
  /** Cuánto SUBE el saldo de la cuenta por cobrar (>= 0; solo cambio a crédito). */
  aumentoDeuda: number;
  /** Movimiento de caja a registrar, o null si no hay dinero físico/medio. */
  caja: { tipo: "ingreso" | "egreso"; monto: number } | null;
  /** La diferencia se resolvió ajustando deuda en vez de caja. */
  usaCredito: boolean;
}

/**
 * Calcula el reparto caja/deuda de una devolución. No redondea montos de entrada
 * fuera de 2 decimales; asume importes en guaraníes/centavos ya consistentes.
 */
export function computeLiquidacion(input: LiquidacionInput): Liquidacion {
  const D = Math.max(0, r2(input.totalDevuelto));
  const E = input.resolucion === "cambio" ? Math.max(0, r2(input.totalEntregado)) : 0;
  const S = Math.max(0, r2(input.saldoPendiente));

  const diferencia = r2(E - D);
  // Lo ya pagado de la mercadería que se devuelve (el resto estaba a deuda).
  const pagadoDeDevueltos = Math.max(0, r2(D - S));
  // "credito" solo es válido si la venta tiene cuenta por cobrar.
  const metodoCredito = input.metodo === "credito" && input.esCredito;

  let reduccionDeuda = 0;
  let aumentoDeuda = 0;
  let caja: { tipo: "ingreso" | "egreso"; monto: number } | null = null;

  if (diferencia > 0) {
    // El cliente debe pagar la diferencia (producto nuevo más caro).
    if (metodoCredito) {
      aumentoDeuda = diferencia;
    } else {
      caja = { tipo: "ingreso", monto: diferencia };
    }
  } else if (diferencia < 0) {
    // A favor del cliente (reembolso puro, o cambio por algo más barato).
    const falta = r2(-diferencia);
    if (metodoCredito) {
      // No se devuelve dinero: se descuenta de la deuda (hasta el saldo).
      reduccionDeuda = Math.min(falta, S);
    } else {
      // Solo se reembolsa en caja lo que el cliente realmente pagó.
      const reembolsable = Math.min(falta, pagadoDeDevueltos);
      // El resto (parte impaga) únicamente baja la deuda, nunca sale de caja.
      reduccionDeuda = Math.min(r2(falta - reembolsable), S);
      if (reembolsable > 0) {
        caja = { tipo: "egreso", monto: r2(reembolsable) };
      }
    }
  }
  // diferencia === 0 -> sin movimiento de caja ni deuda.

  return {
    diferencia,
    reduccionDeuda: r2(reduccionDeuda),
    aumentoDeuda: r2(aumentoDeuda),
    caja: caja ? { tipo: caja.tipo, monto: r2(caja.monto) } : null,
    usaCredito: metodoCredito && (aumentoDeuda > 0 || (diferencia < 0 && reduccionDeuda > 0)),
  };
}
