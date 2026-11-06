-- ============================================================================
-- Autorización de movimientos de stock. ADITIVA E IDEMPOTENTE. Solo schema ferrecolor.
--
-- Un vendedor que pide cambiar el stock (ajuste manual) deja el movimiento en
-- estado 'pendiente' y NO se aplica al stock hasta que un administrador lo
-- aprueba. El admin ve las solicitudes en Inventario → Movimientos y decide
-- Aprobar (se aplica el stock) o Rechazar (se descarta).
--
-- Default 'aprobado': TODOS los movimientos existentes y los del sistema
-- (compra, venta, transferencia, etc.) quedan como aprobados → sin cambios de
-- comportamiento. Solo los ajustes manuales pedidos por vendedores nacen
-- 'pendiente'.
-- ============================================================================

ALTER TABLE ferrecolor.movimientos_inventario
  ADD COLUMN IF NOT EXISTS estado text NOT NULL DEFAULT 'aprobado',
  ADD COLUMN IF NOT EXISTS solicitado_por uuid,
  ADD COLUMN IF NOT EXISTS solicitado_por_nombre text,
  ADD COLUMN IF NOT EXISTS aprobado_por uuid,
  ADD COLUMN IF NOT EXISTS aprobado_at timestamptz,
  ADD COLUMN IF NOT EXISTS rechazado_por uuid,
  ADD COLUMN IF NOT EXISTS rechazado_at timestamptz,
  ADD COLUMN IF NOT EXISTS rechazo_motivo text;

-- Valores de estado permitidos (constraint idempotente).
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'movimientos_inventario_estado_chk'
      AND conrelid = 'ferrecolor.movimientos_inventario'::regclass
  ) THEN
    ALTER TABLE ferrecolor.movimientos_inventario
      ADD CONSTRAINT movimientos_inventario_estado_chk
      CHECK (estado IN ('aprobado', 'pendiente', 'rechazado'));
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS movimientos_inventario_estado_idx
  ON ferrecolor.movimientos_inventario (empresa_id, estado);

COMMENT ON COLUMN ferrecolor.movimientos_inventario.estado IS
  'aprobado (afecta stock) | pendiente (solicitud de vendedor, no afecta hasta aprobar) | rechazado. Default aprobado.';
