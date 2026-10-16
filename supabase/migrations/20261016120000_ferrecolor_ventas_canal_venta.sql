-- ============================================================================
-- Canal de venta (Balcón / Pauta publicitaria) en ventas. ADITIVA E IDEMPOTENTE.
-- Solo schema ferrecolor (mono-sucursal).
--
-- Regla de comisión del cliente:
--   * balcon -> comisión NORMAL (escalas por lo vendido, % sobre la ganancia).
--   * pauta  -> 3% de la ganancia (fijo), al margen de las escalas por tramo.
--
-- Default 'balcon': todas las ventas existentes y las que no eligen canal quedan
-- como balcón, así nada del comportamiento actual cambia.
--
-- Todo IF NOT EXISTS: aditivo, no borra ni cambia columnas/datos existentes.
-- ============================================================================

ALTER TABLE ferrecolor.ventas
  ADD COLUMN IF NOT EXISTS canal_venta text NOT NULL DEFAULT 'balcon';

-- Valores permitidos (constraint idempotente).
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'ventas_canal_venta_chk'
      AND conrelid = 'ferrecolor.ventas'::regclass
  ) THEN
    ALTER TABLE ferrecolor.ventas
      ADD CONSTRAINT ventas_canal_venta_chk
      CHECK (canal_venta IN ('balcon', 'pauta'));
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS ventas_canal_venta_idx
  ON ferrecolor.ventas (empresa_id, canal_venta);

COMMENT ON COLUMN ferrecolor.ventas.canal_venta IS
  'Canal de la venta: balcon (comisión normal por escalas) | pauta (3% de la ganancia). Default balcon.';
