// Pasada 7: matchea keyword en CUALQUIER posicion del nombre (no solo al inicio).
// Cubre productos como "0.5L AZUL INVICTA NEWELL", "1000 18KG VIAPOL", etc.
// Las reglas van de mas especifica (marcas) a mas general (palabras comunes)
// para que los matches mas claros ganen primero.
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
      // Marcas / nombres unicos (mas confiables)
      { cat: 'Pinturas y acabados', words: ['INVICTA','VIAPOL','VIAPLUS','BRILLALUX','AMANECER','ALBALATEX','AMAFLEX','AMATECH','CUBRELUX','CANATECH','SOLCOR','DURAFRENT','TEKNO COLOR','SHERWIN','RENNER','SUVINIL','ANTIOXIDO'] },
      { cat: 'Plomeria y sanitarios', words: ['TERMOCALEFON','CALEFON','TERMOTANQUE'] },
      { cat: 'Electricidad', words: ['VOLTIO','AMPER','HZ ','WATT','LUMEN'] },

      // Sustantivos especificos: alta probabilidad correcto
      { cat: 'Herramientas manuales', words: ['TALADRO','AMOLADOR','TALADRO','MOTOSIERRA','PISTOLA P/PINT','TRINCHET','SOLDADORA','REMACHADORA','CINCEL'] },
      { cat: 'Cerrajeria y herrajes', words: ['CANDADO','CERRADURA','BISAGRA','MANIJON'] },
      { cat: 'Construccion', words: ['CEMENTO','HORMIGON','LADRILLO ','BLOQUE','HORMIGONERA','MEMBRANA'] },
      { cat: 'Soldadura', words: ['ELECTRODO','ESTAÑO','MIG '] },

      // Reglas amplias (matchear en cualquier posicion)
      { cat: 'Herramientas manuales', words: ['TENAZA','PINZA','DESTORNILLADOR','MECHA','DISCO','MARTILLO','SIERRA','ALICATE','CUTTER','LLAVE','TIJERA','AMOLADORA','SOPLETE','FORMON','ALLEN','MULTIMETRO','VOLTIMETRO','PRENSA','ESCALERA','MANDRIL','BITS','BROCHA','PINCEL','RODILLO','LIMA','HACHA','MAZA','SARGENTO','MORDAZA','COPA','CUCHILLO','SERRUCHO','PUNTA'] },
      { cat: 'Electricidad', words: ['CABLE','LAMPARA','FOCO','LED','REFLECTOR','PROYECTOR','BOMBILLA','CARGADOR','PILA','BATERIA','CAPACITOR','PANEL','FICHA','TOMACORRIENTE','ENCHUFE','EXTENSION','ADAPTADOR','BREAKER','RESISTENCIA','VENTILADOR','LINTERNA','SOCKET','CAMARA','SENSOR','TIMBRE','TRANSFORMADOR','INTERRUPTOR','TABLERO','PORTALAMPARA','ALAMBRE','APLIQUE','SPOT','DICROICA','TORTUGA LED','FUSIBLE','PORTAFUSIBLE','BUSCAPOLO','ANTENA','TESTER','TIRA LED','VOLTAJE','POTENCIA'] },
      { cat: 'Plomeria y sanitarios', words: ['CANILLA','GRIFO','TUBO','CAÑO','CANO','PVC','SIFON','MANGUERA','TANQUE','BOMBA P/AGUA','VALVULA','REJILLA','INODORO','LAVATORIO','PILETA','BIDET','DUCHA','UNION','CONEXION','CODO','TAPON','CAUCHO','MEZCLADOR','GRIFER','CACHIMBA'] },
      { cat: 'Pinturas y acabados', words: ['PINTURA','ESMALTE','LATEX','BARNIZ','LACA','AEROSOL','SELLADOR','MASILLA','LIJA','SINTETICO','SATINADO','BRILLO','CERA','DILUYENTE','THINNER','ACRILICO','EPOXI','RESINA','REMOVEDOR'] },
      { cat: 'Construccion', words: ['CAL','YESO','ARENA','CARBON','PICO','PALA','CUCHARA','ESPATULA','PIOLA','CLAVO','PLOMADA','BALDE','REGLA','MALLA','SUNCHO','VARILLA','ANGULO','PERFIL','LLANA','FRATACHO','LONA','PUNTAL','MORTERO','MAZO','HORQUILLA','ESCUADRA','NIVEL DE','BARRA P/CONS','PIEDRA'] },
      { cat: 'Cerrajeria y herrajes', words: ['PESTILLO','PORTACAND','TIRADOR','PUERTA','MIRILLA','POMO','PITON','SOPORTE','RUEDA','RODA','COLLAR','BURLETE','MECANISMO','RIEL','FRENO','BALANCIN','CIERRE','HERRAJE','RODAMIENTO','RULEMAN','BISAGRA','GOZNE'] },
      { cat: 'Tornilleria y fijaciones', words: ['TORNILLO','TUERCA','PERNO','ARANDELA','REMACHE','GRAMPA','TARUGO','ANCLAJE','ABRAZADERA','PASADOR','BUJE','GANCHO','ANILLO','PRECINTO','CINTILLO','ESLABON','BALIN','RONDANA','TIRAFONDO','TIRA P/CABLE'] },
      { cat: 'Adhesivos y selladores', words: ['ADHESIVO','SILICONA','PEGAMENTO','COLA P/','MASILLA P/','POXIPOL','POXILINA','TANGIT','PEGA','ESPUMA POLIURETANO','CINTA DOBLE','CINTA EMBALAR','CINTA TEFLON','CINTA AISLAD'] },
      { cat: 'Seguridad y EPP', words: ['GUANTE','ZAPATON','LENTE','CASCO','MASCARA','MASCARILLA','BOTA DE','RESPIRADOR','ARNES','CHALECO','BARBIJO','BOTIN','EXTINTOR','TRAJE DE','PROTECTOR','TAPONES P/OIDO','OREJERA'] },
      { cat: 'Limpieza', words: ['ESCOBA','CEPILLO','TRAPO','TRAPEADOR','DETERGENTE','LAVANDINA','LIMPIA','JABON','ESPONJA','MOPA','BAYETA','LUSTRA','ACIDO MURI','PAPEL HIGIE','BOLSA BASUR','BOLSA P/BASUR','PASTILLA P/INO','DESINFECT','RECOGEDOR'] },
      { cat: 'Soldadura', words: ['SOLDADOR','SOLDADURA','CARBURO','HILO P/SOLD','PASTA P/SOLD','OXIGENO','ACETIL'] },
      { cat: 'Jardineria y exterior', words: ['RASTRILLO','AZADA','ASPERSOR','PULVERIZADOR','REGADERA','CARPA','MACETA','SEMILLA','GUADAÑA','MOTOSIERRA','BORDEADORA','CORTACESPED','TANZA','VENENO','HERBICID','INSECTIC','TRIMMER','DESMALEZ','HAMACA','PARASOL','REPOSER','BORRACHA','MANGUERA P/JARD'] }
    ];

    let total = 0;
    for (const r of reglas) {
      if (!map[r.cat]) continue;
      const conds = r.words.map((_, i) => 'nombre ILIKE $' + (i + 3)).join(' OR ');
      const params = [map[r.cat], EMP, ...r.words.map(w => '%' + w + '%')];
      const up = await c.query(
        `UPDATE ferreteriarepublica.productos SET categoria_principal_id=$1 WHERE empresa_id=$2 AND categoria_principal_id IS NULL AND ( ${conds} )`,
        params
      );
      if (up.rowCount > 0) console.log(`  +${up.rowCount} -> ${r.cat}`);
      total += up.rowCount;
    }
    console.log('Total movidos pasada 7:', total);

    const veri = await c.query(`
      SELECT cp.nombre, COUNT(p.id) AS cnt
      FROM ferreteriarepublica.categorias_productos cp
      LEFT JOIN ferreteriarepublica.productos p ON p.categoria_principal_id=cp.id AND p.empresa_id=cp.empresa_id
      WHERE cp.empresa_id=$1 GROUP BY cp.nombre ORDER BY cnt DESC
    `, [EMP]);
    console.log('Resumen final:'); console.table(veri.rows);

    const sc = await c.query(`SELECT COUNT(*) FROM ferreteriarepublica.productos WHERE empresa_id=$1 AND categoria_principal_id IS NULL`, [EMP]);
    console.log('Sin categoria:', sc.rows[0].count);

    await c.query('COMMIT');
  } catch (e) {
    await c.query('ROLLBACK');
    console.error('ROLLBACK', e.message);
    process.exit(1);
  }
  await c.end();
}
main();
