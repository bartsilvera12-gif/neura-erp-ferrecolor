-- ============================================================================
-- Pagos a proveedores con PAGOS PARCIALES.
--
-- Hasta ahora una compra era "pagada" o "pendiente", todo o nada: no habia forma
-- de registrar un pago a cuenta. Esta tabla guarda cada pago por separado, y el
-- saldo de la compra pasa a derivarse (total - suma de pagos) en vez de ser una
-- bandera.
--
-- OJO con la clave: una compra son N filas en `compras` (una por producto) que
-- comparten `numero_control`. El pago se ata al numero_control, no al id de una
-- fila, porque se paga la factura entera, no un renglon.
-- ============================================================================

CREATE TABLE IF NOT EXISTS ferrecolor.pagos_proveedores (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  empresa_id           uuid NOT NULL,
  numero_control       text NOT NULL,
  proveedor_id         uuid,
  proveedor_nombre     text,
  fecha_pago           timestamptz NOT NULL DEFAULT now(),
  monto                numeric(18,2) NOT NULL CHECK (monto > 0),
  metodo_pago          text NOT NULL DEFAULT 'efectivo'
                         CHECK (metodo_pago IN ('efectivo','transferencia','tarjeta','cheque','otro')),
  referencia           text,
  observaciones        text,
  -- Egreso en caja, si el pago se descontó de una caja abierta.
  caja_movimiento_id   uuid,
  usuario_id           uuid,
  usuario_nombre       text,
  -- Anulacion logica: un pago mal cargado se anula, no se borra, para que el
  -- reporte del mes siga cuadrando con lo que se vio en su momento.
  anulado_at           timestamptz,
  anulado_por_nombre   text,
  anulado_motivo       text,
  created_at           timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS ix_pagprov_compra ON ferrecolor.pagos_proveedores (empresa_id, numero_control);
CREATE INDEX IF NOT EXISTS ix_pagprov_fecha  ON ferrecolor.pagos_proveedores (empresa_id, fecha_pago DESC);
CREATE INDEX IF NOT EXISTS ix_pagprov_prov   ON ferrecolor.pagos_proveedores (empresa_id, proveedor_id);

-- estado_pago suma 'parcial'. El CHECK viejo solo admitia pendiente|pagada.
DO $$
DECLARE v_con text;
BEGIN
  SELECT c.conname INTO v_con
    FROM pg_constraint c
    JOIN pg_class t ON t.oid = c.conrelid
    JOIN pg_namespace n ON n.oid = t.relnamespace
   WHERE n.nspname = 'ferrecolor' AND t.relname = 'compras' AND c.contype = 'c'
     AND pg_get_constraintdef(c.oid) ILIKE '%estado_pago%'
   LIMIT 1;
  IF v_con IS NOT NULL THEN
    EXECUTE format('ALTER TABLE ferrecolor.compras DROP CONSTRAINT %I', v_con);
  END IF;
  ALTER TABLE ferrecolor.compras
    ADD CONSTRAINT chk_compras_estado_pago
    CHECK (estado_pago IN ('pendiente','parcial','pagada'));
END $$;

-- ---------------------------------------------------------------------------
-- Backfill: las compras ya marcadas como pagadas no tienen pago registrado.
-- Sin esto, el reporte de pagos del mes saldria vacio para todo el historico y
-- las compras figurarian pagadas sin respaldo. Se crea UN pago por el total de
-- cada compra, fechado cuando se marco pagada.
-- ---------------------------------------------------------------------------
INSERT INTO ferrecolor.pagos_proveedores
  (empresa_id, numero_control, proveedor_id, proveedor_nombre, fecha_pago, monto,
   metodo_pago, observaciones, caja_movimiento_id)
SELECT c.empresa_id,
       c.numero_control,
       -- Postgres no tiene min()/max() para uuid: se toma el primer no nulo
       -- del grupo. Todas las filas de una compra comparten proveedor y
       -- movimiento de caja, asi que cualquiera sirve.
       (array_agg(c.proveedor_id) FILTER (WHERE c.proveedor_id IS NOT NULL))[1],
       MIN(c.proveedor_nombre),
       COALESCE(MAX(c.pagada_at), MAX(c.fecha)),
       SUM(c.total),
       'efectivo',
       'Pago registrado antes de habilitarse los pagos parciales',
       (array_agg(c.pago_caja_movimiento_id) FILTER (WHERE c.pago_caja_movimiento_id IS NOT NULL))[1]
  FROM ferrecolor.compras c
 WHERE c.estado_pago = 'pagada'
   AND c.anulada_at IS NULL
   AND NOT EXISTS (
     SELECT 1 FROM ferrecolor.pagos_proveedores p
      WHERE p.empresa_id = c.empresa_id AND p.numero_control = c.numero_control
   )
 GROUP BY c.empresa_id, c.numero_control
HAVING SUM(c.total) > 0;
