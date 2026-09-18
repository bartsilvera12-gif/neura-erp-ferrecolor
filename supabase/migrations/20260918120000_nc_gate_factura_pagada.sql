-- Nota de crédito de corrección fiscal en facturas PAGADAS (saldo 0).
--
-- Antes: `nota_credito_aplicar_aprobacion_set` rechazaba la aprobación SET si
--   `p_monto > saldo` → una factura pagada (saldo 0) no podía recibir NC, aunque
--   fiscalmente corresponde (p. ej. anulación por datos del receptor).
-- Ahora: se topea por el TOTAL de la factura (`monto`) en vez del saldo, de modo que
--   una NC de anulación completa es válida en facturas pagadas, sin sobre-acreditar.
--   El saldo sigue clampeado con GREATEST(0, saldo - monto) (nunca negativo) y, si queda
--   en ~0, la factura pasa a estado 'Corregida NC'.
--
-- La función es genérica por esquema (opera sobre `p_data_schema`), así que el cuerpo es
-- idéntico en todos los tenants; solo cambia el esquema donde vive cada copia. El bloque
-- recorre todos los esquemas que tienen la función y la redefine (idempotente).

DO $mig$
DECLARE
  r record;
  ddl text;
BEGIN
  FOR r IN
    SELECT n.nspname AS sch
      FROM pg_proc p
      JOIN pg_namespace n ON n.oid = p.pronamespace
     WHERE p.proname = 'nota_credito_aplicar_aprobacion_set'
  LOOP
    -- replace() (no format()) porque el cuerpo contiene `%s` de los format() internos.
    ddl := replace($tmpl$
      CREATE OR REPLACE FUNCTION __SCH__.nota_credito_aplicar_aprobacion_set(
        p_data_schema text,
        p_nota_credito_id uuid,
        p_factura_id uuid,
        p_empresa_id uuid,
        p_monto numeric
      ) RETURNS void
        LANGUAGE plpgsql
        SECURITY DEFINER
        SET search_path TO 'pg_temp'
      AS $fn$
      DECLARE
        s text := btrim(p_data_schema);
        fq text := quote_ident(btrim(p_data_schema));
        saldo_act numeric;
        monto_fac numeric;
        otra uuid;
      BEGIN
        IF s IS NULL OR s = '' THEN
          RAISE EXCEPTION 'nota_credito_aplicar_aprobacion_set: schema vacío';
        END IF;

        EXECUTE format(
          'SELECT id FROM %s.nota_credito
           WHERE factura_id = $1 AND empresa_id = $2 AND estado_erp = ''aprobada'' AND id <> $3
           LIMIT 1',
          fq
        ) INTO otra USING p_factura_id, p_empresa_id, p_nota_credito_id;
        IF otra IS NOT NULL THEN
          RAISE EXCEPTION 'Ya existe otra nota de crédito aprobada para esta factura';
        END IF;

        EXECUTE format(
          'SELECT saldo, monto FROM %s.facturas WHERE id = $1 AND empresa_id = $2 FOR UPDATE',
          fq
        ) INTO saldo_act, monto_fac USING p_factura_id, p_empresa_id;

        IF saldo_act IS NULL THEN
          RAISE EXCEPTION 'Factura no encontrada';
        END IF;

        -- Tope por el TOTAL de la factura (no por el saldo): admite NC de corrección en
        -- facturas pagadas y evita sobre-acreditar por encima del monto facturado.
        IF p_monto > COALESCE(monto_fac, saldo_act) + 0.02 THEN
          RAISE EXCEPTION 'El monto de la NC (%) supera el total de la factura (%)', p_monto, COALESCE(monto_fac, saldo_act);
        END IF;

        EXECUTE format(
          'UPDATE %s.facturas SET
             saldo = GREATEST(0::numeric, saldo - $1),
             estado = CASE
               WHEN estado = ''Anulado'' THEN ''Anulado''
               WHEN GREATEST(0::numeric, saldo - $1) <= 0.0001 THEN ''Corregida NC''
               ELSE estado
             END,
             updated_at = now()
           WHERE id = $2 AND empresa_id = $3',
          fq
        ) USING p_monto, p_factura_id, p_empresa_id;

        EXECUTE format(
          'UPDATE %s.nota_credito SET estado_erp = ''aprobada'', updated_at = now()
           WHERE id = $1 AND empresa_id = $2 AND estado_erp <> ''anulada_borrador''',
          fq
        ) USING p_nota_credito_id, p_empresa_id;
      END;
      $fn$;
    $tmpl$, '__SCH__', quote_ident(r.sch));

    EXECUTE ddl;
  END LOOP;
END
$mig$;
