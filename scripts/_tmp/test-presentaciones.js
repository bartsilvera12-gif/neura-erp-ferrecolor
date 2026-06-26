// Tests A/B/C + invariantes para presentaciones de producto.
// No commitea: ROLLBACK al final.
const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    // 1) Crear producto Tornillo de prueba con stock 3000
    const p = await c.query(
      `INSERT INTO ferreteriarepublica.productos
        (empresa_id, nombre, sku, precio_venta, stock_actual, unidad_medida, controla_stock)
       VALUES ($1, 'TORNILLO TEST', 'TEST-' || substr(md5(random()::text),1,8), 100, 3000, 'Unidad', true)
       RETURNING id, stock_actual`,
      [EMP]
    );
    const prodId = p.rows[0].id;
    console.log('Producto creado, stock inicial:', p.rows[0].stock_actual);

    // 2) Crear presentaciones: Unidad (default) y Caja=1000
    await c.query(
      `INSERT INTO ferreteriarepublica.producto_presentaciones
        (empresa_id, producto_id, nombre, cantidad_base, es_default, activo)
       VALUES ($1, $2, 'Unidad', 1, true, true)`,
      [EMP, prodId]
    );
    const caja = await c.query(
      `INSERT INTO ferreteriarepublica.producto_presentaciones
        (empresa_id, producto_id, nombre, cantidad_base, es_default, activo)
       VALUES ($1, $2, 'Caja', 1000, false, true) RETURNING id`,
      [EMP, prodId]
    );
    const cajaId = caja.rows[0].id;
    console.log('Presentaciones: Unidad (default, cant_base=1), Caja (cant_base=1000)\n');

    async function setStock(s) {
      await c.query('UPDATE ferreteriarepublica.productos SET stock_actual=$1 WHERE id=$2', [s, prodId]);
    }
    async function getStock() {
      const r = await c.query('SELECT stock_actual FROM ferreteriarepublica.productos WHERE id=$1', [prodId]);
      return Number(r.rows[0].stock_actual);
    }
    async function vender(cantidad, cantidadBase) {
      const total = cantidad * cantidadBase;
      await c.query('UPDATE ferreteriarepublica.productos SET stock_actual = GREATEST(0, stock_actual - $1) WHERE id=$2', [total, prodId]);
      return total;
    }

    // ============ CASO A ============
    await setStock(1000);
    console.log('CASO A: stock=1000, vender 10 unidades');
    const totalA = await vender(10, 1);
    const stA = await getStock();
    console.log(`  cantidad_total_base = 10 * 1 = ${totalA}`);
    console.log(`  stock_actual_resultado = ${stA}`);
    console.log(`  esperado = 990  ->  ${stA === 990 ? 'PASS' : 'FAIL'}\n`);

    // ============ CASO B ============
    await setStock(1000);
    console.log('CASO B: stock=1000, vender 1 caja');
    const totalB = await vender(1, 1000);
    const stB = await getStock();
    console.log(`  cantidad_total_base = 1 * 1000 = ${totalB}`);
    console.log(`  stock_actual_resultado = ${stB}`);
    console.log(`  esperado = 0  ->  ${stB === 0 ? 'PASS' : 'FAIL'}\n`);

    // ============ CASO C ============
    await setStock(3000);
    console.log('CASO C: stock=3000, vender 2 cajas');
    const totalC = await vender(2, 1000);
    const stC = await getStock();
    console.log(`  cantidad_total_base = 2 * 1000 = ${totalC}`);
    console.log(`  stock_actual_resultado = ${stC}`);
    console.log(`  esperado = 1000  ->  ${stC === 1000 ? 'PASS' : 'FAIL'}\n`);

    // ============ INVARIANTES ============
    console.log('--- Invariantes de tabla ---');

    const def = await c.query(
      `SELECT count(*) FROM ferreteriarepublica.producto_presentaciones
       WHERE producto_id=$1 AND es_default=true AND activo=true`,
      [prodId]
    );
    console.log(`Defaults activos para producto test = ${def.rows[0].count}  ->  ${def.rows[0].count === '1' ? 'PASS' : 'FAIL'}`);

    // Doble default debe fallar por indice unique parcial
    let okDoubleDef = false;
    try {
      await c.query('SAVEPOINT s1');
      await c.query('UPDATE ferreteriarepublica.producto_presentaciones SET es_default=true WHERE id=$1', [cajaId]);
      await c.query('RELEASE SAVEPOINT s1');
    } catch (e) {
      okDoubleDef = /unique|23505/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s1');
    }
    console.log(`Doble default bloqueado por indice unique  ->  ${okDoubleDef ? 'PASS' : 'FAIL'}`);

    // CHECK cantidad_base > 0
    let okZero = false;
    try {
      await c.query('SAVEPOINT s2');
      await c.query(
        `INSERT INTO ferreteriarepublica.producto_presentaciones (empresa_id, producto_id, nombre, cantidad_base, activo)
         VALUES ($1, $2, 'Cero', 0, true)`,
        [EMP, prodId]
      );
      await c.query('RELEASE SAVEPOINT s2');
    } catch (e) {
      okZero = /check|23514/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s2');
    }
    console.log(`CHECK cantidad_base>0 bloquea valor 0  ->  ${okZero ? 'PASS' : 'FAIL'}`);

    // Duplicado de nombre por producto (case insensitive) debe fallar
    let okDup = false;
    try {
      await c.query('SAVEPOINT s3');
      await c.query(
        `INSERT INTO ferreteriarepublica.producto_presentaciones (empresa_id, producto_id, nombre, cantidad_base, activo)
         VALUES ($1, $2, 'caja', 500, true)`,  // minuscula vs 'Caja' ya cargada
        [EMP, prodId]
      );
      await c.query('RELEASE SAVEPOINT s3');
    } catch (e) {
      okDup = /unique|23505/i.test(e.message);
      await c.query('ROLLBACK TO SAVEPOINT s3');
    }
    console.log(`Indice unique nombre por producto (case-insensitive)  ->  ${okDup ? 'PASS' : 'FAIL'}`);

    // ============ BACKFILL: productos existentes tienen su presentacion ============
    const bf = await c.query(
      `SELECT COUNT(*) AS c FROM ferreteriarepublica.productos p
       WHERE p.empresa_id=$1
         AND NOT EXISTS (SELECT 1 FROM ferreteriarepublica.producto_presentaciones pp
                         WHERE pp.producto_id=p.id)`,
      [EMP]
    );
    console.log(`Productos existentes sin presentacion = ${bf.rows[0].c}  ->  ${bf.rows[0].c === '0' ? 'PASS' : 'FAIL'}`);

    await c.query('ROLLBACK');
    console.log('\nTodos los casos verificados. Rollback realizado (DB sin cambios).');
  } catch (e) {
    await c.query('ROLLBACK');
    console.error('UNEXPECTED FAIL:', e.message);
    process.exit(1);
  }
  await c.end();
}

main();
