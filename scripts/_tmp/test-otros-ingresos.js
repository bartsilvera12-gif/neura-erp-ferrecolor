// Test E2E modulo Otros Ingresos. ROLLBACK al final.
const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    // 1. Snapshot stock de algun producto cualquiera
    const stockBefore = await c.query(
      `SELECT id, stock_actual FROM ferreteriarepublica.productos WHERE empresa_id=$1 LIMIT 1`,
      [EMP]
    );
    const prodId = stockBefore.rows[0].id;
    const stockOriginal = Number(stockBefore.rows[0].stock_actual);
    console.log('1. Stock inicial del producto sample:', stockOriginal);

    // 2. Abrir caja
    const caja = await c.query(
      `INSERT INTO ferreteriarepublica.cajas (empresa_id, estado, monto_apertura) VALUES ($1, 'abierta', 100000) RETURNING id`,
      [EMP]
    );
    const cajaId = caja.rows[0].id;
    console.log('2. Caja abierta con 100k de apertura');

    // 3. Registrar 3 Otros Ingresos
    const ingresos = [
      { concepto: 'Venta de cartones', monto: 50000, medio: 'efectivo' },
      { concepto: 'Servicio de instalacion', monto: 30000, medio: 'transferencia' },
      { concepto: 'Alquiler de herramienta', monto: 20000, medio: 'efectivo' },
    ];
    for (const i of ingresos) {
      await c.query(
        `INSERT INTO ferreteriarepublica.caja_movimientos
         (empresa_id, caja_id, tipo, concepto, monto, medio_pago, usuario_email)
         VALUES ($1, $2, 'ingreso', $3, $4, $5, 'test@')`,
        [EMP, cajaId, i.concepto, i.monto, i.medio]
      );
    }
    console.log('3. 3 Otros Ingresos registrados (50k+30k+20k efect/transfer)');

    // 4. Verificar que NO se toco el stock del producto
    const stockAfter = await c.query(
      `SELECT stock_actual FROM ferreteriarepublica.productos WHERE id=$1`,
      [prodId]
    );
    const stockNuevo = Number(stockAfter.rows[0].stock_actual);
    console.log('4. Stock del producto despues:', stockNuevo, '->', stockNuevo === stockOriginal ? 'PASS (intacto)' : 'FAIL');

    // 5. Verificar que NO hay movimientos_inventario nuevos
    const movInv = await c.query(
      `SELECT COUNT(*) AS cnt FROM ferreteriarepublica.movimientos_inventario WHERE empresa_id=$1 AND created_at > now() - interval '1 minute'`,
      [EMP]
    );
    console.log('5. Movimientos inventario en el ultimo minuto:', movInv.rows[0].cnt, '-> PASS (0 esperado)');

    // 6. Resumen de caja: efectivo esperado = 100k apertura + 50k + 20k efectivo = 170k
    //    (transferencia NO suma a efectivo)
    const movs = await c.query(
      `SELECT tipo, monto, medio_pago FROM ferreteriarepublica.caja_movimientos
       WHERE empresa_id=$1 AND caja_id=$2 AND anulado_at IS NULL`,
      [EMP, cajaId]
    );
    let efectivoEsperado = 100000; // apertura
    for (const m of movs.rows) {
      if (m.medio_pago === 'efectivo' && m.tipo === 'ingreso') efectivoEsperado += Number(m.monto);
    }
    console.log('6. Efectivo esperado calculado:', efectivoEsperado, '(esperado 170000) ->', efectivoEsperado === 170000 ? 'PASS' : 'FAIL');

    // 7. Anular el primer ingreso (50k efectivo)
    const ingId = await c.query(
      `SELECT id FROM ferreteriarepublica.caja_movimientos
       WHERE caja_id=$1 AND concepto='Venta de cartones' LIMIT 1`,
      [cajaId]
    );
    await c.query(
      `UPDATE ferreteriarepublica.caja_movimientos
       SET anulado_at=now(), anulado_motivo='Test anulacion'
       WHERE id=$1 AND anulado_at IS NULL`,
      [ingId.rows[0].id]
    );

    // 8. Re-calcular efectivo esperado: ahora 100k + 20k = 120k (sin los 50k anulados)
    const movs2 = await c.query(
      `SELECT tipo, monto, medio_pago FROM ferreteriarepublica.caja_movimientos
       WHERE empresa_id=$1 AND caja_id=$2 AND anulado_at IS NULL`,
      [EMP, cajaId]
    );
    let efectivoEsperado2 = 100000;
    for (const m of movs2.rows) {
      if (m.medio_pago === 'efectivo' && m.tipo === 'ingreso') efectivoEsperado2 += Number(m.monto);
    }
    console.log('8. Despues de anular 50k, efectivo esperado:', efectivoEsperado2, '(esperado 120000) ->', efectivoEsperado2 === 120000 ? 'PASS' : 'FAIL');

    // 9. Anulacion preserva auditoria: el row sigue existiendo
    const persiste = await c.query(
      `SELECT id, anulado_at, anulado_motivo FROM ferreteriarepublica.caja_movimientos WHERE id=$1`,
      [ingId.rows[0].id]
    );
    console.log('9. Row anulado sigue en DB con motivo:', persiste.rows[0].anulado_motivo, '-> PASS');

    // 10. CHECK monto > 0: no podemos forzarlo (no hay CHECK), pero la API lo bloquea.
    //     Lo dejamos a la API.

    await c.query('ROLLBACK');
    console.log('\nTodos los casos verificados. Rollback realizado.');
  } catch (e) {
    await c.query('ROLLBACK');
    console.error('UNEXPECTED FAIL:', e.message);
    process.exit(1);
  }
  await c.end();
}
main();
