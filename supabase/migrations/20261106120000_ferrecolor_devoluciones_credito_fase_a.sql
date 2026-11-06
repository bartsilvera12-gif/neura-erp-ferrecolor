-- ============================================================================
-- Devoluciones de ventas · Fase A (núcleo financiero). ADITIVA E IDEMPOTENTE.
-- Solo schema ferrecolor. No modifica datos existentes.
--
--  1) Permite el método de reembolso 'credito' (la diferencia de un cambio se
--     suma a la cuenta por cobrar en vez de cobrarse en caja).
--  2) Registra el ajuste real aplicado a la cuenta por cobrar (reducción/aumento)
--     para que la ANULACIÓN de la devolución lo revierta con exactitud.
-- ============================================================================

-- ── 1) Método 'credito' admitido en la cabecera de devolución ───────────────
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'ferrecolor.devoluciones_venta'::regclass
      AND conname = 'devoluciones_venta_metodo_check'
  ) THEN
    ALTER TABLE ferrecolor.devoluciones_venta DROP CONSTRAINT devoluciones_venta_metodo_check;
  END IF;
  ALTER TABLE ferrecolor.devoluciones_venta
    ADD CONSTRAINT devoluciones_venta_metodo_check
    CHECK (metodo_reembolso IS NULL OR metodo_reembolso IN ('efectivo','tarjeta','transferencia','credito'));
END $$;

-- ── 2) Ajuste real a la cuenta por cobrar (para reverso exacto en anulación) ─
-- Nullable y sin DEFAULT a propósito: las devoluciones previas quedan en NULL y
-- la anulación usa COALESCE(cxc_reduccion, total_devuelto) para conservar su
-- comportamiento histórico. Las nuevas devoluciones setean ambos valores.
ALTER TABLE ferrecolor.devoluciones_venta
  ADD COLUMN IF NOT EXISTS cxc_reduccion numeric;
ALTER TABLE ferrecolor.devoluciones_venta
  ADD COLUMN IF NOT EXISTS cxc_aumento numeric;
