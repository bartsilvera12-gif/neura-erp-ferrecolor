const pg = require('pg');
const c = new pg.Client({ connectionString: process.env.SUPABASE_DB_URL });
const EMP = '75f4194a-a24a-4e9b-830e-4506f2d9b2a6';

async function main() {
  await c.connect();
  await c.query('BEGIN');
  try {
    // Crear Jardineria si no existe
    const jardImg = 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?auto=format&fit=crop&w=1200&q=85';
    await c.query(
      `INSERT INTO ferreteriarepublica.categorias_productos (id, empresa_id, nombre, codigo, descripcion, imagen_url, activo)
       VALUES (gen_random_uuid(), $1, $2, $3, $4, $5, true)
       ON CONFLICT DO NOTHING`,
      [EMP, 'Jardineria y exterior', 'JARD', 'Herramientas de jardin, aspersores, mangueras, carpas y exterior.', jardImg]
    );

    const ex = await c.query(`SELECT id, nombre FROM ferreteriarepublica.categorias_productos WHERE empresa_id=$1`, [EMP]);
    const map = {};
    for (const row of ex.rows) map[row.nombre] = row.id;

    const reglas = [
      // Jardineria (specific keywords)
      { cat: 'Jardineria y exterior', match: ['RASTRILLO%','AZADA%','ASPERSOR%','PULVERIZADOR%','REGADERA%','CARPA%','SEMILLA%','MACETA%','TIJERA P/JARD%','TIJERA DE PODA%','PALA P/JARD%','HORQUILLA%','PILETA INFL%','PARASOL%','REPOSERA%','HAMACA%','MANGUERA P/JARD%','BOLSA P/PLANT%','SUSTRATO%','ABONO%','FERTIL%','TIERRA%','MOTOSIERRA%','BORDEADORA%','CORTACESPED%','GUADAÑA%'] },

      // Construccion - mas keywords
      { cat: 'Construccion', match: ['PASTINA%','LLANA%','REGATON%','CARBON %','CARBONELL%','ANCLA%','CORDON DE%','CORDON P/OBRA%','CAJA OCTOG%','CAJA REPART%','BLOQUE%','LADRILLO%','PIEDRA%','CEMENTO%','CAL %','YESO%','ARENA%','MORTERO%','SUNCHO%','MEMBRANA%','CARRO%','ALAMBRE P/HORM%'] },

      // Tornilleria mas keywords
      { cat: 'Tornilleria y fijaciones', match: ['GANCHO%','ANILLO P/%','CABO P/HERR%','COLLAR DE FIJ%','MACHO P/%','HEMBRA P/%','CINTILLO%','VARILLA RIGID%','PRECINTO%','PRECINTOS%'] },

      // Cerrajeria mas keywords
      { cat: 'Cerrajeria y herrajes', match: ['TIRADOR%','MECANISMO P/CERR%','PORTA CANDA%','TARJETA P/PUER%','BURLETE%','PORTA LLAVE%','CIERRE %','RIEL P/PUER%','RODAMIENTO P/PUER%','FRENO DE PUER%','PASADOR DE PUER%','BRAZO DE PUER%','PITON %','ESQUINERO%'] },

      // Electricidad mas amplia
      { cat: 'Electricidad', match: ['CARGADOR%','RESISTENCIA%','PORTA LAMP%','APLIQUE%','CAMARA DE VIGIL%','CAMARA IP%','CAMARA WIFI%','CONTROL REMOT%','FOTOCELULA%','ARTEFACTO %','SPOT%','MINI LED%','MINI SPOT%','AURICULAR%','ALAMBRE GALVAN%','ALAMBRE CALIB%','TOMA TIERRA%','TOMA HEMBRA%','TOMA TRIFAS%','ADAPTADOR%','ELECTRICA%','PANEL %','EXTENSION%','LLAVE ELE%','PORTA FUS%','FUSIBLE%','BORNERA%','GUARDAM%','LLAVE TM%','BREAK%','LINTERNA%','FOCO%','BOMBILLA%','LAMPARA%'] },

      // Plomeria mas amplia
      { cat: 'Plomeria y sanitarios', match: ['SOPAPA%','CANAL P/AGUA%','CANALETA%','CURVA PVC%','CURVA HG%','CURVA P/%','COLLAR P/PVC%','COLLAR P/AGUA%','CISTERNA%','FILTRO P/AGUA%','PILETA DE COC%','PILETA P/BAÑO%','PILETA P/LAV%','PILETA DE LAV%','PITON %','VASTAGO%','REJILLA P/PILE%','HOJA P/INODORO%','GRIFER%','MEZCLADOR%','BIDET%','INODORO%','LAVATORIO%','DUCHA%','TANQUE DE AGUA%','UNION RAP%','MANGUERA P/AGUA%','MANGUERA TRENZ%','ROBINETE%','FLOT%','CACHIMBA%','CABO DE GRIFO%','CACHO P/INODOR%','CONTRATUERCA%','FLEX P/AGUA%','LLAVE DE PASO%','ASIENTO P/INODORO%','TAPA P/INODORO%','TAPA P/PILETA%'] },

      // Pinturas mas amplia
      { cat: 'Pinturas y acabados', match: ['SATINADO%','ANTIOXIDO%','ANTIOXIDANTE%','CORTA %','CORTA DE %','AMANECER %','DURAFRENT%','SOLCOR%','LATEX%','BRILLO%','MATE %','SEMI MATE%','POLIURETANO%','EPOXI%','RESINA%','PASTA P/PARE%','MASILLA P/MADER%','MASILLA P/PARE%','CONVERT%','TRATAMIENTO P/MADERA%','PROTECTOR P/MADER%'] },

      // Herramientas manuales mas amplia
      { cat: 'Herramientas manuales', match: ['CORTA HIERR%','CORTA TUBO%','CORTA CABLE%','CORTA CRIST%','CORTA VIDR%','CORTA AZULEJ%','PUNTA P/DEST%','PUNTA P/TALAD%','SERRUCHO%','PRENSA%','ESCALERA%','MANDRIL%','LAPIZ %','BITS%','MINI HERR%','HOJA P/SIERRA%','HOJA P/CUTTER%','PISTOLA P/CALAFAT%','PISTOLA P/PINT%','PISTOLA P/SOPLAR%','PISTOLA CALOR%','PISTOLA P/SILICON%','REGLA %','METRO %','SARGENTO%','MORDAZA%','TRANSPORTADOR%','GRAMILA%','GRAFOMETRO%','LIMA %','LIMATON%','TARRAJA%','MORDACERO%','APRIETA%','GATO P/AUTO%','GATA HIDRA%','PULIDORA%','GRUA%','PRENSA DE BANCO%'] },

      // Seguridad y EPP mas amplia
      { cat: 'Seguridad y EPP', match: ['NEGRO P/EPP%','PROTECTOR%','TAPONES P/OIDO%','OREJERA%','BARBIJO%','BOTIN%','EXTINTOR%','CARTEL DE SEGUR%','LINEA DE VIDA%','SOGA P/EPP%','CUERDA P/EPP%','MOSQUETON%','CINTURON DE SEG%'] },

      // Limpieza mas amplia
      { cat: 'Limpieza', match: ['BOLSA P/BASUR%','GOMA P/LIMP%','LIMPIA VIDR%','LIMPIA HORN%','LIMPIA INOD%','ESPONJA%','TOALLA P/LIMP%','PAPEL HIGIENICO%','PAPEL P/COCINA%','JABON%','SHAMPOO P/AUTO%','SCRUB%','FIBRA P/LIMP%','PASTILLA P/INOD%','DESINFECT%','ALCOHOL%','SODA CAUST%','BICARBONATO%','VINAGRE%','CERA P/PISO%'] },

      // Adhesivos mas amplia
      { cat: 'Adhesivos y selladores', match: ['GOMA EVA%','TELA ADHES%','TELA P/CARP%','PEGA AZULEJ%','CEMENTO P/PVC%','PASTA P/PEGAR%','ACOPLE RAPID%','ESPUMA EXP%','ESPUMA P/SELL%','BURLETE ADHES%','PEGA POXY%','TIRA ADHES%'] }
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
