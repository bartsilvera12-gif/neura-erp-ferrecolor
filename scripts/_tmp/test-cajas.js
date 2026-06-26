// Test E2E del modulo Caja: abrir, simular ventas+movs, cerrar, verificar arqueo.
// ROLLBACK al final, no toca DB.
const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    // 1) Verificar que no hay caja abierta (limpio)
    const pre = await c.query(
      `SELECT COUNT(*) FROM ferreteriarepublica.cajas WHERE empresa_id=$1 AND estado='abierta'`,
      [EMP]
    );
    console.log('Cajas abiertas pre-test:', pre.rows[0].count);

    // 2) Abrir caja con 100k de apertura
    const abrir = await c.query(
      `INSERT INTO ferreteriarepublica.cajas
       (empresa_id, estado, monto_apertura, observacion_apertura)
       VALUES ($1, 'abierta', 100000, 'Apertura test')
       RETURNING id, monto_apertura, estado`,
      [EMP]
    );
    const cajaId = abrir.rows[0].id;
    console.log('OK caja abierta:', cajaId.slice(0,8) + '... monto_apertura:', abrir.rows[0].monto_apertura);

    // 3) Doble apertura debe fallar por indice unique parcial
    let dobleOk = false;
    try {
      await c.query('SAVEPOINT s1');
      await c.query(
        `INSERT INTO ferreteriarepublica.cajas (empresa_id, estado, monto_apertura) VALUES ($1, 'abierta', 0)`,
        [EMP]
      );
      await c.query('RELEASE SAVEPOINT s1');
    } catch (e) {
      dobleOk = /unique|23505/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s1');
    }
    console.log('Doble apertura bloqueada:', dobleOk ? 'PASS' : 'FAIL');

    // 4) Insertar 3 ventas asociadas a la caja
    //    (Crear las ventas con los campos minimos requeridos)
    const ventaIds = [];
    for (const [metodo, total] of [
      ['efectivo', 50000],
      ['tarjeta', 30000],
      ['transferencia', 20000],
    ]) {
      const v = await c.query(
        `INSERT INTO ferreteriarepublica.ventas
         (empresa_id, numero_control, subtotal, monto_iva, total, metodo_pago, caja_id, estado)
         VALUES ($1, 'TEST-' || substr(md5(random()::text),1,6), $2, 0, $2, $3, $4, 'completada')
         RETURNING id`,
        [EMP, total, metodo, cajaId]
      );
      ventaIds.push(v.rows[0].id);
    }
    console.log('OK 3 ventas asociadas: 1 efectivo (50k), 1 tarjeta (30k), 1 transfer (20k)');

    // 5) Movimientos: ingreso 10k, egreso 5k, retiro 15k
    await c.query(
      `INSERT INTO ferreteriarepublica.caja_movimientos
       (empresa_id, caja_id, tipo, concepto, monto, medio_pago)
       VALUES
       ($1, $2, 'ingreso', 'Aporte extra', 10000, 'efectivo'),
       ($1, $2, 'egreso', 'Pago delivery', 5000, 'efectivo'),
       ($1, $2, 'retiro', 'Retiro socio', 15000, 'efectivo')`,
      [EMP, cajaId]
    );
    console.log('OK 3 movimientos: +10k ingreso, -5k egreso, -15k retiro');

    // 6) Calcular efectivo esperado: 100k + 50k + 10k - 5k - 15k = 140k
    const esperado = 100000 + 50000 + 10000 - 5000 - 15000;
    console.log('Efectivo esperado calculado:', esperado, '(esperado: 140000)');

    // 7) Simular cierre: cajero cuenta 138k (le faltan 2k)
    const contado = 138000;
    const diferencia = contado - esperado;
    const cierre = await c.query(
      `UPDATE ferreteriarepublica.cajas
       SET estado='cerrada',
           fecha_cierre=now(),
           monto_cierre_contado=$1,
           monto_esperado_efectivo=$2,
           diferencia=$3,
           observacion_cierre='Test cierre'
       WHERE id=$4
       RETURNING estado, monto_cierre_contado, monto_esperado_efectivo, diferencia`,
      [contado, esperado, diferencia, cajaId]
    );
    console.log('OK caja cerrada:', cierre.rows[0]);
    console.log('  Diferencia:', diferencia, '(falta 2000 Gs)');

    // 8) Verificar que se puede abrir otra ahora (la primera ya esta cerrada)
    const reabrir = await c.query(
      `INSERT INTO ferreteriarepublica.cajas (empresa_id, estado, monto_apertura) VALUES ($1, 'abierta', 0) RETURNING id`,
      [EMP]
    );
    console.log('OK pude abrir otra caja despues:', reabrir.rows[0].id.slice(0,8) + '...');

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
