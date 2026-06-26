// Test E2E del modulo Pedidos: crear, editar, transiciones de estado,
// facturar, doble facturacion bloqueada, cancelacion.
// ROLLBACK al final.
const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    // 1) Crear pedido con numero auto
    const ped = await c.query(
      `INSERT INTO ferreteriarepublica.pedidos_caja
       (empresa_id, numero, titulo, items, total_estimado, estado)
       VALUES ($1, 'PED-TEST01', 'PED-TEST01 - Test', '[{"producto_id":"x","producto_nombre":"Tornillo","cantidad":1,"precio_venta":100000}]'::jsonb, 100000, 'pendiente')
       RETURNING id, numero, estado`,
      [EMP]
    );
    const pedId = ped.rows[0].id;
    console.log('1. Pedido creado:', ped.rows[0]);

    // 2) Verificar que estado 'en_caja' es valido por CHECK
    const tomar = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='en_caja', abierto_por_email='cajero@test', abierto_at=now()
       WHERE id=$1 AND estado='pendiente'
       RETURNING estado, abierto_por_email`,
      [pedId]
    );
    console.log('2. Tomado por caja:', tomar.rows[0]);

    // 3) Liberar (en_caja -> pendiente)
    const liberar = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='pendiente', abierto_por_email=null, abierto_at=null
       WHERE id=$1 AND estado='en_caja'
       RETURNING estado`,
      [pedId]
    );
    console.log('3. Liberado:', liberar.rows[0]);

    // 4) Re-tomar y facturar (en_caja -> facturado)
    await c.query(`UPDATE ferreteriarepublica.pedidos_caja SET estado='en_caja' WHERE id=$1`, [pedId]);
    const fact = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='facturado', venta_numero='VTA-TEST01', facturado_at=now()
       WHERE id=$1 AND estado IN ('pendiente','en_caja')
       RETURNING estado, venta_numero`,
      [pedId]
    );
    console.log('4. Facturado:', fact.rows[0]);

    // 5) Doble facturacion bloqueada (no debe transicionar desde 'facturado')
    const doble = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='facturado', venta_numero='VTA-TEST02'
       WHERE id=$1 AND estado IN ('pendiente','en_caja')
       RETURNING id`,
      [pedId]
    );
    console.log('5. Re-facturacion bloqueada (rows updated):', doble.rowCount, '(esperado 0)');

    // 6) Crear otro pedido y cancelarlo
    const ped2 = await c.query(
      `INSERT INTO ferreteriarepublica.pedidos_caja
       (empresa_id, numero, titulo, items, total_estimado, estado)
       VALUES ($1, 'PED-TEST02', 'PED-TEST02', '[]'::jsonb, 0, 'pendiente')
       RETURNING id`,
      [EMP]
    );
    const ped2Id = ped2.rows[0].id;
    const canc = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='cancelado', cancelado_at=now()
       WHERE id=$1 AND estado IN ('pendiente','en_caja')
       RETURNING estado`,
      [ped2Id]
    );
    console.log('6. Cancelado:', canc.rows[0]);

    // 7) Pedido cancelado no se puede facturar
    const intentoFact = await c.query(
      `UPDATE ferreteriarepublica.pedidos_caja
       SET estado='facturado'
       WHERE id=$1 AND estado IN ('pendiente','en_caja')
       RETURNING id`,
      [ped2Id]
    );
    console.log('7. Facturar cancelado bloqueado (rows updated):', intentoFact.rowCount, '(esperado 0)');

    // 8) Numero duplicado falla
    let dupOk = false;
    try {
      await c.query('SAVEPOINT s1');
      await c.query(
        `INSERT INTO ferreteriarepublica.pedidos_caja (empresa_id, numero, titulo, items, total_estimado, estado)
         VALUES ($1, 'PED-TEST01', 'dup', '[]'::jsonb, 0, 'pendiente')`,
        [EMP]
      );
      await c.query('RELEASE SAVEPOINT s1');
    } catch (e) {
      dupOk = /unique|23505/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s1');
    }
    console.log('8. Numero duplicado bloqueado por unique:', dupOk ? 'PASS' : 'FAIL');

    // 9) Estado invalido falla por CHECK
    let badStateOk = false;
    try {
      await c.query('SAVEPOINT s2');
      await c.query(
        `INSERT INTO ferreteriarepublica.pedidos_caja (empresa_id, numero, titulo, items, total_estimado, estado)
         VALUES ($1, 'PED-TEST03', 'bad', '[]'::jsonb, 0, 'pagado')`,
        [EMP]
      );
      await c.query('RELEASE SAVEPOINT s2');
    } catch (e) {
      badStateOk = /check|23514/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s2');
    }
    console.log('9. CHECK bloquea estado invalido:', badStateOk ? 'PASS' : 'FAIL');

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
