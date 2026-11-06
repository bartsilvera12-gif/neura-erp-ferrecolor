-- ============================================================================
-- Devoluciones de ventas · Fase C (#5). ADITIVA E IDEMPOTENTE. Solo ferrecolor.
--
-- Vincula la devolución con la factura ERP generada por el producto entregado en
-- un cambio. La factura se crea best-effort DESPUÉS de confirmar la devolución y
-- su DE electrónico se emite por el pipeline SIFEN existente.
-- ============================================================================

ALTER TABLE ferrecolor.devoluciones_venta
  ADD COLUMN IF NOT EXISTS cambio_factura_id uuid;

CREATE INDEX IF NOT EXISTS devoluciones_venta_cambio_factura_idx
  ON ferrecolor.devoluciones_venta (empresa_id, cambio_factura_id);
