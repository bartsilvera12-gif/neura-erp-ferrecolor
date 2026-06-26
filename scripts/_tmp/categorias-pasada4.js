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
      // CEPILLO
      { cat: 'Limpieza',              match: ['CEPILLO BARR%','CEPILLO DE BARR%','CEPILLO P/PISO%','CEPILLO P/INODORO%','CEPILLO P/LIMP%','CEPILLO P/BAÑO%'] },
      { cat: 'Pinturas y acabados',   match: ['CEPILLO P/PINT%','CEPILLO DE CERDA%'] },
      { cat: 'Herramientas manuales', match: ['CEPILLO P/%','CEPILLO %'] },

      // TOMA, TOMACORRIENTE
      { cat: 'Electricidad', match: ['TOMA%','TIMBRE %','PROYECTOR %','ALUMBRADO%','FUENTE %','PASACABLE%','EXTRACTOR %','BORN%','BREAK%','PLUG%','FOCO%','REFLECT%','LED %','MAGNET%','VARIADOR%','CONTACTOR%','PORTAFUSIBLE%','FUSIBLE%','TRANSFORM%','ANALIZADOR%','LEISTUNG%','POWER%','BLANCO P/LED%','NEGRO P/LED%'] },

      // TELA
      { cat: 'Construccion', match: ['TELA P/MOSQ%','TELA MOSQ%','TELA CONSTR%','TEJIDO MOSQ%','TEJIDO ALAMB%','LONA %','LONA P/CARP%','LONA P/CAMION%'] },
      { cat: 'Adhesivos y selladores', match: ['TELA ADHES%','TELA %'] },

      // DOBLE
      { cat: 'Adhesivos y selladores', match: ['DOBLE FAZ%','DOBLE CINTA%'] },

      // MECANISMO
      { cat: 'Cerrajeria y herrajes', match: ['MECANISMO %','PORTACAND%','PORTA CAN%'] },

      // GOMA
      { cat: 'Plomeria y sanitarios', match: ['GOMA P/INOD%','GOMA P/CANIL%','GOMA P/CANO%','GOMA P/CAÑO%','GOMA P/GRIFO%','GOMA P/PILE%'] },
      { cat: 'Adhesivos y selladores', match: ['GOMA P/SELL%','GOMA EVA%'] },
      { cat: 'Herramientas manuales', match: ['GOMA %'] },

      // CUBIERTA y CORREA - autopartes (van a Herramientas como genérico)
      { cat: 'Herramientas manuales', match: ['CUBIERTA%','CORREA%','RULEMAN%','RODAMIENTO%','INFLADOR%','BOMBA P/INFL%','CAMARA%','LAPIZ %','PINZA%','LLAVE %','BITS%','CUCHILLO%','FRATACHO%','ARCO P/SIERRA%','ARCO DE SIERR%','VARILLA %','BASE P/HERR%','BASE %'] },

      // CANAL y CURVA → Plomeria
      { cat: 'Plomeria y sanitarios', match: ['CANAL %','CURVA %','SIFON%','CAUCHO%','TANQUE %','BOMBA P/AGUA%','PILETA %','VALVULA %','GRIFO%','MEZCLAD%'] },

      // COLLAR → Cerrajeria
      { cat: 'Cerrajeria y herrajes', match: ['COLLAR%'] },

      // MARCAS y misc Pinturas
      { cat: 'Pinturas y acabados', match: ['AMALUX%','SATINADO%','BRILLANTE%','PINTURA %','ESMALTE %','BARNIZ %','LATEX %','PASTA %','PINCEL%','BROCHA%','RODILLO%','LIJA%'] },

      // ACEITE - puede ser pinturas o herramientas
      { cat: 'Pinturas y acabados', match: ['ACEITE LINAZ%','ACEITE P/PINT%'] },
      { cat: 'Herramientas manuales', match: ['ACEITE %'] },

      // Jardineria
      { cat: 'Jardineria y exterior', match: ['TANZA%','ANZUELO%','PILETA INFL%','HAMACA%','REPOSER%','CARRETE %','MAQUINA P/JARD%','ASADOR%','HORNILLA EXTER%','PALO P/CARP%','TIENDA %','PARRILL%','BANCO %','COCINA P/JARD%','COCINA P/EXTER%'] },

      // COCINA → Limpieza/Plomería/Adhesivos según...
      { cat: 'Plomeria y sanitarios', match: ['COCINA %'] },

      // PLAST → Adhesivos o Construccion
      { cat: 'Construccion', match: ['PLAST %','PLASTICO%','PLAST P/PARED%','ALUMINIO%','PERFIL ALUM%','VARILLA ALUM%','VARILLA HIERR%','CUBETA P/PINT%'] },

      // FILTRO genérico → Plomeria (asume agua, también auto pero más probable agua)
      { cat: 'Plomeria y sanitarios', match: ['FILTRO P/AGUA%','FILTRO P/CANIL%','FILTRO %'] },

      // REPUESTO → no claro, va a Herramientas
      { cat: 'Herramientas manuales', match: ['REPUESTO%','PROYECTOR LASER%'] },

      // NEGRO, BLANCO, AZUL como primera palabra → suele ser color de un producto
      // Estos quedan sin categoría (mejor no asignar al azar)

      // C/, P/, PARA, DE → necesitan análisis de palabras siguientes
      // Hago algunos casos comunes:
      { cat: 'Herramientas manuales', match: ['P/TALAD%','P/AMOLAD%','P/HERR%','PARA TALAD%','PARA AMOLAD%','PARA HERR%'] },
      { cat: 'Electricidad', match: ['P/LAMP%','P/FOCO%','P/LED%','P/TOMA%','PARA LAMP%','PARA LED%'] },
      { cat: 'Plomeria y sanitarios', match: ['P/CANIL%','P/CAÑO%','P/CANO%','P/INODOR%','PARA CANIL%','PARA INODOR%'] },
      { cat: 'Pinturas y acabados', match: ['P/PINT%','P/PINTURA%','PARA PINT%','PARA LIJ%'] }
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
