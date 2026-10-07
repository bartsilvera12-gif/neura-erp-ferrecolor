-- =============================================================================
-- Notas de crédito de COMPRA (recibidas de proveedor)
-- -----------------------------------------------------------------------------
-- Caso: el proveedor factura productos que el cliente no pidió y luego emite una
-- Nota de Crédito. El ERP debe permitir registrar esa NC recibida, vincularla a
-- la(s) compra(s) original(es), seleccionar productos/cantidades afectadas y, al
-- CONFIRMAR, descontar del stock la mercadería devuelta/no aceptada.
--
-- Diseño (acordado):
--   * NO reutiliza ni toca la NC de VENTA (tabla `nota_credito`): es un módulo
--     independiente bajo Compras.
--   * NO recalcula costo_promedio del producto (hoy es "último costo", no CPP real):
--     solo descuenta stock y deja el costo en el movimiento para trazabilidad/libro.
--   * El impacto en stock ocurre SOLO al confirmar (estado borrador -> confirmada),
--     en una transacción con guard de estado para ser idempotente (no duplica stock
--     aunque se confirme dos veces o haya doble click).
--   * Cada ítem de NC referencia una fila `compras` concreta (compra_id), porque el
--     modelo de Compras es 1 producto por fila (no hay cabecera/detalle de factura).
--
-- Multi-esquema: se instala en TODO esquema que ya tenga la tabla `compras`
-- (public / zentra_erp / er_<hex32> / erp_* / ferrecolor), de forma idempotente.
-- Las tablas nuevas quedan en el MISMO esquema que `compras`/`productos` para que
-- las FKs sean locales.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.neura_install_notas_credito_compra(p_schema text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  s   text := btrim(p_schema);
  q   text;               -- identificador de schema citado
  acl text;               -- función puede_acceder_empresa calificada a usar en RLS
  chk record;
BEGIN
  IF s IS NULL OR s = '' THEN
    RAISE EXCEPTION 'neura_install_notas_credito_compra: schema vacío';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = s) THEN
    RAISE NOTICE 'neura_install_notas_credito_compra: schema % no existe (omitido)', s;
    RETURN;
  END IF;
  -- Solo instalar donde exista `compras` (de lo contrario la FK fallaría).
  IF NOT EXISTS (
    SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = s AND c.relname = 'compras' AND c.relkind = 'r'
  ) THEN
    RAISE NOTICE 'neura_install_notas_credito_compra: % no tiene tabla compras (omitido)', s;
    RETURN;
  END IF;

  q := quote_ident(s);

  -- Resolver la función puede_acceder_empresa disponible (defensa en profundidad;
  -- el pool de la app conecta como owner y bypassa RLS igual).
  SELECT CASE
           WHEN EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
                        WHERE n.nspname = s AND p.proname = 'puede_acceder_empresa')
             THEN q || '.puede_acceder_empresa'
           WHEN EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
                        WHERE n.nspname = 'zentra_erp' AND p.proname = 'puede_acceder_empresa')
             THEN 'zentra_erp.puede_acceder_empresa'
           WHEN EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
                        WHERE n.nspname = 'public' AND p.proname = 'puede_acceder_empresa')
             THEN 'public.puede_acceder_empresa'
           ELSE NULL
         END
    INTO acl;

  -- ---------------------------------------------------------------------------
  -- 1) Cabecera: notas_credito_compra
  -- ---------------------------------------------------------------------------
  EXECUTE format($ddl$
    CREATE TABLE IF NOT EXISTS %1$s.notas_credito_compra (
      id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      empresa_id      uuid NOT NULL,
      proveedor_id    uuid NOT NULL,
      proveedor_nombre text NOT NULL,
      numero_control  text NOT NULL,                 -- NCC-000001 (correlativo interno)
      nro_comprobante text,                          -- N° de la NC emitida por el proveedor
      nro_timbrado    text,
      motivo          text,
      moneda          text NOT NULL DEFAULT 'PYG' CHECK (moneda IN ('PYG','USD')),
      tipo_cambio     numeric NOT NULL DEFAULT 1,
      subtotal        numeric NOT NULL DEFAULT 0,
      monto_iva       numeric NOT NULL DEFAULT 0,
      total           numeric NOT NULL DEFAULT 0,
      estado          text NOT NULL DEFAULT 'borrador'
                        CHECK (estado IN ('borrador','confirmada','anulada')),
      fecha           timestamptz NOT NULL DEFAULT now(),
      confirmada_at   timestamptz,
      created_at      timestamptz NOT NULL DEFAULT now(),
      updated_at      timestamptz NOT NULL DEFAULT now(),
      created_by      uuid,
      usuario_nombre  text
    )
  $ddl$, q);

  -- FK proveedor_id local
  BEGIN
    EXECUTE format('ALTER TABLE %1$s.notas_credito_compra DROP CONSTRAINT IF EXISTS ncc_proveedor_id_fkey', q);
    EXECUTE format(
      'ALTER TABLE %1$s.notas_credito_compra
         ADD CONSTRAINT ncc_proveedor_id_fkey
         FOREIGN KEY (proveedor_id) REFERENCES %1$s.proveedores(id) ON DELETE RESTRICT',
      q);
  EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'ncc FK proveedor en %: %', s, SQLERRM; END;

  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_empresa ON %1$s.notas_credito_compra (empresa_id)', q);
  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_proveedor ON %1$s.notas_credito_compra (proveedor_id)', q);
  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_empresa_fecha ON %1$s.notas_credito_compra (empresa_id, fecha DESC)', q);
  EXECUTE format(
    'CREATE UNIQUE INDEX IF NOT EXISTS uq_ncc_empresa_numero_control ON %1$s.notas_credito_compra (empresa_id, numero_control)',
    q);

  -- ---------------------------------------------------------------------------
  -- 2) Detalle: notas_credito_compra_items
  -- ---------------------------------------------------------------------------
  EXECUTE format($ddl$
    CREATE TABLE IF NOT EXISTS %1$s.notas_credito_compra_items (
      id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
      nota_credito_compra_id  uuid NOT NULL,
      empresa_id              uuid NOT NULL,
      compra_id               uuid NOT NULL,
      producto_id             uuid NOT NULL,
      producto_nombre         text NOT NULL,
      producto_sku            text NOT NULL DEFAULT '',
      cantidad                numeric NOT NULL CHECK (cantidad > 0),
      costo_unitario          numeric NOT NULL DEFAULT 0,
      iva_tipo                text NOT NULL DEFAULT '10' CHECK (iva_tipo IN ('exenta','5','10')),
      subtotal                numeric NOT NULL DEFAULT 0,
      monto_iva               numeric NOT NULL DEFAULT 0,
      total                   numeric NOT NULL DEFAULT 0,
      movimiento_id           uuid,                  -- SALIDA generado al confirmar (trazabilidad)
      created_at              timestamptz NOT NULL DEFAULT now()
    )
  $ddl$, q);

  BEGIN
    EXECUTE format('ALTER TABLE %1$s.notas_credito_compra_items DROP CONSTRAINT IF EXISTS ncc_items_nc_fkey', q);
    EXECUTE format(
      'ALTER TABLE %1$s.notas_credito_compra_items
         ADD CONSTRAINT ncc_items_nc_fkey
         FOREIGN KEY (nota_credito_compra_id) REFERENCES %1$s.notas_credito_compra(id) ON DELETE CASCADE',
      q);
  EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'ncc_items FK nc en %: %', s, SQLERRM; END;

  BEGIN
    EXECUTE format('ALTER TABLE %1$s.notas_credito_compra_items DROP CONSTRAINT IF EXISTS ncc_items_compra_fkey', q);
    EXECUTE format(
      'ALTER TABLE %1$s.notas_credito_compra_items
         ADD CONSTRAINT ncc_items_compra_fkey
         FOREIGN KEY (compra_id) REFERENCES %1$s.compras(id) ON DELETE RESTRICT',
      q);
  EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'ncc_items FK compra en %: %', s, SQLERRM; END;

  BEGIN
    EXECUTE format('ALTER TABLE %1$s.notas_credito_compra_items DROP CONSTRAINT IF EXISTS ncc_items_producto_fkey', q);
    EXECUTE format(
      'ALTER TABLE %1$s.notas_credito_compra_items
         ADD CONSTRAINT ncc_items_producto_fkey
         FOREIGN KEY (producto_id) REFERENCES %1$s.productos(id) ON DELETE RESTRICT',
      q);
  EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'ncc_items FK producto en %: %', s, SQLERRM; END;

  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_items_nc ON %1$s.notas_credito_compra_items (nota_credito_compra_id)', q);
  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_items_compra ON %1$s.notas_credito_compra_items (compra_id)', q);
  EXECUTE format('CREATE INDEX IF NOT EXISTS idx_ncc_items_producto ON %1$s.notas_credito_compra_items (producto_id)', q);

  -- ---------------------------------------------------------------------------
  -- 3) Extender CHECK de movimientos_inventario.origen para 'nota_credito_compra'.
  --    IMPORTANTE: se PRESERVAN dinámicamente los valores actuales (que en prod
  --    incluyen devolucion_venta y transferencia, no solo los del esquema base) y
  --    solo se AGREGA el nuevo valor. No se re-valida negativamente ningún
  --    movimiento existente porque el conjunto nuevo es un superconjunto del actual.
  -- ---------------------------------------------------------------------------
  IF EXISTS (
    SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = s AND c.relname = 'movimientos_inventario' AND c.relkind = 'r'
  ) THEN
    DECLARE
      v_conname text;
      v_vals text[] := ARRAY[]::text[];
      m text[];
      v_list text;
    BEGIN
      -- Localizar el check real sobre `origen` (nombre variable: chk_mov_origen,
      -- movimientos_inventario_origen_check, etc.) y extraer sus valores actuales.
      SELECT con.conname INTO v_conname
      FROM pg_constraint con
      JOIN pg_class c ON c.oid = con.conrelid
      JOIN pg_namespace n ON n.oid = c.relnamespace
      WHERE n.nspname = s AND c.relname = 'movimientos_inventario'
        AND con.contype = 'c'
        AND pg_get_constraintdef(con.oid) ILIKE '%origen%'
      LIMIT 1;

      IF v_conname IS NOT NULL THEN
        FOR m IN
          SELECT regexp_matches(
                   pg_get_constraintdef(con.oid),
                   '''([a-zA-Z_][a-zA-Z0-9_]*)''', 'g')
          FROM pg_constraint con
          JOIN pg_class c ON c.oid = con.conrelid
          JOIN pg_namespace n ON n.oid = c.relnamespace
          WHERE n.nspname = s AND c.relname = 'movimientos_inventario'
            AND con.conname = v_conname
        LOOP
          v_vals := array_append(v_vals, m[1]);
        END LOOP;
      END IF;

      -- Baseline por si no existiera el check (defensa) + union con lo hallado + nuevo valor.
      v_vals := v_vals
        || ARRAY['compra','venta','ajuste_manual','inventario_inicial']
        || ARRAY['nota_credito_compra'];

      -- Distinct preservando: construir lista citada única.
      SELECT string_agg(quote_literal(x), ',')
        INTO v_list
      FROM (SELECT DISTINCT unnest(v_vals) AS x) u;

      IF v_conname IS NOT NULL THEN
        EXECUTE format('ALTER TABLE %1$s.movimientos_inventario DROP CONSTRAINT %2$I', q, v_conname);
      END IF;
      EXECUTE format(
        'ALTER TABLE %1$s.movimientos_inventario ADD CONSTRAINT %2$I CHECK (origen IN (%3$s))',
        q, COALESCE(v_conname, 'chk_mov_origen'), v_list);
    END;
  END IF;

  -- ---------------------------------------------------------------------------
  -- 4) RLS (defensa en profundidad). El owner/pool bypassa RLS igual.
  -- ---------------------------------------------------------------------------
  EXECUTE format('ALTER TABLE %1$s.notas_credito_compra ENABLE ROW LEVEL SECURITY', q);
  EXECUTE format('ALTER TABLE %1$s.notas_credito_compra_items ENABLE ROW LEVEL SECURITY', q);

  IF acl IS NOT NULL THEN
    EXECUTE format('DROP POLICY IF EXISTS ncc_all ON %1$s.notas_credito_compra', q);
    EXECUTE format(
      'CREATE POLICY ncc_all ON %1$s.notas_credito_compra FOR ALL USING (%2$s(empresa_id)) WITH CHECK (%2$s(empresa_id))',
      q, acl);
    EXECUTE format('DROP POLICY IF EXISTS ncc_items_all ON %1$s.notas_credito_compra_items', q);
    EXECUTE format(
      'CREATE POLICY ncc_items_all ON %1$s.notas_credito_compra_items FOR ALL USING (%2$s(empresa_id)) WITH CHECK (%2$s(empresa_id))',
      q, acl);
  ELSE
    RAISE NOTICE 'neura_install_notas_credito_compra: sin puede_acceder_empresa en %, RLS activada sin policy (solo owner)', s;
  END IF;
END;
$$;

COMMENT ON FUNCTION public.neura_install_notas_credito_compra(text) IS
  'Crea idempotentemente notas_credito_compra + _items y extiende movimientos_inventario.origen en el schema dado (solo si tiene compras).';

-- -----------------------------------------------------------------------------
-- Alcance ACOTADO: SOLO el esquema operativo del cliente actual (`ferrecolor`).
-- No se instala en public / zentra_erp (plantillas) ni en ningún otro cliente,
-- siguiendo el precedente del gate de NC de ventas (commit af9371f). La función
-- interna, además, se auto-omite si el esquema no tiene tabla `compras`.
-- Para habilitarlo en otro cliente en el futuro, se agrega su esquema a esta lista
-- (o se ejecuta `SELECT public.neura_install_notas_credito_compra('<schema>')`).
-- -----------------------------------------------------------------------------
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT n.nspname AS sch
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relname = 'compras'
      AND c.relkind = 'r'
      AND n.nspname = 'ferrecolor'
  LOOP
    PERFORM public.neura_install_notas_credito_compra(r.sch);
    RAISE NOTICE '[notas_credito_compra] instalado en %', r.sch;
  END LOOP;
END;
$$;

NOTIFY pgrst, 'reload schema';
