-- ============================================================================
-- Devoluciones de ventas · Fase B (fiscal). ADITIVA E IDEMPOTENTE.
-- Solo schema ferrecolor. No modifica datos existentes.
--
-- Guarda el estado/saldo de la factura ERP ANTES de que la devolución la
-- anule/ajuste, para poder restaurarla con exactitud si la devolución se anula.
-- Solo se usa cuando la factura NO es un documento aprobado por la SET (esas no
-- se tocan automáticamente; queda el aviso de nota de crédito).
-- ============================================================================

ALTER TABLE ferrecolor.devoluciones_venta
  ADD COLUMN IF NOT EXISTS factura_estado_previo text;
ALTER TABLE ferrecolor.devoluciones_venta
  ADD COLUMN IF NOT EXISTS factura_saldo_previo numeric;
