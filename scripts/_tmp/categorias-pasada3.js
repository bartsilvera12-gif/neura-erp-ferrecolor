const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    const ex = await c.query(`SELECT id, nombre FROM ferreteriarepublica.categorias_productos WHERE empresa_id=$1`, [EMP]);
    const map = {};
    for (const row of ex.rows) map[row.nombre] = row.id;

    const reglas = [
      // Marcas conocidas → pinturas
      { cat: 'Pinturas y acabados', match: ['SOLCOR%','DURAFRENT%','AMANECER%','ALBALATEX%','TEKNO COLOR%','SHERWIN%','RENNER%','SUVINIL%','LATEX%'] },

      // CAJA por uso
      { cat: 'Electricidad',          match: ['CAJA OCTOG%','CAJA CONEX%','CAJA ELEC%','CAJA P/LLAVE TM%','CAJA P/INTERR%','CAJA P/TABLER%','CAJA P/TIMBR%'] },
      { cat: 'Herramientas manuales', match: ['CAJA P/HERR%','CAJA DE HERR%','CAJA P/LLAVE %','CAJA DE LLAVE%','JUEGO DE CAJA%','CAJA RECT%'] },
      { cat: 'Tornilleria y fijaciones', match: ['CAJA P/TORN%','CAJA DE TORN%','CAJA %'] },

      // RUEDA → Cerrajeria (ruedas de mueble, carro, carretilla)
      { cat: 'Cerrajeria y herrajes', match: ['RUEDA%'] },

      // SOPORTE → Cerrajeria
      { cat: 'Cerrajeria y herrajes', match: ['SOPORTE%','ESQUINER%','PERFIL %','PERFILER%'] },

      // ANGULO → Construccion
      { cat: 'Construccion', match: ['ANGULO%','CORDON %','CINTA P/OBRA%','ALAMBRE %','PUNTA %'] },

      // TAPA por uso
      { cat: 'Electricidad', match: ['TAPA P/CAJA%','TAPA P/LLAVE%','TAPA P/TOMA%','TAPA P/INTERR%'] },
      { cat: 'Plomeria y sanitarios', match: ['TAPA %'] },

      // JUEGO genérico → Herramientas
      { cat: 'Herramientas manuales', match: ['JUEGO %','KIT %','BITS%','HOJA %','MANGO %','MANDRIL%','PRENSA%','LIMA %','LAPIZ %','PLACA %','MINI %','SIERRA %','TIJERA %','PINZA %','DESTORNILLADOR%','ALICATE%','MARTILLO %','DESBOZADOR%','REGATON %','MORDAZA%','METRO %','REGLA %','TRANSPORTADOR %'] },

      // BOLSA → Limpieza
      { cat: 'Limpieza', match: ['BOLSA %'] },

      // HILO → Soldadura (los de coser ya filtrados, asumimos resto soldadura)
      { cat: 'Soldadura', match: ['HILO %'] },

      // CONTROL → Electricidad
      { cat: 'Electricidad', match: ['CONTROL %','CAMARA %','MOTOR%','PROBADOR%','TESTER%','ANALIZ%','VARIADOR%','INVERSOR%','RELE %','RELEVADOR%','BORN%','PLACA ELEC%'] },

      // HOJA por uso
      { cat: 'Pinturas y acabados', match: ['HOJA P/LIJA%','HOJA P/PINT%'] },
      { cat: 'Herramientas manuales', match: ['HOJA P/SIERRA%','HOJA P/CUTTER%','HOJA P/SERRUCHO%','HOJA P/ARCO%'] },

      // Misc Construccion
      { cat: 'Construccion', match: ['CARBON %','CARRETON%','BARRA %','PIEDRA P/AFILAR%','HACHA%','MACHETE%','PALETA%'] },

      // Misc Electricidad
      { cat: 'Electricidad', match: ['LUZ %','LAMP %','MAGNET%','TRANSFORM%','REDUCT%','DIMMER%','BOMBA P/AGUA%','BOMBA ELEC%','BOMBA SUMERG%'] },

      // Pinturas extra
      { cat: 'Pinturas y acabados', match: ['PINTURA %','ESMALTE %','BARNIZ %','LACA %','DILUYENTE %','LIJA %','PINCEL %','BROCHA %','RODILLO %','PISTOLA P/PINTURA%','PISTOLA AIRE%','PISTOLA P/SOPLAR%','LIQUIDO P/PINT%'] },

      // Jardineria extra
      { cat: 'Jardineria y exterior', match: ['CABO P/PALA%','CABO P/AZADA%','CABO P/HACHA%','CABO P/MACHE%','HAMACA %','PILETA %','SOMBRILLA%','REPOSER%','ASADOR%','HAMAQUERA%','HORNILLA P/EXTER%','BANCO P/EXTER%','MOSQUITER%','GUADAÑA%','MOTOSIERRA%','BOMBA ROCIAD%','CUCHILLA P/CORTAR%'] },

      // Cerrajeria extra
      { cat: 'Cerrajeria y herrajes', match: ['PORTA %','CANDADO %','CIERRE %','RIEL %','RODAMIENTO %','FRENO %','PASADOR %','BISAGRA %','PESTILLO %','POMO %','PUERTA %','MANIJON%'] },

      // Plomeria extra
      { cat: 'Plomeria y sanitarios', match: ['SIFON%','CACHIMBA%','FILTRO P/%','FLEX %','GRIFER%','GRIFO %','MEZCLAD%','TEFLON %','CAUCHO %','GOMA P/AGUA%','CONEXION %','MANGUERA %','TANQUE %','VALVULA %','REJILLA%','PILETA%','CONTRATUERCA%','LLAVE DE PASO%','ROBINETE%','CACHO P/INODOR%','TAPA P/INODOR%','TAPA P/PILETA%'] },

      // Tornilleria extra
      { cat: 'Tornilleria y fijaciones', match: ['TIRAFONDO%','ARANDELA%','ANILLO%','GRAMPA %','TARUGO%','ANCLAJE%','PERNO %','TUERCA %','VARILLA ROSC%','ALMA %','MACHO %','HEMBRA %','CABO %','REMACHE%','CINTILLO%','PRECINTO%','TIRAS P/CABLE%'] },

      // Misc Herramientas
      { cat: 'Herramientas manuales', match: ['CUCHILLA%','PISTOLA %','PUNTA P/%','MARTILLO%','PINZA%','LLAVE %','SIERRA%','HERRAMIENTA%','ATORNILLAD%','AMOLADOR%','TALADRO%','ROTOMARTILL%','LIJADORA%','PULIDOR%','SOPLADOR%','DESTORNILLAD%'] },

      // Misc Electricidad (cubierta amplia)
      { cat: 'Electricidad', match: ['CABLE %','PILA %','BATERIA %','PORTA LAMP%','TUBO LED%','TUBO P/LED%','LED %','LINTERNA%','CARGADOR%','PLUG%','JACK%','RJ45%','HDMI%','VGA%','USB%'] }
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
