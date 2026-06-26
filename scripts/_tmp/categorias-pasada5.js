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
      // Herramientas: cortadores, arcos sierra, formones, allen, gatos hidraulicos, set, sacabocados, multitester etc.
      { cat: 'Herramientas manuales', match: [
        'CORTADOR%','CORTA TUBO%','ARCO SIERRA%','ARCO P/SIERR%','FORMON %','FORMONES%','ALLEN %','GATO %','SACABOCAD%','SET DE %','MACHETILLO%','BALANZA%','MULTITESTER%','MULTIMETRO%','TESTER%','PUNZON%','CHAVETA%','CALIBRE %','VERNIER%','DESBOCADOR%','EXTRACTOR DE%','CALADORA%','SOPLET%','SARGENT%','GUIA P/%','BROCA%','FRESA %'
      ] },

      // Plomeria: llaves de paso, conexiones, gas
      { cat: 'Plomeria y sanitarios', match: [
        'DE PASO%','LLAVE DE PASO%','LLAVE P/AGUA%','LLAVE TANQUE%','TRAMPA%','SIFON%','RAMAL %','GRIFER%','GRIFO %','CACHIMBA%','CONEXION%','MANGUITO%','REDUCC%','UNION DOBLE%','LLAVE MEZC%','LLAVE TIPO%','PIE DE %','RAMAL P/%','RAMAL Y%','RAMAL T%','TUBO%','PVC%','CPVC%','CAÑO%','CANO%','NIPLE%'
      ] },

      // Soldadura: estaño, gas refrigerante (mas a electricidad), removedores no
      { cat: 'Soldadura', match: ['ESTAÑO%','GAS P/SOLD%','CARBURO%','BOQUILLA P/SOLD%','VARILLA P/SOLD%','PASTA P/SOLD%','OXIGENO%','ACETIL%'] },

      // Pinturas: marcas, removedores, acrilicos, ceras, cubrelux, machetillo de pintor
      { cat: 'Pinturas y acabados', match: [
        'AMAFLEX%','ACRILICO%','REMOVEDOR%','BLASCOR%','AMATECH%','CUBRELUX%','CANATECH%','BARNIZ%','CERA %','CERA P/PARQ%','CERA P/MADER%','CERA P/AUTO%','CERA LIQUIDA%','MACHETILLO PINT%','TRINCHETA%','SPATULA P/PINT%','RASQUETA%','RASCADOR%','OVERPRINT%','FANTASIA%','SUVINIL%','SHERWIN%','RENNER%','ALBA %','CEMENTO BLANCO%','EXPOXI%','ESMALT%','CONVERT%'
      ] },

      // Construccion: membranas, separadores, mallas, tejidos, piolines, media sombra
      { cat: 'Construccion', match: [
        'MEMBRANA%','SEPARADOR%','SEPARADORA%','MALLA %','MALLA P/HORM%','MALLA HEX%','TEJIDO %','TEJIDO GALLI%','PIOLIN%','PIOLA%','CORDON %','MEDIA SOMBRA%','HORMIGONERA%','MEZCLAD P/HORM%','LIENZA%','VARILLA HIERR%','VARILLA P/CONS%','REGLA P/OBR%','BLOCK%','MARMOL%','GRANITO%','BURBUJA%','ANGULAR %','ABRACADER%','BRACAGUA%','PRELOSA%','CINTA P/AISL%','ARGAMASA%','PEGAMENT P/CER%','MORTERO%','CHAPA %','LADRILL%','TRENCH%','ANCLA %','TRABA %','PERFIL %','MOLDURA %','ZOCALO%','MEDIANA %'
      ] },

      // Electricidad: gas refrigerante (no realmente, pero acerca), detectores, dicroicas, antenas, tortuga led, narva, multitester (mejor en herramientas pero electricos van)
      { cat: 'Electricidad', match: [
        'GAS REFRIG%','DETECTOR %','DICROICA%','BUSCAPOLO%','ANTENA%','TORTUGA LED%','TORTUGA P/EX%','TORTUGA P/EM%','NARVA%','REGLETA%','LLAVE TERM%','LLAVE INTER%','REGLETA ELEC%','TIRA LED%','BARRA LED%','EMERGEN%','LUMINAR%','PORTATIL%','FAROL%','FAROLA%','MEDIDOR%','BOBINA%','MOTOR ELEC%','MULTITAP%','BUJIA %','BUJIA P/AUTO%','ANTIPARASITARIO%','TIMBRE%','AISLANTE %','VENTILADOR %','CALEFAC%','TERMOST%','PANEL %','PORTABATER%','SECADOR%','PLANCHA%','POLISTER%','BALASTO%','BALASTRO%','REFLECTOR%','MULTIPLE%','CONDUIT%','POLIDUCT%','CORRUGADO%','ROTARY %'
      ] },

      // Tornilleria: argollas, eslabones, balines, etc.
      { cat: 'Tornilleria y fijaciones', match: ['ARGOLLA%','ESLABON%','BALIN%','BALINES%','PASADOR%','CHAVETON%','TUERCA %','PERNO %','ARANDELA%','GANCHO%','TIRA P/CABLE%','TIRAS P/CABLE%','PRECINTO%'] },

      // Cerrajeria: numeros residenciales, brazo p/puerta, balancin, brazo para
      { cat: 'Cerrajeria y herrajes', match: ['NUMERO RES%','NUMERO P/CAS%','LETRA %','BRAZO P/PUER%','BRAZO PARA%','BALANCIN%','MIRILLA%','BISAGRA%','TIRADOR%','MANIJON%','POMO%','CANDADO%','CERRADURA%','RIEL %','RODA %','MARTINETE%','GIRA %','GOZNE%','CIERRE %','PASADOR DE PUER%'] },

      // Limpieza: acidos, ceras, dispensadores, papel, trapos algodon
      { cat: 'Limpieza', match: ['ACIDO MURI%','ACIDO P/LIMP%','DISPENSADOR %','DESODORANTE%','PAPEL %','SCOTCH BRITE%','ESPONJA %','LIQUIDO DESINF%','PROFUSO%','DE ALGODON%','JABON %','PASTILLA P/INO%','CLORO %','CREOLINA%','LIMPIA %','HIPOCLOR%','MERCAPTAN%'] },

      // Seguridad: trajes, traje de pintor, anteojos, faja, mascarillas
      { cat: 'Seguridad y EPP', match: ['TRAJE %','DE SEGURID%','MASCARI%','MASCARA %','RESPIRADOR%','PROTECTOR %','GAFA%','ANTEOJO%','BOTIN %','CINTURON SEG%','ARNES%','CASCO%','GUANTE%','ANTEOJOS DE SEG%','FAJA %'] },

      // Adhesivos
      { cat: 'Adhesivos y selladores', match: ['ESPUMA POLI%','ESPUMA EXPAND%','SILICONA %','SELLADOR %','PEGAMENTO %','COLA %','MASILLA %','BURLETE %','TANGIT %','CEMENTO P/PVC%','RUBBERSEAL%','MARFIL %','POXIPOL%','POXILIN%'] },

      // Jardineria: venenos, trimmer, malla media sombra, formoncin de jardin
      { cat: 'Jardineria y exterior', match: ['VENENO %','MATA INSECTO%','MATAINSECT%','MATA MALEZA%','HERBICID%','INSECTIC%','TRIMMER%','DESMALEZ%','BORDEAD%','MOTOSIERRA%','MOCH P/FUMIG%','ATOMIZADOR%','REGADERA%','ASPERSOR%','MANGUERA P/JARD%','MANGUERA P/RIEG%','MACETA%','ALMACIGO%','SEMILLA%','BOMBA %','PALA DE JARD%','RASTRILL%','HORQUILLA%','PARA PERRO%','ALIMENTO P/PERR%','COLLAR P/MASCO%','PIPETA P/MASCO%','TENAZA DE PODA%'] }
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
