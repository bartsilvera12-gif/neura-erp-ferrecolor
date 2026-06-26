// Pasada 6: productos cuyo nombre empieza con un prefijo numerico
// (ej "0012 TENAZA ARMADOR", "01 BROCHA", "100M JUSTER"). Las pasadas
// anteriores filtraban por primera palabra y los saltearon todos. Aca
// usamos PostgreSQL para sacar el prefijo numerico antes de buscar.
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

    // Para cada categoria, hacemos UPDATE con regex que matchea palabras claves
    // ignorando prefijo numerico (digitos, puntos, comas, espacios al inicio).
    const reglas = [
      { cat: 'Herramientas manuales', words: ['TENAZA','PINZA','DESTORNILLADOR','MECHA','DISCO','TORNILLO','BULON','MARTILLO','SIERRA','CINCEL','ESCUADRA','NIVEL','ALICATE','PERFORADOR','CUTTER','LLAVE','TIJERA','AMOLADORA','TALADRO','SOPLETE','REMACHADOR','CORTADOR','ARCO','FORMON','ALLEN','GATO','MULTIMETRO','VOLTIMETRO','PRENSA','ESCALERA','MANDRIL','LAPIZ','BITS','LIMA','HACHA','MAZA','CARRETILLA','SARGENTO','MORDAZA','BROCHA','PINCEL','RODILLO'] },
      { cat: 'Electricidad', words: ['CABLE','LAMPARA','FOCO','LED','LUZ','REFLECTOR','PROYECTOR','BOMBILLA','CARGADOR','PILA','BATERIA','CAPACITOR','PANEL','FICHA','TOMACORRIENTE','ENCHUFE','EXTENSION','ADAPTADOR','BREAKER','RESISTENCIA','VENTILADOR','LINTERNA','SOCKET','CAMARA','SENSOR','TIMBRE','TRANSFORMADOR','INTERRUPTOR','TABLERO','PORTALAMPARA','ALAMBRE'] },
      { cat: 'Plomeria y sanitarios', words: ['CANILLA','GRIFO','TUBO','CAÑO','CANO','PVC','SIFON','MANGUERA','TANQUE','BOMBA','VALVULA','REJILLA','INODORO','LAVATORIO','PILETA','BIDET','DUCHA','TERMOCALEFON','TERMO','CALEFON','UNION','CONEXION','CODO','TAPON','CAUCHO','BORDE'] },
      { cat: 'Pinturas y acabados', words: ['PINTURA','ESMALTE','LATEX','BARNIZ','LACA','AEROSOL','SELLADOR','MASILLA','LIJA','VIAPOL','VIAPLUS','INVICTA','SINTETICO','BRILLALUX','AMANECER','ALBALATEX','AMAFLEX','AMATECH','CUBRELUX','CANATECH','SOLCOR','DURAFRENT','ANTIOXIDO','SATINADO','BRILLO','CERA','DILUYENTE','THINNER'] },
      { cat: 'Construccion', words: ['CEMENTO','LADRILLO','BLOQUE','PIEDRA','MORTERO','CAL','YESO','ARENA','CARBON','PICO','PALA','CUCHARA','ESPATULA','PIOLA','CLAVO','PLOMADA','BALDE','REGLA','MEMBRANA','MALLA','SUNCHO','HORMIGON','VARILLA','ANGULO','PERFIL','LLANA','FRATACHO','HOJA','TEJIDO','LONA','ALAMBRE','PUNTAL','CARRETILLA'] },
      { cat: 'Cerrajeria y herrajes', words: ['CANDADO','CERRADURA','BISAGRA','MANIJA','PESTILLO','PORTACAND','TIRADOR','PUERTA','MIRILLA','POMO','PITON','SOPORTE','RUEDA','RODA','COLLAR','BURLETE','MECANISMO','RIEL','FRENO','BALANCIN','CIERRE'] },
      { cat: 'Tornilleria y fijaciones', words: ['TORNI','TUERCA','PERNO','ARANDELA','REMACHE','GRAMPA','TARUGO','ANCLAJE','ABRAZADERA','PASADOR','BUJE','GANCHO','ANILLO','CADENA','PRECINTO','CINTILLO','ESLABON','BALIN','RONDANA','TIRAFONDO'] },
      { cat: 'Adhesivos y selladores', words: ['ADHESIVO','SILICONA','PEGAMENTO','COLA','MASILLA','SELLADOR','POXIPOL','POXILINA','GOMA','CINTA','TANGIT','PEGA','ESPUMA POLIURETANO'] },
      { cat: 'Seguridad y EPP', words: ['GUANTE','ZAPATON','LENTE','CASCO','MASCARA','MASCARILLA','BOTA','RESPIRADOR','ARNES','CHALECO','BARBIJO','BOTIN','EXTINTOR','TRAJE','PROTECTOR'] },
      { cat: 'Limpieza', words: ['ESCOBA','CEPILLO','TRAPO','TRAPEADOR','DETERGENTE','LAVANDINA','LIMPIA','JABON','ESPONJA','MOPA','BAYETA','LUSTRA','ACIDO','PAPEL','BOLSA','PASTILLA','DESINFECT'] },
      { cat: 'Soldadura', words: ['SOLDADOR','ELECTRODO','SOLDADURA','MIG','ESTAÑO','ESTANO','CARBURO'] },
      { cat: 'Jardineria y exterior', words: ['RASTRILLO','AZADA','ASPERSOR','PULVERIZADOR','REGADERA','CARPA','MACETA','SEMILLA','GUADAÑA','MOTOSIERRA','BORDEADORA','CORTACESPED','TANZA','MANGUERA P/JARD','VENENO','HERBICID','INSECTIC','TRIMMER','DESMALEZ','HAMACA','PARASOL','REPOSER'] }
    ];

    let total = 0;
    for (const r of reglas) {
      if (!map[r.cat]) continue;
      // Construir condicion: nombre matchea palabra al inicio O despues de prefijo numerico
      // Ej: nombre ~* '^[0-9.,]+\s+(TENAZA|PINZA|...)' OR nombre ILIKE 'TENAZA%' OR ...
      const escaped = r.words.map(w => w.replace(/'/g, "''"));
      const ilikes = escaped.map(w => `nombre ILIKE '${w}%'`).join(' OR ');
      const regexes = escaped.map(w => `nombre ~* '^[0-9.,]+\\s+${w}'`).join(' OR ');
      const sql = `UPDATE ferreteriarepublica.productos
                   SET categoria_principal_id = $1
                   WHERE empresa_id = $2
                     AND categoria_principal_id IS NULL
                     AND ( ${ilikes} OR ${regexes} )`;
      const up = await c.query(sql, [map[r.cat], EMP]);
      if (up.rowCount > 0) console.log(`  +${up.rowCount} -> ${r.cat}`);
      total += up.rowCount;
    }
    console.log('Total movidos pasada 6:', total);

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
