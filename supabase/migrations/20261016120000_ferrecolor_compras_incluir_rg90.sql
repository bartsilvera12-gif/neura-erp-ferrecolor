-- =============================================================================
-- Ferrecolor — Libro de Compras RG90: campo "Incluir en RG90" por compra.
--
--   * incluir_rg90 (boolean, default true): marca si el comprobante de compra
--     entra en el Libro de Compras RG90 (Sí/No). Default Sí.
--   * Es un flag PURAMENTE fiscal/informativo: NO afecta stock, costos ni ningún
--     cálculo operativo. Una compra marcada "No RG90" sigue impactando stock y
--     costos normalmente; solo se excluye del archivo/registro RG90.
--
-- Aditiva, idempotente. Solo schema ferrecolor.
-- =============================================================================

ALTER TABLE ferrecolor.compras
  ADD COLUMN IF NOT EXISTS incluir_rg90 boolean NOT NULL DEFAULT true;

COMMENT ON COLUMN ferrecolor.compras.incluir_rg90 IS
  'Incluir este comprobante de compra en el Libro de Compras RG90 (Sí/No, default Sí). Flag fiscal: NO afecta stock ni costos.';
