/**
 * QA unitario de la liquidación de devoluciones (función pura, sin BD).
 * Ejecutar:  npx tsx scripts/qa-devoluciones-liquidacion.ts
 * Sale con código 1 si algún caso falla. Cubre los escenarios del reporte Ferrecolor.
 */
import { computeLiquidacion, type LiquidacionInput } from "../src/lib/devoluciones/liquidacion";

let fallos = 0;
let ok = 0;

function check(nombre: string, input: LiquidacionInput, esperado: {
  diferencia: number; reduccionDeuda: number; aumentoDeuda: number;
  caja: { tipo: "ingreso" | "egreso"; monto: number } | null;
}) {
  const r = computeLiquidacion(input);
  const cajaIgual =
    (r.caja === null && esperado.caja === null) ||
    (r.caja !== null && esperado.caja !== null &&
      r.caja.tipo === esperado.caja.tipo && Math.abs(r.caja.monto - esperado.caja.monto) < 0.01);
  const pasa =
    Math.abs(r.diferencia - esperado.diferencia) < 0.01 &&
    Math.abs(r.reduccionDeuda - esperado.reduccionDeuda) < 0.01 &&
    Math.abs(r.aumentoDeuda - esperado.aumentoDeuda) < 0.01 &&
    cajaIgual;
  if (pasa) {
    ok++;
    console.log(`  ✓ ${nombre}`);
  } else {
    fallos++;
    console.log(`  ✗ ${nombre}`);
    console.log(`      esperado: ${JSON.stringify(esperado)}`);
    console.log(`      obtenido: ${JSON.stringify({ diferencia: r.diferencia, reduccionDeuda: r.reduccionDeuda, aumentoDeuda: r.aumentoDeuda, caja: r.caja })}`);
  }
}

console.log("QA liquidación de devoluciones\n");

// 1) Reembolso de venta a crédito SIN pagos: NO se reembolsa nada, solo baja la deuda.
check("Reembolso crédito sin pagar (D=63k, S=63k)", {
  totalDevuelto: 63000, totalEntregado: 0, saldoPendiente: 63000,
  resolucion: "reembolso", metodo: "efectivo", esCredito: true,
}, { diferencia: -63000, reduccionDeuda: 63000, aumentoDeuda: 0, caja: null });

// 2) Reembolso de venta a crédito con pago parcial: solo se reembolsa lo pagado.
check("Reembolso crédito pago parcial (D=63k, pagó 20k, S=43k)", {
  totalDevuelto: 63000, totalEntregado: 0, saldoPendiente: 43000,
  resolucion: "reembolso", metodo: "efectivo", esCredito: true,
}, { diferencia: -63000, reduccionDeuda: 43000, aumentoDeuda: 0, caja: { tipo: "egreso", monto: 20000 } });

// 3) Reembolso de venta de contado (todo pagado): se reembolsa todo.
check("Reembolso contado pagado (D=63k, S=0)", {
  totalDevuelto: 63000, totalEntregado: 0, saldoPendiente: 0,
  resolucion: "reembolso", metodo: "efectivo", esCredito: false,
}, { diferencia: -63000, reduccionDeuda: 0, aumentoDeuda: 0, caja: { tipo: "egreso", monto: 63000 } });

// 4) Cambio crédito sin pagar por producto MAYOR, cobro de la diferencia en efectivo.
check("Cambio crédito sin pagar, nuevo mayor, efectivo (D=63k, E=100k, S=63k)", {
  totalDevuelto: 63000, totalEntregado: 100000, saldoPendiente: 63000,
  resolucion: "cambio", metodo: "efectivo", esCredito: true,
}, { diferencia: 37000, reduccionDeuda: 0, aumentoDeuda: 0, caja: { tipo: "ingreso", monto: 37000 } });

// 5) Mismo cambio pero la diferencia va a la DEUDA (método crédito).
check("Cambio crédito sin pagar, nuevo mayor, a cuenta (D=63k, E=100k, S=63k)", {
  totalDevuelto: 63000, totalEntregado: 100000, saldoPendiente: 63000,
  resolucion: "cambio", metodo: "credito", esCredito: true,
}, { diferencia: 37000, reduccionDeuda: 0, aumentoDeuda: 37000, caja: null });

// 6) Cambio por producto MENOR en venta de contado pagada: se devuelve la diferencia.
check("Cambio contado pagado, nuevo menor (D=100k, E=63k, S=0)", {
  totalDevuelto: 100000, totalEntregado: 63000, saldoPendiente: 0,
  resolucion: "cambio", metodo: "efectivo", esCredito: false,
}, { diferencia: -37000, reduccionDeuda: 0, aumentoDeuda: 0, caja: { tipo: "egreso", monto: 37000 } });

// 7) Cambio por producto MENOR en crédito sin pagar: la diferencia solo baja la deuda.
check("Cambio crédito sin pagar, nuevo menor (D=100k, E=63k, S=100k)", {
  totalDevuelto: 100000, totalEntregado: 63000, saldoPendiente: 100000,
  resolucion: "cambio", metodo: "efectivo", esCredito: true,
}, { diferencia: -37000, reduccionDeuda: 37000, aumentoDeuda: 0, caja: null });

// 8) Cambio por producto de IGUAL valor: sin movimiento.
check("Cambio igual valor (D=50k, E=50k)", {
  totalDevuelto: 50000, totalEntregado: 50000, saldoPendiente: 50000,
  resolucion: "cambio", metodo: "efectivo", esCredito: true,
}, { diferencia: 0, reduccionDeuda: 0, aumentoDeuda: 0, caja: null });

// 9) Cambio menor con pago parcial: reembolsa lo pagado y el resto baja la deuda.
check("Cambio crédito pago parcial, nuevo menor (D=100k, E=63k, pagó 30k, S=70k)", {
  totalDevuelto: 100000, totalEntregado: 63000, saldoPendiente: 70000,
  resolucion: "cambio", metodo: "efectivo", esCredito: true,
}, { diferencia: -37000, reduccionDeuda: 7000, aumentoDeuda: 0, caja: { tipo: "egreso", monto: 30000 } });

console.log(`\nResultado: ${ok} OK, ${fallos} fallidos de ${ok + fallos}.`);
process.exit(fallos > 0 ? 1 : 0);
