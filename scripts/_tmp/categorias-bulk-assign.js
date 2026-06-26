const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    const nuevas = [
      { nombre: 'Construccion', codigo: 'CONS', desc: 'Materiales y herramientas de obra: picos, cucharas, plomadas, clavos.', img: 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Tornilleria y fijaciones', codigo: 'TORN', desc: 'Pernos, tuercas, arandelas, remaches, grampas, tarugos.', img: 'https://images.unsplash.com/photo-1611288875785-f6cb39fef25e?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Cerrajeria y herrajes', codigo: 'CERR', desc: 'Candados, cerraduras, bisagras, manijas y herrajes.', img: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Soldadura', codigo: 'SOLD', desc: 'Soldadores, electrodos, hilos de soldar y accesorios.', img: 'https://images.unsplash.com/photo-1581244277943-fe4a9c777189?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Seguridad y EPP', codigo: 'EPP', desc: 'Guantes, zapatones, lentes, cascos, mascaras.', img: 'https://images.unsplash.com/photo-1581094271901-8022df4466f9?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Limpieza', codigo: 'LIMP', desc: 'Escobas, cepillos, baldes, trapos y articulos de limpieza.', img: 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=1200&q=85' },
      { nombre: 'Adhesivos y selladores', codigo: 'ADHE', desc: 'Siliconas, cintas adhesivas, pegamentos, masillas.', img: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?auto=format&fit=crop&w=1200&q=85' }
    ];

    const map = {};
    for (const n of nuevas) {
      const r = await c.query(
        `INSERT INTO ferreteriarepublica.categorias_productos (id, empresa_id, nombre, codigo, descripcion, imagen_url, activo)
         VALUES (gen_random_uuid(), $1, $2, $3, $4, $5, true)
         ON CONFLICT DO NOTHING
         RETURNING id, nombre`,
        [EMP, n.nombre, n.codigo, n.desc, n.img]
      );
      if (r.rows.length) map[n.nombre] = r.rows[0].id;
    }
    console.log('Categorias creadas:', Object.keys(map));

    const ex = await c.query(`SELECT id, nombre FROM ferreteriarepublica.categorias_productos WHERE empresa_id=$1`, [EMP]);
    for (const row of ex.rows) map[row.nombre] = row.id;

    const reglas = [
      // CINTA dividida por uso (especifica primero)
      { cat: 'Electricidad',          match: ['CINTA AISLAD%','CINTA ELE%','CINTA AISL%'] },
      { cat: 'Adhesivos y selladores', match: ['CINTA DOBLE%','CINTA EMBALAR%','CINTA P/EMBALAR%','CINTA PEGAR%','CINTA P/PINTOR%','CINTA PAPEL%','CINTA TAPA%','CINTA SCOTCH%','CINTA TRANSP%','CINTA TEFLON%','CINTA PVC%','CINTA TELA%'] },
      { cat: 'Herramientas manuales', match: ['CINTA METRIC%','CINTA P/MEDIR%'] },
      { cat: 'Adhesivos y selladores', match: ['CINTA%'] },

      { cat: 'Construccion', match: ['PICO%','CUCHARA%','ESPATULA%','PIOLA%','CLAVO%','CADENA%','PLOMADA%','BALDE%','HORMIGON%','REGLA%','LIENZA%','MACHETE%','HACHA%','MAZA%','MAZO%','CARRETILLA%','CINCEL%','PALA %','PALA DE%'] },

      { cat: 'Tornilleria y fijaciones', match: ['PERNO%','TUERCA%','REMACHE%','GRAMPA%','ABRAZADERA%','BUJE%','PASADOR%','ARANDELA%','TARUGO%','ANCLAJE%','VARILLA ROSC%','RONDANA%','TIRAFONDO%','TORNI%'] },

      { cat: 'Cerrajeria y herrajes', match: ['CANDADO%','CERRADURA%','BISAGRA%','MANIJA%','PESTILLO%','CERROJO%','PICAPORTE%','POMO%','LLAVIN%','PORTACANDA%'] },

      { cat: 'Soldadura', match: ['SOLDADOR%','ELECTRODO%','HILO P/SOLD%','HILO SOLD%','CARBON SOLD%','CARBON P/SOLD%','SOLDADURA%','MIG%'] },

      { cat: 'Seguridad y EPP', match: ['GUANTE%','ZAPATON%','ZAPATO DE%','LENTE%','CASCO%','MASCARA%','MASCARILLA%','BOTA %','BOTA DE%','RESPIRADOR%','PROTECTOR AURIC%','PROTECTOR FACIAL%','ARNES%','CHALECO REFLEC%','TAPABOCA%','FAJA LUMB%'] },

      { cat: 'Limpieza', match: ['ESCOBA%','CEPILLO BARR%','CEPILLO P/PISO%','CEPILLO P/INODO%','BOLSA BASURA%','BOLSA P/BASURA%','RECOGEDOR%','TRAPO%','TRAPEADOR%','LAVANDINA%','DETERGENTE%','LUSTRA%','DESENGRAS%','LIMPIA%','PALA P/BASURA%','MOPA%','BAYETA%','FRANELA%'] },

      { cat: 'Adhesivos y selladores', match: ['SILICONA%','PEGAMENTO%','COLA %','COLA DE%','MASILLA%','POXIPOL%','POXILINA%','SELLADOR%','CEMENTO DE CONTACTO%','ADHESIVO%'] },

      { cat: 'Electricidad', match: ['ADAPTADOR ELEC%','ADAPTADOR P/TOMA%','CAPACITOR%','PANEL SOLAR%','PANEL LED%','REFLECTOR%','LUZ %','LUZ LED%','LUZ P/%','TERMINAL %','CARGADOR P/%','CARGADOR USB%','VENTILADOR%','TOMACORRIENTE%','TOMA P/%','BREAKER%','EXTENSION ELEC%','ZAPATILLA%','PROLONGADOR%','MULTIPLE%','PILA%','BATERIA%','PORTALAMPARA%','SOCKET%','TIMBRE%','ALARMA%','SENSOR%'] },

      { cat: 'Plomeria y sanitarios', match: ['TAPON%','CONEXION%','TEE %','ACOPLE%','CINTILLO%','NIPLE%','CODO PVC%','CODO ROSC%','REDUCCION%','BUSHING%','MANGUERA P/JARD%','MANGUERA P/GAS%','MANGUERA P/AGUA%','TANQUE%','BOMBA P/AGUA%','BOMBA SUMERG%','FILTRO P/AGUA%','REJILLA%'] },

      { cat: 'Pinturas y acabados', match: ['AEROSOL%','BARNIZ%','IMPERMEABILIZANTE%','REVOQUE%','VINIL%','LIJA%','PINCEL%','BROCHA%','DILUYENTE%','THINNER%','FONDO%','ENDUIDO%','LACA%','TINTA%','ESMALTE%'] },

      { cat: 'Herramientas manuales', match: ['JUEGO DE%','KIT %','KIT P/%','COPA %','COPA P/%','MANGO%','HERRAMIENTA%','MULTIMETRO%','VOLTIMETRO%','PROBADOR%'] }
    ];

    let total = 0;
    for (const r of reglas) {
      if (!map[r.cat]) { console.log('SKIP', r.cat); continue; }
      const conds = r.match.map((_, i) => 'nombre ILIKE $' + (i + 3)).join(' OR ');
      const up = await c.query(
        `UPDATE ferreteriarepublica.productos SET categoria_principal_id=$1 WHERE empresa_id=$2 AND categoria_principal_id IS NULL AND ( ${conds} )`,
        [map[r.cat], EMP, ...r.match]
      );
      if (up.rowCount > 0) console.log(`  +${up.rowCount} -> ${r.cat}`);
      total += up.rowCount;
    }
    console.log('Total movidos:', total);

    const veri = await c.query(`
      SELECT cp.nombre, COUNT(p.id) AS cnt
      FROM ferreteriarepublica.categorias_productos cp
      LEFT JOIN ferreteriarepublica.productos p ON p.categoria_principal_id=cp.id AND p.empresa_id=cp.empresa_id
      WHERE cp.empresa_id=$1
      GROUP BY cp.nombre ORDER BY cnt DESC
    `, [EMP]);
    console.log('\nResumen final:');
    console.table(veri.rows);

    const sc = await c.query(`SELECT COUNT(*) FROM ferreteriarepublica.productos WHERE empresa_id=$1 AND categoria_principal_id IS NULL`, [EMP]);
    console.log('Sin categoria:', sc.rows[0].count);

    await c.query('COMMIT');
    console.log('OK');
  } catch (e) {
    await c.query('ROLLBACK');
    console.error('ROLLBACK', e.message);
    process.exit(1);
  }
  await c.end();
}
main();
