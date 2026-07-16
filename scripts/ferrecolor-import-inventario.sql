-- =============================================================================
-- Import inventario Ferrecolor desde Excel INVENTARIO FERRECOLOR 1407(1).xlsx
-- - Crea 21 categorías (INSERT ON CONFLICT).
-- - Inserta 1116 productos únicos por SKU con stock inicial.
-- - Defaults: precio_venta=0, costo=0, unidad_medida=UNIDAD, controla_stock=true.
-- =============================================================================

BEGIN;

-- Empresa Ferrecolor
DO $do$
DECLARE
  v_empresa_id uuid;
  v_cat_id uuid;
  v_ins int := 0;
BEGIN
  SELECT id INTO v_empresa_id FROM ferrecolor.empresas
  WHERE data_schema = 'ferrecolor' OR lower(nombre_empresa) = 'ferrecolor'
  LIMIT 1;
  IF v_empresa_id IS NULL THEN
    RAISE EXCEPTION 'No se encontró empresa Ferrecolor';
  END IF;

  -- Categorías (idempotente por (empresa_id, nombre))
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ADHESIVOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'AEROSOL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'AMANECER DECO', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ATLAS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BARNIZ OPAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BRILLALUX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'CUBRELUX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'DURAFRENT', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ENDUIDOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ENTONADOR COROB', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'GENERAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'HERRAMIENTAS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'IMPERMEABILIZANTE', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'LATEX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'LATEX PROFESIONAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'OPALATEX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'PINTURA PARA PISOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'PVC', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICO KILLING', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICO OPAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SUVINIL', true)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Categorías OK';

  -- Productos
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10418', 'FIJADOR PROF. 2X1 850 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10419', 'FIJADOR PROF. 2X1 3,6 LTS', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10423', 'COLAMAX 100 CC', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10424', 'COLAMAX 500 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10425', 'COLAMAX 1 LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10426', 'COLAMAX 5 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10427', 'ADHESIVO DE CONTACTO 125CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10428', 'ADHESIVO DE CONTACTO 850CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10429', 'ADHESIVO DE CONTACTO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10926', 'FIJADOR PROF. 2X1 18 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10954', 'SIKAFLEX 1A PLUS SELLADOR/ SELLANTE', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11019', 'ADHESIVO SUPERCIANO 20G', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11020', 'CINTA AISLANTE 19MMX5MTS NEGRO MILLION', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11021', 'CINTA AISLANTE 19MMX20MTS NEGRO MILLION', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11022', 'CINTA AISLANTE 19MMX10MTS NEGRO TIGRE', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11023', 'ADHESIVO INSTANTANEO LA GOTITA 2ML', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10515', 'ARGACAL 1LT (MUROCAL)', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10516', 'ARGACAL 5LTS (MUROCAL)', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10521', 'ARGAFLEX 1 LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10522', 'ARGAFLEX 5 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10527', 'ASFALTO LIQUIDO 18 LTS (NEGROLIN)', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10335', 'PINTURA EN AEROSOL ALUMINIO -1680', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10336', 'PINTURA EN AEROSOL ORO-188', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10337', 'PINTURA EN AEROSOL ALTA TEMPERATURA  NEGRO 1200', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10338', 'PINTURA EN AEROSOL ROJO-6', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10339', 'PINTURA EN AEROSOL NEGRO MATE-4', 0, 0,
    18.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10340', 'PINTURA EN AEROSOL NEGRO BRILLANTE-39', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10341', 'PINTURA EN AEROSOL BLANCO MATE-1007', 0, 0,
    25.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10342', 'PINTURA EN AEROSOL BLANCO BRILLANTE-40', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10343', 'PINTURA EN AEROSOL ALTA TEMPERATURA  ALUMINIO-1300', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10344', 'PINTURA EN AEROSOL AZUL-27', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10345', 'PINTURA EN AEROSOL MARRON-29', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10346', 'PINTURA EN AEROSOL GRIS-22', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10347', 'PINTURA EN AEROSOL VERDE-37', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10348', 'PINTURA EN AEROSOL CROMADO-3012', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10350', 'PINTURA EN AEROSOL ROJO ESCARLATA-23', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10351', 'PINTURA EN AEROSOL CELESTE-15', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10353', 'PINTURA EN AEROSOL ROJO FLUOR--1001', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10354', 'PINTURA EN AEROSOL NARANJA-31', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10356', 'PINTURA EN AEROSOL NARANJA FLUOR-1011', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10357', 'PINTURA EN AEROSOL VIOLETA-603', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10359', 'PINTURA EN AEROSOL ROSA-30', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10360', 'PINTURA EN AEROSOL ROSA FLUOR-1002', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10361', 'PINTURA EN AEROSOL AZUL FLUOR-1004', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10512', 'REMOVEDOR EN AEROSOL AMANECER', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10873', 'AEROSOL ANTIOXIDO NEGRO AMANECER', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10877', 'AEROSOL ANTIOXIDO GRIS AMANECER', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11260', 'AEROSOL GRAFITO MUNDIAL', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11261', 'AEROSOL AGRICOLA VERMELHO MASSEY MUNDIAL', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11262', 'AEROSOL AGRICOLA VERDE JHON DEERE MUNDIAL', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11398', 'AEROSOL BYP SUPER NEGRO BRILLANTE 400ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11399', 'AEROSOL BYP SUPER NEGRO MATE 400ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11400', 'AEROSOL BYP GRIS BRILLANTE 400ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11401', 'AEROSOL BYP BERMELLON BRILLANTE 400ML', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11402', 'AEROSOL BYP TRANSPARENTE BRILLANTE 400ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11403', 'AEROSOL BYP BLANCO BRILLANTE 400ML', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11404', 'AEROSOL BYP BLANCO MATE 400ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10187', 'CEMENTO QUEMADO GRIS 6KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10188', 'CEMENTO QUEMADO CEMENTO 6KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10201', 'DECO CLASSIC CHINA DOLL 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10205', 'DECO CLASSIC AMARILLO CLASSIC 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11108', 'LX. DECO SEMIBRILLO AFRICAM QUEEN 900CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10439', 'AMATECH FIBRADO BLANCO 1 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10440', 'AMATECH FIBRADO CERAMICA 1 KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10441', 'AMATECH FIBRADO GRIS 1 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10442', 'AMATECH FIBRADO VERDE 1 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10443', 'AMATECH FIBRADO BLANCO 4 KG', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10444', 'AMATECH FIBRADO CERAMICA 4 KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10445', 'AMATECH FIBRADO GRIS 4 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10446', 'AMATECH FIBRADO VERDE 4 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10447', 'AMATECH FIBRADO BLANCO 20 KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10449', 'AMATECH FIBRADO GRIS 20 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10450', 'AMATECH FIBRADO VERDE 20 KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10984', 'AMATECH CERAMICA 4 KG  SIN FIBRA', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10985', 'AMATECH  CERAMICA 20KG  SIN FIBRA', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11008', 'AMATECH BLANCO 4 KG SIN FIBRA', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11009', 'AMATECH BLANCO 1 KG SIN FIBRA', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11010', 'AMATECH BLANCO 20KG  SIN FIBRA', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11011', 'AMATECH CERAMICA 1 KG SIN FIBRA', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11012', 'AMATECH GRIS 20KG  SIN FIBRA', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11013', 'AMATECH GRIS 4 KG  SIN FIBRA', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11029', 'AMATECH ROJO TANINO 1 KG SIN FIBRA', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11030', 'AMATECH ROJO TANINO 4KG SIN FIBRA', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11031', 'AMATECH ROJO TANINO 20KG  SIN FIBRA', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10986', 'BRILLALUX FONDO ANTIOXIDO 850CC GRIS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10987', 'BRILLALUX FONDO ANTIOXIDO 850CC NEGRO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10988', 'BRILLALUX FONDO ANTIOXIDO 3.6LTS NEGRO', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10989', 'BRILLALUX FONDO ANTIOXIDO 3.6LTS GRIS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10906', 'RODILLO ANTIGOTAS ATLAS 5CM 321/5', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10907', 'RODILLO ANTIGOTAS ATLAS 15CM 321/15', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10908', 'RODILLO ANTIGOTAS ATLAS 23CM 321/100', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10909', 'RODILLO RESIMAX ATLAS 5CM 339/55A', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10910', 'RODILLO RESIMAX ATLAS 23CM 339/5A', 0, 0,
    17.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10911', 'RODILLO RESIMAX ATLAS 15CM 339/15A', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10912', 'ESPATULA PLAST LISA ATLAS 8CM 150/8', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10913', 'ESPATULA P/YESO INOX ATLAS AT6455/8 8"', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10914', 'ESPATULA INOX ATLAS AT6155/22 8"  20CM', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10915', 'ESPATULA  ACERO ATLAS 175/10 4´´', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10916', 'ESPATULA  ACERO ATLAS 6255/12  7,6', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10917', 'ESPATULA  ACERO ATLAS 6255/10  6,4', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10918', 'ESPATULA  ACERO ATLAS 12CM 175/12', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10919', 'ESPATULA  ACERO ATLAS 6255/16 10,2', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10920', 'BANDEJA ATLAS P/RODILLO 46CM AT1492P', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10921', 'RODILLO RENDEPLUS 46CM AT927/19', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11285', 'RODILLO RESIMAX ATLAS 9CM 339/9A', 0, 0,
    21.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10430', 'BARNIZ. MARINO BRILLANTE AMANECER 850 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10431', 'BARNIZ. MARINO BRILLANTE  AMANECER 3,6 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10432', 'BARNIZ. MARINO MATE AMANECER 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10433', 'BARNIZ. MARINO MATE AMANECER 3,6 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10436', 'BARNIZ. POLIURETANICO 250 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10437', 'BARNIZ. POLIURETANICO 850 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10438', 'BARNIZ. POLIURETANICO 3,6 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10464', 'BARNIZ AL AGUA (AMAFLEX) 1 LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10465', 'BARNIZ AL AGUA (AMAFLEX) 5 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10466', 'BARNIZ AL AGUA (AMAFLEX) 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10671', 'OPAL COPAL BARNIZ MATE 850CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10672', 'OPAL COPAL BARNIZ MATE 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10675', 'OPAL BARNIZ AQUALAC 500CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10677', 'OPAL COPAL BARNIZ CAOBA 850CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10678', 'OPAL BARNIZ CAOBA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10680', 'OPAL OPAL BARNIZ COPAL NATURAL  850CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10681', 'OPAL BARNIZ COPAL NATURAL  3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10218', 'BASE P ULTRAMATE 900 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10219', 'BASE M ULTRAMATE 900 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10220', 'BASE T ULTRAMATE 900 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10221', 'BASE P ULTRAMATE 3,3 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10222', 'BASE M ULTRAMATE 3,3 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10223', 'BASE T ULTRAMATE 3,3 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10224', 'BASE P ULTRAMATE 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10225', 'BASE M ULTRAMATE 17,4 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10226', 'BASE T ULTRAMATE 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10227', 'BASE P TERCIOPELO 900 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10228', 'BASE M TERCIOPELO 900 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10229', 'BASE T TERCIOPELO 900 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10230', 'BASE P TERCIOPELO 3,3 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10231', 'BASE M TERCIOPELO 3,3 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10232', 'BASE T TERCIOPELO 3,3 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10233', 'BASE P TERCIOPELO 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10234', 'BASE M TERCIOPELO 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10235', 'BASE T TERCIOPELO 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10236', 'BASE P SEMIBRILLO 900 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10237', 'BASE M SEMIBRILLO 900 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10238', 'BASE T SEMIBRILLO 900 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10239', 'BASE P SEMIBRILLO 3,3 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10240', 'BASE M SEMIBRILLO 3,3 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10241', 'BASE T SEMIBRILLO 3,3 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10242', 'BASE P SEMIBRILLO 17,4 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10243', 'BASE M SEMIBRILLO 17,4 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10244', 'BASE T SEMIBRILLO 17,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10963', 'DECO SEMIBRILLO  3,6LTS ROCK RIVER- COCOA CREAM 2804 -2797', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11287', 'ENDUIDO INTERIOR 5KG BLASCOR (MASA CORRIDA)', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11452', 'LACA NITRO BLANCO PURO BLASCOR 900ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11453', 'LACA NITRO NEGRO CADILAC BLASCOR 900ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11454', 'LACA NITRO NEGRO MATE BLASCOR 900ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11456', 'MASA PEQUEÑAS CORRECCIONES BLASCOR 180GR', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11457', 'BATIDA DE PIEDRA NEGRO BLASCOR 900ML', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11458', 'KIT BARNIZ PU 7800 BLASCOR 900ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11459', 'TINGIDOR MUEBLES  CASTANHO BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11460', 'TINGIDOR MUEBLES  CEDRO BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11461', 'TINGIDOR MUEBLES  CEREZA BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11462', 'TINGIDOR MUEBLES  IPE BLASCOR 225ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11463', 'TINGIDOR MUEBLES  MIEL BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11464', 'TINGIDOR MUEBLES  MOGNO BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11465', 'TINGIDOR MUEBLES  NARANJA BLASCOR 225ML', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11466', 'TINGIDOR MUEBLES  NEGRO BLASCOR 225ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10314', 'BRILLALUX GRAFITO GRIS CLARO 850', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10315', 'BRILLALUX GRAFITO GRIS CLARO 3.6', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10316', 'BRILLALUX GRAFITO GRIS OSCURO 850', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10317', 'BRILLALUX GRAFITO GRIS OSCURO 3.6', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10362', 'BRILLALUX BARNIZ COPAL NATURAL 250 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10363', 'BRILLALUX BARNIZ COPAL LAPACHO 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10364', 'BRILLALUX BARNIZ COPAL CEDRO 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10365', 'BRILLALUX BARNIZ COPAL CAOBA  250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10366', 'BRILLALUX BARNIZ COPAL NOGAL 250 CC', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10367', 'BRILLALUX BARNIZ COPAL NATURAL 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10368', 'BRILLALUX BARNIZ COPAL LAPACHO 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10369', 'BRILLALUX BARNIZ COPAL CEDRO 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10370', 'BRILLALUX BARNIZ COPAL CAOBA  850 CC', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10371', 'BRILLALUX BARNIZ COPAL NOGAL 850 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10372', 'BRILLALUX BARNIZ COPAL NATURAL 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10373', 'BRILLALUX BARNIZ COPAL LAPACHO 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10374', 'BRILLALUX BARNIZ COPAL CEDRO 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10375', 'BRILLALUX BARNIZ COPAL CAOBA  3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10376', 'BRILLALUX BARNIZ COPAL NOGAL 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10377', 'BRILLALUX BARNIZ COPAL NATURAL 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10378', 'BRILLALUX BARNIZ COPAL LAPACHO 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10379', 'BRILLALUX BARNIZ COPAL CEDRO 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10380', 'BRILLALUX BARNIZ COPAL CAOBA  18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10381', 'BRILLALUX BARNIZ COPAL NOGAL 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10420', 'SELLADOR P/ MAD. ECONOMICO 1 LT', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10693', 'BRILLALUX 2EN1 BLANCO  850 CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10703', 'BRILLALUX 2EN1 NEGRO 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10704', 'BRILLALUX 2EN1  MARRON COÑAC 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10705', 'BRILLALUX  2EN1 ALUMINIO 850 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10708', 'BRILLALUX 2EN1 GRIS 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10713', 'BRILLALUX 2EN1 GRIS ESPACIAL 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10720', 'BRILLALUX 2EN1 BLANCO  3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10724', 'BRILLALUX 2EN1 NEGRO 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10725', 'BRILLALUX 2EN1 MARRON COÑAC 3,6 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10726', 'BRILLALUX ALUMINIO 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10727', 'BRILLALUX 2EN1 GRIS 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11182', 'BRILLALUX  2EN1 GRIS ESPACIAL 3,6', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10922', 'CARPA NEGRA 2 X 100MTS DC GROUP', 0, 0,
    20.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10245', 'SINTETICO CUBRELUX AMARILLO 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10247', 'SINTETICO CUBRELUX VERDE INGLES 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10248', 'SINTETICO CUBRELUX AZUL FRANCIA 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10249', 'SINTETICO CUBRELUX GRIS 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10250', 'SINTETICO CUBRELUX MARRON TABACO 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10251', 'SINTETICO CUBRELUX CEDRO 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10252', 'SINTETICO CUBRELUX VERDE LIMON 250 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10253', 'SINTETICO CUBRELUX NEGRO  250 CC', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10254', 'SINTETICO CUBRELUX BLANCO 250 CC', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10255', 'SINTETICO CUBRELUX CELESTE  250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10256', 'SINTETICO CUBRELUX GRIS ESPACIAL 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10257', 'SINTETICO CUBRELUX NARANJA 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10258', 'SINTETICO CUBRELUX CERAMICA 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10259', 'SINTETICO CUBRELUX MARRON CLARO 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10260', 'SINTETICO CUBRELUX AZUL 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10261', 'SINTETICO CUBRELUX VERDE CLARO 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10262', 'SINTETICO CUBRELUX FUCSIA 250 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10263', 'SINTETICO CUBRELUX MARFIL 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10264', 'ANTIOXIDO CUBRELUX 3EN1 GRIS 250 CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10265', 'ANTIOXIDO CUBRELUX 3EN1 VERDE M. 250 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10266', 'ANTIOXIDO CUBRELUX 3EN1 NEGRO 250 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10267', 'SINTETICO CUBRELUX 3EN1 ANTIOX. BLANCO 250 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10268', 'SINTETICO CUBRELUX AMARILLO 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10269', 'SINTETICO CUBRELUX BERMELLON 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10270', 'SINTETICO CUBRELUX VERDE INGLES 850 CC', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10271', 'SINTETICO CUBRELUX AZUL FRANCIA 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10272', 'SINTETICO CUBRELUX GRIS 850 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10273', 'SINTETICO CUBRELUX MARRON TABACO 850 CC', 0, 0,
    16.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10274', 'SINTETICO CUBRELUX CEDRO 850 CC', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10275', 'SINTETICO CUBRELUX VERDE LIMON 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10276', 'SINTETICO CUBRELUX NEGRO  850 CC', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10277', 'SINTETICO CUBRELUX BLANCO 850 CC', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10278', 'SINTETICO CUBRELUX CELESTE  850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10279', 'SINTETICO CUBRELUX GRIS ESPACIAL 850 CC', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10280', 'SINTETICO CUBRELUX NARANJA 850 CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10281', 'SINTETICO CUBRELUX CERAMICA 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10282', 'SINTETICO CUBRELUX MARRON CLARO 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10283', 'SINTETICO CUBRELUX AZUL 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10284', 'SINTETICO CUBRELUX VERDE CLARO 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10285', 'SINTETICO CUBRELUX FUCSIA 850 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10286', 'SINTETICO CUBRELUX MARFIL 850 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10287', 'SINTETICO CUBRELUX  3EN1 ANTIOX. GRIS 850 CC', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10288', 'ANTIOXIDO CUBRELUX 3EN1 VERDE M. 850 CC', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10289', 'SINTETICO CUBRELUX  3EN1 ANTIOX. NEGRO 850 CC', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10290', 'SINTETICO CUBRELUX 3EN1 ANTIOX. BLANCO 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10291', 'SINTETICO CUBRELUX AMARILLO 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10292', 'SINTETICO CUBRELUX BERMELLON 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10293', 'SINTETICO CUBRELUX VERDE INGLES 3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10294', 'SINTETICO CUBRELUX AZUL FRANCIA 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10295', 'SINTETICO CUBRELUX GRIS 3,6 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10296', 'SINTETICO CUBRELUX MARRON TABACO 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10297', 'SINTETICO CUBRELUX CEDRO 3,6 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10298', 'SINTETICO CUBRELUX VERDE LIMON 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10299', 'SINTETICO CUBRELUX NEGRO  3,6 LTS', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10300', 'SINTETICO CUBRELUX BLANCO 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10301', 'SINTETICO CUBRELUX CELESTE  3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10302', 'SINTETICO CUBRELUX GRIS ESPACIAL 3,6 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10303', 'SINTETICO CUBRELUX NARANJA 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10304', 'SINTETICO CUBRELUX CERAMICA 3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10305', 'SINTETICO CUBRELUX MARRON CLARO 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10306', 'SINTETICO CUBRELUX AZUL 3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10307', 'SINTETICO CUBRELUX VERDE CLARO 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10308', 'SINTETICO CUBRELUX FUCSIA 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10309', 'SINTETICO CUBRELUX MARFIL 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10310', 'ANTIOXIDO CUBRELUX 3EN1 GRIS 3,6 LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10311', 'ANTIOXIDO CUBRELUX 3EN1 VERDE M. 3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10312', 'ANTIOXIDO CUBRELUX 3EN1 NEGRO 3,6 LTS', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10313', 'ANTIOXIDO CUBRELUX  3EN1 BLANCO 3,6 LTS', 0, 0,
    15.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11034', 'ANTIOXIDO CUBRELUX 3EN1 AZUL FRANCIA 3,6 LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11040', 'ANTIOXIDO CUBRELUX 3EN1 AZUL FRANCIA 850CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11041', 'ANTIOXIDO CUBRELUX 3EN1 COLORADO MATE 850CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11042', 'ANTIOXIDO CUBRELUX 3EN1 COLORADO MATE 3,6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10189', 'DECO CLASSIC WHITE 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10190', 'DECO CLASSIC ANTIQUE 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10191', 'DECO CLASSIC FROST 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10192', 'DECO CLASSIC CHINA DOLL 3,6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10193', 'DECO CLASSIC ROJO CARMIN 3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10194', 'DECO CLASSIC STORM 3,6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10195', 'DECO CLASSIC COSMIC 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10196', 'DECO CLASSIC AMARILLO CLASSIC 3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10197', 'DECO CLASSIC VERDE FOREST 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10198', 'DECO CLASSIC WHITE 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10200', 'DECO CLASSIC FROST 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10203', 'DECO CLASSIC STORM 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10136', 'DURAFRENT BLANCO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10143', 'DURAFRENT ROJO ELECTRICO 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10144', 'DURAFRENT ROJO TANINO 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10145', 'DURAFRENT TEJA 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10146', 'DURAFRENT VERDE MUSGO 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10147', 'DURAFRENT VERDE TENIS 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10927', 'DURAFRENT CEMENTO 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10928', 'DURAFRENT AZUL 3.6LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10929', 'DURAFRENT OCRE 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10931', 'DURAFRENT TEJA 3.6LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10932', 'DURAFRENT VERDE TENIS 3.6LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10933', 'DURAFRENT BLANCO 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10934', 'DURAFRENT VERDE MUSGO 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10935', 'DURAFRENT ROJO ELECTRICO 3.6LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10936', 'DURAFRENT NARANJA ESTIRENADA 3.6LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10937', 'DURAFRENT NEGRO 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10938', 'DURAFRENT GRIS 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10939', 'DURAFRENT AMARILLO 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10940', 'DURAFRENT BORDO 3.6LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10994', 'DURAFRENT CEMENTO 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10995', 'DURAFRENT OCRE 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10996', 'DURAFRENT AZUL 1LT', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10997', 'DURAFRENT TEJA 1LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10998', 'DURAFRENT ROJO TANINO 1LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10999', 'DURAFRENT VERDE TENIS 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11000', 'DURAFRENT VERDE MUSGO 1LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11001', 'DURAFRENT BLANCO 1LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11002', 'DURAFRENT NARANJA ESTERINADA 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11003', 'DURAFRENT ROJO ELECTRICO 1LT', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11004', 'DURAFRENT NEGRO 1LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11005', 'DURAFRENT GRIS 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11006', 'DURAFRENT AMARILLO 1LT', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11007', 'DURAFRENT BORDO 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11220', 'DURAFRENT ROJO TANINO 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10481', 'ENDUIDO CEMENTICIO GRIS AMANECER', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10482', 'ENDUIDO CEMENTICIO BLANCO AMANECER', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10484', 'ENDUIDO EXTERIOR PLAST AMANECER 15KG  (MASA ACRILICA)', 0, 0,
    29.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10486', 'ENDUIDO 1.6KG ACRILICO PREMIUM ENV BCO', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10487', 'ENDUIDO INTERIOR 15KG AMANECER (MASA CORRIDA)', 0, 0,
    61.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10489', 'ENDUIDO INTERIOR PROFESIONAL AMANECER 1.6KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10662', 'OPAL ENDUIDO CEMENTICIO OPAL GRIS 10KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10667', 'OPAL ENDUIDO INTERIOR OPAL 15KG (MASA CORRIDA)', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10668', 'OPAL ENDUIDO PLASTICO EXTERIOR OPAL 15KG (MASA ACRILICA)', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11024', 'YESO NACIONAL 2KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11107', 'OPAL ENDUIDO CEMENTICIO OPAL BLANCO 10KG', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11293', 'ENDUIDO INTERIOR 15KG BLASCOR (MASA CORRIDA)', 0, 0,
    26.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11294', 'ENDUIDO EXTERIOR 15KG BLASCOR (MASA ACRILICA)', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11295', 'KIT MASILLA PLASTICA BLASCOR 1KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11312', 'ENDUIDO INTERIOR 25KG BALDE BLASCOR (MASA CORRIDA)', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11313', 'ENDUIDO EXTERIOR 25KG BALDE BLASCOR (MASA ACRILICA)', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11334', 'ENDUIDO INTERIOR 15KG TINSUL (MASA CORRIDA)', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10386', 'ENTONADO PARA MADERA CAOBA 60 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10387', 'ENTONADO PARA MADERA CEDRO 60 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10388', 'ENTONADO PARA MADERA ROBLE  60 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10389', 'ENTONADO PARA MADERA NOGAL 60 CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10390', 'ENTONADO PARA MADERA CAOBA 240 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10391', 'ENTONADO PARA MADERA CEDRO 240 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10392', 'ENTONADO PARA MADERA ROBLE  240 CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10393', 'ENTONADO PARA MADERA NOGAL 240 CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10394', 'ENTONADORES 120 CC AMARILLO', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10395', 'ENTONADORES 120 CC BERMELLON', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10396', 'ENTONADORES 120 CC OCRE', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10397', 'ENTONADORES 120 CC V. CLARO', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10399', 'ENTONADORES 120 CC AZUL', 0, 0,
    22.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10400', 'ENTONADORES 120 CC CEDRO', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10401', 'ENTONADORES 120 CC SIENA', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10402', 'ENTONADORES 120 CC NEGRO', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10403', 'ENTONADORES 120 CC NARANJA', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10404', 'ENTONADORES 120 CC VIOLETA', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10405', 'ENTONADORES 120 CC MARRON', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10406', 'ENTONADORES 50CC AMARILLO', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10407', 'ENTONADORES 50CC BERMELLON', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10408', 'ENTONADORES 50CC OCRE', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10409', 'ENTONADORES 50CC V. CLARO', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10410', 'ENTONADORES 50CC V. OSCURO', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10411', 'ENTONADORES 50CC AZUL', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10412', 'ENTONADORES 50CC CEDRO', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10413', 'ENTONADORES 50CC SIENA', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10414', 'ENTONADORES 50CC NEGRO', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10415', 'ENTONADORES 50CC NARANJA', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10416', 'ENTONADORES 50CC VIOLETA', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10417', 'ENTONADORES 50CC MARRON', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10924', 'ENTONADOR MAQUINA', 0, 0,
    89.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11025', 'XADREZ EN POLVO NEGRO 500GR', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11026', 'XADREZ EN POLVO VERDE 500GR', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11027', 'XADREZ EN POLVO AMARILLO 500GR', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11028', 'PIGMENTO EN POLVO ROJO BAUTECH  500GR', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11117', 'PIGMENTO EN POLVO MARRON BAUTECH  500GR', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11118', 'PIGMENTO EN POLVO VERDE BAUTECH  500GR', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11119', 'PIGMENTO EN POLVO NEGRO BAUTECH  500GR', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10206', 'ENTONADOR BASE 1L ROSA HP ORG PNZ', 0, 0,
    3050.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10207', 'ENTONADOR BASE 1L ROJO JP ORG REZ', 0, 0,
    3838.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10208', 'ENTONADOR BASE 1L AMAR ORG YRZ', 0, 0,
    2419.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10209', 'ENTONADOR BASE 1L BLANCO WXZ', 0, 0,
    2469.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10210', 'ENTONADOR BASE 1L NARANJA HP ORG ARZ', 0, 0,
    3087.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10211', 'ENTONADOR BASE 1L AZUL PTHALO BNZ', 0, 0,
    2558.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10212', 'ENTONADOR BASE 1L VERDE PTHALO GPZ', 0, 0,
    2566.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10213', 'ENTONADOR BASE 1L NEGRO NNZ', 0, 0,
    2133.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10214', 'ENTONADOR BASE 1L AMAR OXIDO YXZ', 0, 0,
    4629.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10215', 'ENTONADOR BASE 1L ROJO OXIDO RXZ', 0, 0,
    3538.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10216', 'ENTONADOR BASE 1L ROJO ORG RLZ', 0, 0,
    3750.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10217', 'ENTONADOR BASE 1L AMAR HP ORG YQZ', 0, 0,
    1941.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10495', 'ESMALTE EPOXI BLANCO 2,4 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10496', 'ESMALTE EPOXI CONV. EPOXI 0,800LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10497', 'DILUYENTE EPOXI', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11035', 'ESMALTE EPOXI TRANSPARENTE 2,4 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11339', 'ESMALTE EPOXI GRIS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10246', 'SINTETICO CUBRELUX BERMELLON 250 CC', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10349', 'PINTURA EN AEROSOL TRANSPARENTE-190', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10352', 'PINTURA EN AEROSOL AMARILLO-41', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10355', 'PINTURA EN AEROSOL VERDE FLUOR-1003', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10358', 'PINTURA EN AEROSOL AMARILLO FLUOR-1005', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10398', 'ENTONADORES 120 CC V. OSCURO', 0, 0,
    17.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10421', 'DILUYENTE LACA 1 LT 24600', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10507', 'THINNER ACRILICO FINO 5 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10513', 'ANTIOX AEROSOL GRIS', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10514', 'ANTIOX AEROSOL NEGRO', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10518', 'ACIDO MURIATICO 5 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10736', 'PINCEL TIGRE AZUL REF 728 1"', 0, 0,
    47.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10737', 'PINCEL TIGRE AZUL REF 728 1 -1/2''''''''', 0, 0,
    20.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10738', 'PINCEL TIGRE AZUL REF 728 2''''''''', 0, 0,
    51.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10739', 'PINCEL TIGRE AZUL REF 728 2- 1/2''''''''', 0, 0,
    31.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10740', 'PINCEL TIGRE AZUL REF 728 3''''''''', 0, 0,
    43.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10741', 'PINCEL TIGRE RF518 MARRON 1 1/2"', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10742', 'PINCEL TIGRE RF518 MARRON 2"', 0, 0,
    42.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10743', 'PINCEL TIGRE RF518 MARRON 3"', 0, 0,
    24.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10744', 'PINCEL TIGRE RF 518 MARRON 2 1/2"', 0, 0,
    33.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10745', 'PINCEL TIGRE AZUL 728 4"', 0, 0,
    38.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10746', 'PINCEL TIGRE AZUL 728 3/4"', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10747', 'PINCEL TIGRE AZUL 728 1/2"', 0, 0,
    30.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10748', 'KIT ECONOMICO ANTIGOTEO', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10749', 'BANDEJA DE PINTURA PLASTICA TRUPER', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10750', 'RODILLO ANTIGOTEO TIGRE 23CM', 0, 0,
    23.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10754', 'CINTA SEPARADORA PAPEL TIGRE 18X50', 0, 0,
    33.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10756', 'CINTA  SEPARADORA PAPEL TIGRE 48X50  REF 2151-050', 0, 0,
    18.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10757', 'ANTIHUMEDAD 3,6LT IMPERM', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10758', 'LIJA MADERA Y PARED N°60 A257', 0, 0,
    50.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10759', 'LIJA MADERA Y PARED N°80 A257', 0, 0,
    47.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10760', 'LIJA MADERA Y PARED N°100 A257', 0, 0,
    47.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10761', 'LIJA MADERA Y PARED N°120 A257', 0, 0,
    40.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10762', 'LIJA MADERA Y PARED N°150 A257', 0, 0,
    39.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10763', 'LIJA AL AGUA N°60 T277', 0, 0,
    96.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10764', 'LIJA AL AGUA N°80 T277', 0, 0,
    33.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10765', 'LIJA AL AGUA N°100 T277', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10766', 'LIJA AL AGUA N°120 T277', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10767', 'LIJA AL AGUA N°150 T277', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10768', 'LIJA AL AGUA N°180 T277', 0, 0,
    32.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10769', 'LIJA AL AGUA N°220 T277', 0, 0,
    47.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10770', 'LIJA AL AGUA N°240 T277', 0, 0,
    141.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10771', 'LIJA AL AGUA N°400 T277', 0, 0,
    150.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10772', 'LIJA AL AGUA N°500 T277', 0, 0,
    148.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10773', 'LIJA AL AGUA N°600 T277', 0, 0,
    141.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10776', 'VARIOS', 0, 0,
    9982.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10778', 'RODILLO P/ TEXTURA CONDOR10CM RF969', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10779', 'RODILLO P/TEXTURA 23CM ROMA', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10780', 'RODILLO PARA TEXTURA FINA ATLAS 23CM RF110/750', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10781', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 23CM RF1374', 0, 0,
    78.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10782', 'RODILLO ANTIGOTAS TIGRE 90MM RF1377 PROFESIONAL SUPERF', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10784', 'RODILLO DE ESPUMA TIGRE 40MM  RF1345', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10785', 'RODILLO DECORATIVO P/ TEXTURA MEDIA 23CM TIGRE REF1352', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10786', 'RODILLO DE LANA TIGRE PROFESIONAL 23CM RF 1322', 0, 0,
    20.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10787', 'RODILLO PROF MICROFIBRA TIGRE 230MM RF1336', 0, 0,
    37.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10789', 'LLANA PLASTICA P/ TEXTURA 15X26  RF325CASTOR', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10790', 'LLANA PLASTICA CORRUGADA 15X26 CASTOR 024', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10791', 'REMOVEDOR DE PINTURAS Y ADHESIVO CERAMICO TRUPER 13MM', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10792', 'LLANA PLASTICA CORRUGADO 18X30 RF121', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10793', 'LLANA LISA 10X35 RF510 CASTOR', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10794', 'LLANA P/ EFECTOS DECORATIVOS PROFESIONAL ATLAS 236X100CM', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10795', 'LLANA ACERO LISA 12X35CM ATLAS GRANDE', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10796', 'LLANA ACERO LISA C/ FEC 12X25CM ATLAS', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10797', 'LIJADORA PLASTIICA 8X21 RF 321 CASTOR', 0, 0,
    28.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10798', 'LLANA PLASTICA P/ TEXTURA 27X14 ATLAS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10799', 'APLICADOR DE  MASA 7X13 RF095 CASTOR', 0, 0,
    21.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10800', 'ESPATULA MEZCLADORA DE PINTURA 010X60CM GRANDE ATLAS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10801', 'ESPATULA MEZCLADORA DE PINTURA 08X40CM ATLAS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10802', 'ESPATULA GOMA PASTINA 9.5X13.5X1.2 RF098 CASTOR', 0, 0,
    239.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10803', 'LLANA DENTADA 10X35 RF511 CASTOR', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10804', 'GUANTE HILO C/ LATEX NARANJA XL FASCY', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10805', 'GUANTE HILO C/ PUNTOS PVC FASCY', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10806', 'GUANTE FASCY MECANICO NEGRO XL', 0, 0,
    29.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10807', 'GUANTE FASCY LATEX M', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10808', 'GUANTE FASCY LATEX L', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10809', 'GUANTE FASCY LATEX XL', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10810', 'MASCARA RESPIRATORIA FASCY 1 FILTRO', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10811', 'MECHA HSS FY 4MM FASCY', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10812', 'MECHA HSS FY 6MM  FASCY', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10813', 'MECHA HSS FY 8MM FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10814', 'CINTA EMBALAJE TRANSPARENTE 48MM 100M FASCY CT100', 0, 0,
    15.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10815', 'CINTILLO NYLON NEGRO 3,6X150MM CN236150 FASCY', 0, 0,
    170.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10816', 'MECHA HSS FY 10MM FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10817', 'CINTILLO NYLON NEGRO 4,8X200MM CN248200 FASCY', 0, 0,
    200.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10818', 'CINTILLO NYLON NEGRO 4.8X250MM CN248250 FASCY', 0, 0,
    100.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10819', 'CINTILLO NYLON NEGRO 4,8X300MM CN248300 FASCY', 0, 0,
    194.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10820', 'CINTILLO NYLON NEGRO 4,8X350MM CN248350 FASCY', 0, 0,
    184.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10821', 'CINTILLO NYLON NEGRO 4,8X400MM CN248400 FASCY', 0, 0,
    200.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10822', 'CINTA METRICA FASCY FIBRA 30MM CM0130', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10823', 'CINTA METRICA FASCY FIBRA 20MM CM0120', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10824', 'CUTTER FASCY MASTER ALUMNIO 18MM CUT181', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10825', 'LINEA PINTOR 30M FASCY LP31 (CHOCLA)', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10826', 'CINTA PAPEL PARA YESO 50MM 150M FASCY CT322', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10827', 'CINTA PAPEL PARA YESO 50MM 50M FASCY CT320', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10828', 'CINTA METRICA FASCY CM2032 GOMA 3MX19MM', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10829', 'CINTA MALLA YESO FY AUTOADHESIV 50MM 90M   CT311', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10830', 'CINTA METRICA FASCY CM2053 GOMA 5MX25MM', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10831', 'CINTA ADVERTENCIA  70MM X 200MTS  CT212 FASCY', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10832', 'DISCO FLAP ALUM OXIDAD 115MM #80 D3480 FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10833', 'DISCO FLAP ALUM OXIDAD 115MM #100 D3410 FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10834', 'CINTA ADVERTENCIA  PRECAUCION 70MMX 200MT  CT242 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10835', 'DISCO SIERRA TCT MADERA 110MM 40T D111040 FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10836', 'CINTA RACING GRIS 48MMX10MT  CT312 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10837', 'DISCO SIERRA TCT MADERA 110MM 24T D11024 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10838', 'LAPIZ CARPINTERO 7° LC72 FASCY', 0, 0,
    21.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10839', 'DISCO DIAM PORCELANATO FINO 110MM  D147 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10840', 'EXTENSOR PARA RODILLO  ALUMNIO 3MT EXT203 FASCY', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10841', 'EXTENSOR PARA RODILLO  METAL 3MT EXT204 FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10842', 'DISCO DIAM CONTINUO 110MM  D141 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10843', 'EXTENSOR PARA RODILLO  METAL 2MT EXT202 FASCY', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10844', 'DISCO DIAM SEGMENTADO 110MM  D140 FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10845', 'EXTENSOR PARA RODILLO  ALUMNIO 2MT EXT201 FASCY', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10846', 'DISCO DIAM SEGMENTADO 180MM  D170 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10847', 'PISTOLA P/SILICONA EN TUBO WARRIOR 9° PS91 FASCY', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10848', 'PISTOLA P/SILICONA EN TUBO 9° PS92 FASCY', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10849', 'DISCO DIAM MULTIUSO 110MM  D146 FASCY', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10850', 'LENTE PROTECTOR FX TRANSPARENTE PP113 FASCY', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10851', 'DISCO DIAM  PARA VIDRIO 110MM  D149 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10852', 'SIERRA COPA TCT CONCRETO 55MM EN KIT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10853', 'SIERRA COPA TCT CONCRETO 65MM EN KIT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10854', 'MECHA CONCRETO 06X100MM MC006 FASCY', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10855', 'MECHA CONCRETO 08X120MM MC008 FASCY', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10856', 'MECHA CONCRETO 10X120MM MC010 FASCY', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10857', 'MECHA CONCRETO 12X150MM MC012 FASCY', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10858', 'PISTOLA DE PINTAR FASCY 1000CC 1.8MM H1000W FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10859', 'PISTOLA DE PINTAR FASCY 600CC 1.4MM H827W FASCY', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10860', 'PISTOLA DE PINTAR FASCY 400CC 1.5MM H400W FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10861', 'PISTOLA DE PINTAR FASCY 750CC VD90 FASCY', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10862', 'NEUM PISTOLA PULVERIZADOR C/ MANGUERA WG20 FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10863', 'NEUM PISTOLA PULVERIZADOR C/ BOTON WG18 FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10864', 'NEUM PISTOLA PULVERIZADOR C/ GATILLO WG19 FASCY', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10885', 'EXTENSOR PARA RODILLO  TRUPER 2,7MTS 19213', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10886', 'EXTENSOR PARA RODILLO  TRUPER 2MTS 19216', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10888', 'BROCHA 165X58CM RF5100 MAX', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10889', 'BROCHA 180X75 RF 4810 MAX', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10890', 'DESENGRIPANTE CHEMICOLOR 300ML', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10891', 'SILICONA PU40', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10925', 'SOPORTE RODILLO 46CM ATLAS AT360/46', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10941', 'RODILLO DE LANA ANTIGOTEO CON MANGO 23CM RF1376', 0, 0,
    54.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10943', 'RODILLO DE ESPUMA TIGRE RF 1341-5CM', 0, 0,
    36.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10944', 'RODILLO DE ESPUMA TIGRE RF 1341-9CM ECONOMICO', 0, 0,
    46.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10945', 'RODILLO DE ESPUMA TIGRE RF 1341-15CM', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10946', 'RODILLO LANA TIGRE RF 1346-9CM', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10947', 'RODILLO LANA TIGRE RF 1346-15CM', 0, 0,
    23.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10948', 'RODILLO SINT ANTIGOTAS TIGRE RF 1377-9 ECON  SUPERFICIE LISA', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10949', 'RODILLO SINT ANTIGOTAS TIGRE RF 1377-15 ECONOMICO', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10950', 'RODILLO ESPUMA TIGRE 1330-23CM', 0, 0,
    25.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10951', 'BROCHA TIGRE BASE PLAST 1199-2', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10952', 'BROCHA TIGRE BASE PLAST 1199-3', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10965', 'ESTOPA 200GR', 0, 0,
    26.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10966', 'ESTOPA 400GR', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10967', 'ESTOPA 1KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10968', 'SILICONA ACETICA 50G TRANSPARENTE TEKBOND', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10969', 'SILICONA ACETICA 280G TRANSPARENTE TEKBOND', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10970', 'SILICONA ACETICA 280G NEGRO TEKBOND', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10971', 'SILICONA ACETICA 280G BLANCO TEKBOND', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10972', 'CINTA DECORATIVA 12MMX10M 9UNID EUROGEL', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10973', 'RODILLO FELPA ARTISAN 1/2 9° FARBE', 0, 0,
    75.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10974', 'TELA GEOTEXTIL VP05 (TELA VINILICA TIPO ESPUMA) X METRO', 0, 0,
    30.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10976', 'TELA TIPO BIDIN SUPREMA (TELA VINILICA) X ROLLO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10977', 'TELA GEOTEXTIL VP05 (TELA VINILICA TIPO ESPUMA) X ROLLO', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10978', 'ESTOPA NACIONAL', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10979', 'PISTOLA SATE TK887', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10990', 'RODILLO PINTOR ESPUMA 23 CM AMANECER', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10991', 'CINTA SEPARADORA PAPEL RAPIFIX 18X50MM', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10992', 'CINTA  SEPARADORA PAPEL 24MMX50M TIGRE   REF 2151-050', 0, 0,
    51.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10993', 'CINTA PARA PEGAR 18MMX5 UYUSTOOLS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11032', 'MEZCLADOR P/ PINTURA DE MADERA TIGRE', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11043', 'SELLA GRIETA TKK BLANCO', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11105', 'CUBRETODO PLASTICO MEDIO 4X5M  20M2 PENTRILO', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11116', 'ANTIOXIDO ECONOMICO 1L', 0, 0,
    20.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11125', 'PAVIMENTO AMARILLO 18 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11126', 'CAL EN PASTA 4KG PINTU PLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11129', 'SACA MANCHAS PISO TITAN CLEAN 5LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11133', 'SACA MANCHAS PISO TITAN CLEAN 1L', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11134', 'SOLUPAN', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11140', 'ULTRA PISO DE BLASCOR 3,6LTS GRIS OSCURO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11141', 'ULTRA PISO DE BLASCOR 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11144', 'RECUBRIPLAST CUBRE TODO 900 GR SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11145', 'RECUBRIPLAST CUBRE TODO 3.6B KG SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11146', 'RECUBLOCK CIMIENTOS BOLSA 5KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11147', 'MASILLA PARA PLACAS DE YESO 5 KG SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11148', 'RECUPLAST TECHOS BLANCOS 3.6 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11149', 'RECUPLAST TECHOS BLANCOS 18 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11150', 'RECUPLAST TECHOS TEJA 3.6 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11151', 'RECUPLAST TECHOS TEJA 18 LTS SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11152', 'RECUPLAST TECHOS GRIS 3.6 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11153', 'RECUPLAST TECHOS GRIS 18 LTS SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11154', 'SINTEPLAST PISCINA CELESTE 3.6 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11155', 'PISOS Y BORDES ATERMICOS PISCINA BLANCO 4 LTS SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11156', 'RECUPLAST GRIETAS Y JUNTAS BLANCOS 1 KG SINTEPLAST', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11157', 'RECUPLAST GRIETAS Y JUNTAS BLANCOS 5 KG SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11158', 'POLACRIN MEMBRANA ALUMINIZADA 4 KG SINTEPLAST', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11159', 'RECUBLOCK ANTIHUMENDAD 1 LTS SINTEPLAST', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11166', 'THINNER BLASCOR 010 1LT', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11167', 'THINNER BLASCOR 020 1LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11174', 'ESPATULA ACERO TIGRE 2151-3', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11175', 'ESPATULA ACERO TIGRE 2151-4', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11176', 'ESPATULA ACERO TIGRE 2151-5', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11177', 'BALDE PLAST. TIGRE PINTURA 1309', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11178', 'EXTENSOR TELESCOPICO TIGRE 5MTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11183', 'PISOS Y BORDES ATERMICOS PISCINA BLANCO 10 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11194', 'TORNILLO P/ PVC', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11197', 'SILICONA PU40  SILOC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11198', 'ESPUMA EXPANSIVA CHEMICOLOR', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11200', 'MASILLA MULTIUSO 5KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11201', 'MASILLA MULTIUSO 25KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11203', 'SOPORTE P/ LIJA MANUAL TIGRE PRO 23X8CM', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11204', 'RODILLO LANA CARNEIRO ATLAS 23CM 328/22', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11212', 'ESQUINERO PARA PVC', 0, 0,
    992.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11213', 'REPUESTO PISTOLA FASCY 400CC', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11215', 'PERFIL Z', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11216', 'COSTO DE ENTREGA', 0, 0,
    88.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11218', 'RECUBLOCK ANTIHUMENDAD 3.6 LTS SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11221', 'CINTA ASFALTICA 10X10', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11222', 'CINTA ASFALTICA 20X10', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11223', 'HIDROLAVADORA DE ALTA PRESION', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11224', 'THINNER 4L 020 BLASCOR', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11225', 'SR GRIS MUNSELL 3,6LTS BLASCOR', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11227', 'PENTRILO PLASTICO C/CINTA 20MX260CM 9625', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11228', 'PENTRILO PLASTICO C/CINTA 20MX35CM 9620', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11229', 'PENTRILO PLASTICO C/CINTA 20MX60CM 9621', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11230', 'PENTRILO PLASTICO C/CINTA 20MX120CM 9623', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11231', 'LLANA ACERO INOX NIVELOPRO 60CM AT933/60', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11232', 'LLANA ACERO INOX NIVELOPRO 80CM AT933/80', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11233', 'LLANA ACERO INOX NIVELOPRO 40CM AT933/40', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11234', 'LLANA ACERO INOX NIVELOPRO 25CM AT933/25', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11235', 'ANTI PIEDRA BLASCOR 900ML', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11255', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 9CM RF1375', 0, 0,
    20.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11256', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 15CM RF1375', 0, 0,
    19.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11269', 'ARGAMASA ACI', 0, 0,
    91.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11274', 'BARNIZ IMBUIA BLASCOR', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11275', 'BARNIZ NATURAL BLASCOR', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11276', 'CINTA SEPARADORA CREPE EUROCEL 24MMX50MM', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11277', 'CINTA SEPARADORA CREPE EUROCEL 36MMX50MM', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11278', 'CINTA SEPARADORA CREPE EUROCEL 25MMX50MM', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11279', 'CINTA SEPARADORA CREPE EUROCEL 50MMX50MM', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11280', 'CEMENTO QUEMADO MULTISUPERFICIES ELEFANTE 5KG SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11281', 'CEMENTO QUEMADO MULTISUPERFICIES ARENA 5KG SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11282', 'CEMENTO QUEMADO MULTISUPERFICIES CHOCOLATE 5KG SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11283', 'MICROCEMENTO GRIS CLARO 20KG SINTEPLAST', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11284', 'MEZCLADOR ATLAS PLASTICO AT176/3', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11297', 'UNION PVC', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11298', 'SELLADOR PIGMENTADO BLASCOR 3.6LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11299', 'SELLADOR PIGMENTADO BLASCOR 18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11301', 'ESMALTE SR BLASCOR NEGRO CADILAC 900ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11302', 'ESMALTE SR BLASCOR BLANCO 900ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11303', 'SELLA TODO BLASCOR 900ML', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11304', 'ESMALTE BASE AGUA EFECTO GOLD BLASCOR 900ML', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11306', 'BANDEJA DE PINTURA PLASTICA TIGRE 2304-23', 0, 0,
    43.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11307', 'AGUARRAS SOLCOR 1LT', 0, 0,
    24.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11328', 'SR GRIS SCANIA 3,6LTS BLASCOR', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11329', 'THINNER 4L 010 BLASCOR', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11330', 'BOTA', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11331', 'ACEITE DE LINO', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11332', 'FIJADOR DE PIEDRAS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11333', 'TEXTURA GRAFIATO BLASCOR BLANCO 15KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11335', 'JARRA ELECTRICA SUPREMA', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11336', 'MASA NIVELADORA BLASCOR DE 3KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11337', 'LED REFLECTOR SLIM 50W BIV 6500K AVANT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11338', 'LED REFLECTOR SLIM 150W BIV 6500K AVANT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11358', 'VEDACALHA 280GR ADHESIVO', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11443', 'CEMENTO QUEMADO SUVINIL TUNEL DE CONCRETO 6KG', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11444', 'PULVERIZADOR 2L RIO NARANJA', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11451', 'MASA PEQUEÑAS CORRECCIONES SHERWIN LAZZUDUR 200GR', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11455', 'THINNER BLASCOR 030 1LT', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11467', 'SENHA SUVINIL  FOSCO D268 GALLETA CHAMPANGNE', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11033', 'PISTOLA P/ PINTAR FY TEXTURADO 5L', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11102', 'RODILLO  P/  TEXTURA FINA 110/75 23CM ATLAS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11103', 'RODILLO P/  TEXTURA  RUSTICA  AT1155/5 5CM  ATLAS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11104', 'RODILLO P/  TEXTURA  RUSTICA  11550 23CM  ATLAS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11120', 'CINTA METRICA 3MX16MM KOMELON', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11121', 'CINTA METRICA 5MX19MM KOMELON', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11122', 'CINTA METRICA 8MX25MM KOMELON', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11123', 'DISCO CORTE METAL 115X1,0 NORTON STANDAR', 0, 0,
    70.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11124', 'DISCO CORTE FINO 115X1,0 NORTON BNA12', 0, 0,
    43.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11130', 'RODILLO ESPUMA  ATLAS 23CM 406/230 POLYESTER', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11131', 'RODILLO ESPUMA  ATLAS 15CM 406/15A POLYESTER', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11132', 'RODILLO ESPUMA  ATLAS 5CM 406/5A POLYESTER', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11202', 'KIT DE PINTURA ATLAS AT2004', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11246', 'ESPATULA ACERO MULTIUSO REF 2320 2" 1/2', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11247', 'ESPATULA TIGRE PRO REF 2330 -00', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11248', 'TIGRE PRO LLANA ALISADORA 2190 - 25CM', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11249', 'TIGRE PRO LLANA ALISADORA 2190 - 40CM', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11250', 'TIGRE PRO LLANA ALISADORA 2190 - 60CM', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11251', 'TIGRE PRO EXTENSOR 0.9 MTS 1309 -01', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11252', 'TIGRE PRO EXTENSOR 1.5 MTS 1309 -15', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11253', 'TIGRE PRO EXTENSOR 2.7 MTS 1309 -27', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11254', 'CEPILLO DE ACERO TIGRE 1777 -04', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11257', 'TIGRE PRO RECORTE C/ REFIL 2137', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11258', 'TIGRE PRO SOPORTE LLANA 2160', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11259', 'TIGRE PRO BALDE DE MANO 2LT 2309-01', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11325', 'BYP ESCURRIDOR EPOXI', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11326', 'BYP RODILLO DE PUAS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11327', 'BYP ZAPATO DE PICO TIPO PLANTILLA', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11340', 'RODILLO DRYWALL 23CM AT321/80 ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11341', 'CINTA P/ DRYWALL 50X45 AT2945', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11342', 'RODILLO TEXTURA RUSTICA AT1155/10SR ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11343', 'RODILLO NIVELO PRO AT1122/23 ATLAS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11344', 'MANGO AJUSTABLE AT750/80 ATLAS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11345', 'PAD P/ RECORTE AT751/70 ATLAS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11346', 'SOPORTE P/LIJA 100/2 ATLAS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11347', 'SOPORTE P/LIJA 100/4 ATLAS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11348', 'SOPORTE PARA LIJA P/EXTENSOR 100/3 ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11349', 'TACO PARA LIJA 100/1 ATLAS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11350', 'SOPORTE P/ NIVELOPRO AT9933 ATLAS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11351', 'EXTENSOR  P/ PINCEL AT179 ATLAS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11352', 'PINCEL ANGULAR CORTO 2´´ AT416/5ES ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11353', 'PINCEL ANGULAR  2´ 1/2  AT416/6AN ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11354', 'PINCEL ANGULAR  3'''''''' AT416/ 7AN ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11355', 'MANGO JAULA AT400 / 230 SR  ATLAS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11356', 'MANGO 330 / 23 R  ATLAS  ROSCA', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11357', 'PAD MANGO AJUSTABLE AT750/80 ATLAS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11360', 'RODILLO BYP 10" COVER MAX PLUS ACRIL 3/4', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11142', 'HIDROEPOXI BRILLANTE BLANCO 900 CC SINTEPLAST', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11143', 'HIDROEPOXI BRILLANTE GRIS ELEFANTE 3.6 LTS SINTEPLAST', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11217', 'HIDROEPOXI BRILLANTE ELEFANTE 900 CC SINTEPLAST', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11219', 'HIDROEPOXI BRILLANTE BLANCO3.6 LTS SINTEPLAST', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10448', 'AMATECH FIBRADO CERAMICA 20 KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10451', 'GOMA LIQUIDA GRIS 1.2KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10452', 'GOMA LIQUIDA GRIS 5KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10453', 'GOMA LIQUIDA GRIS 21KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10454', 'GOMA LIQUIDA BLANCO 1.2KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10455', 'GOMA LIQUIDA BLANCO 5KG', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10456', 'GOMA LIQUIDA BLANCO 21KG', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10457', 'ANTIHUMEDAD 850LT IMPERM', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10467', 'DURAFRENT LADRILLOS 3,6 LTS', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10468', 'DURAFRENT LADRILLOS 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10523', 'HIDROFUGO AMANECER 1LT ( CERECITA)', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10524', 'HIDROFUGO 3,6LTS ( CERECITA)', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10525', 'ASFALTO LIQUIDO 1 LT (NEGROLIN)', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10669', 'TECHOPAL FIBRADO CERAMICO 20KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10670', 'TECHOPAL FIBRADO GRIS 20KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10892', 'GOMA LIQUIDA NEGRO 5KG', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10893', 'GOMA LIQUIDA NEGRO 1,2 KG', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10894', 'GOMA LIQUIDA NEGRO 21 KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10895', 'GOMA LIQUIDA ROJO TANINO 21 KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10896', 'GOMA LIQUIDA ROJO TANINO 1,2 KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10897', 'GOMA LIQUIDA ROJO TANINO 5 KG', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10898', 'GOMA LIQUIDA GRIS PLOMO 5 KG', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10899', 'GOMA LIQUIDA GRIS PLOMO 1,2 KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10900', 'GOMA LIQUIDA GRIS PLOMO 21 KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10901', 'TELA VINILICA SUPREMA X METRO', 0, 0,
    76.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11160', 'TECHOPAL FIBRADO GRIS 4KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11161', 'TECHOPAL FIBRADO VERDE 4KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11162', 'TECHOPAL FIBRADO CERAMICA 4KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11163', 'TECHOPAL FIBRADO BLANCO 4KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11164', 'TECHOPAL FIBRADO BLANCO 20KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11165', 'TECHOPAL FIBRADO VERDE 20KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11359', 'NOVACOR COBRE MAIS BLANCO SHERWIN 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11361', 'LATEX CONTRATISTA BLANCO SHERWIN 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11362', 'LATEX CONTRATISTA BLANCO SHERWIN 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11363', 'LATEX KISACRIL SEMIBRILLO BLANCO POLAR 3.6LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11364', 'LATEX KISACRIL SEMIBRILLO BLANCO POLAR 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11365', 'LATEX KISAPRO FOSCO BLANCO BC 410 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11366', 'LATEX KISAPRO-BELLACASA FOSCO BLANCO BC 410 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11367', 'KISACRIL EPOXI AGUA BR BLANCO BASE 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11368', 'KISACRIL EPOXI AGUA ACE BLANCO BASE 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11369', 'LATEX KISAPRO FOSCO BASE A - BC PREMIUM  18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11370', 'LATEX KISACRIL FOSCO BASE A 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11371', 'LATEX KISACRIL FOSCO BASE A 3.6 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11372', 'LATEX KISACRIL FOSCO BASE B 3.6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11373', 'LATEX KISACRIL FOSCO BASE B 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11374', 'LATEX KISACRIL FOSCO BASE C 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11375', 'LATEX KISACRIL FOSCO BASE C 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11376', 'LATEX BELLA CASA FOSCO BASE A 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11377', 'LATEX BELLA CASA FOSCO BASE A 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11378', 'LATEX BELLA CASA FOSCO BASE B 3.6LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11379', 'LATEX BELLA CASA FOSCO BASE B 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11380', 'COLORANTE KILLING AMARILLO AXX', 0, 0,
    2584.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11381', 'COLORANTE KILLING NEGRO B', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11405', 'NOVACOR COBRE MAIS BLANCO SHERWIN 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11406', 'LATEX KISAPRO-BELLACASA SEMIBRILLO BLANCO BC 1810 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11407', 'LATEX KISAPRO-BELLACASA SEMIBRILLO BLANCO BC 1810 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11408', 'LATEX KISACRIL SEMIBRLLO BASE B 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11409', 'LATEX KISACRIL SEMIBRLLO BASE B 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11410', 'LATEX KISACRIL SEMIBRLLO BASE C 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11411', 'LATEX KISACRIL SEMIBRLLO BASE C 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11412', 'LATEX KISACRIL ACRILICO FOSCO BASE A 0.9LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11413', 'LATEX KISACRIL ACRILICO FOSCO BASE B 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11414', 'LATEX KISACRIL ACRILICO FOSCO BASE C 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11415', 'LATEX KISACRIL SEMIBRILLO BASE A 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11416', 'LATEX KISACRIL SEMIBRILLO BASE B 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11417', 'LATEX KISACRIL SEMIBRILLO BASE C 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11420', 'LATEX KISAPRO-BELLACASA FOSCO BASE A BC PREMIUN 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11421', 'LATEX KISAPRO-BELLACASA FOSCO BASE B BC PREMIUN 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11422', 'LATEX KISAPRO-BELLACASA FOSCO BASE B BC PREMIUN 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11431', 'COLORANTE KILLING AMARILLO OXIDO C', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11432', 'COLORANTE KILLING VERDE D', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11433', 'COLORANTE KILLING AZUL E', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11434', 'COLORANTE KILLING ROJO OXIDO F', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11435', 'COLORANTE KILLING MARRON I', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11436', 'COLORANTE KILLING BLANCO KX', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11437', 'COLORANTE KILLING TIERRA L', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11438', 'COLORANTE KILLING ROJO R', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11439', 'COLORANTE KILLING AMARILLO MEDIO T', 0, 0,
    2684.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11440', 'COLORANTE KILLING MAGENTA', 0, 0,
    2700.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10001', 'LATEX. MAX  BLANCO  1LT', 0, 0,
    13.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10002', 'LATEX. MAX  AMARILLO GIRASOL 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10003', 'LATEX. MAX  ARENA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10004', 'LATEX. MAX  AZUL MAR 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10005', 'LATEX. MAX  BLANCO 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10006', 'LATEX. MAX  CELESTE 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10007', 'LATEX. MAX  DAMASCO  3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10008', 'LATEX. MAX  FUCSIA SUAVE  3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10009', 'LATEX. MAX  GRIS HIELO 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10010', 'LATEX. MAX  LADRILLO 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10011', 'LATEX. MAX  LILA 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10012', 'LATEX. MAX  MOSTAZA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10013', 'LATEX. MAX  NARANJA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10014', 'LATEX. MAX  VERDE AGUA 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10015', 'LATEX. MAX  VERDE AMAZONA 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10016', 'LATEX. MAX  VERDE LIMON 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10017', 'LATEX. MAX  TURQUESA 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10018', 'LATEX. MAX  BLANCO HIELO 3.6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10019', 'LATEX. MAX  GRIS 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10020', 'LATEX. MAX  AMARILLO GIRASOL 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10021', 'LATEX. MAX  ARENA 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10022', 'LATEX. MAX  AZUL MAR 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10023', 'LATEX. MAX  BLANCO 18 LTS', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10024', 'LATEX. MAX  CELESTE 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10025', 'LATEX. MAX  DAMASCO  18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10026', 'LATEX. MAX  FUCSIA SUAVE  18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10027', 'LATEX. MAX  GRIS HIELO 18 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10028', 'LATEX. MAX  LADRILLO 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10029', 'LATEX. MAX  LILA 18 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10030', 'LATEX. MAX  MOSTAZA 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10031', 'LATEX. MAX  NARANJA 18 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10032', 'LATEX. MAX  VERDE AGUA 18 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10033', 'LATEX. MAX  VERDE AMAZONA 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10034', 'LATEX. MAX  VERDE LIMON 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10035', 'LATEX. MAX  TURQUESA 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10036', 'LATEX. MAX  GRIS 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10884', 'LATEX. MAX  BLANCO HIELO  18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10042', 'LATEX. PINTOR AMARILLO 1LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10043', 'LATEX. PINTOR ALGODÓN 1LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10044', 'LATEX. PINTOR ARENA 1LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10120', 'PINTURA PARA PISOS AZUL 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10121', 'PINTURA PARA PISOS CEMENTO  3.6LTS', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10122', 'PINTURA PARA PISOS CERAMICA 3.6LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10123', 'PINTURA PARA PISOS GRIS 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10124', 'PINTURA PARA PISOS NEGRO 3.6LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10125', 'PINTURA PARA PISOS ROJO TANINO 3.6LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10126', 'PINTURA PARA PISOS VERDE TENIS 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10127', 'PINTURA PARA PISOS AZUL 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10128', 'PINTURA PARA PISOS CEMENTO  18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10129', 'PINTURA PARA PISOS CERAMICA 18 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10130', 'PINTURA PARA PISOS GRIS 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10131', 'PINTURA PARA PISOS NEGRO 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10132', 'PINTURA PARA PISOS ROJO TANINO 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10133', 'PINTURA PARA PISOS VERDE TENIS 18 LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11045', 'LATEX PROFESIONAL BORDO 3,6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11046', 'LATEX PROFESIONAL CERAMICA 3,6LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11047', 'LATEX PROFESIONAL CONCRETO 3,6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PINTURA PARA PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11048', 'LATEX PROFESIONAL FUCSIA VIVO 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11049', 'LATEX PROFESIONAL ROJO BORNEO 3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11050', 'LATEX PROFESIONAL ROSA VIEJO 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11051', 'LATEX PROFESIONAL TANGERINA 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11052', 'LATEX PROFESIONAL TERRACOTA 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11053', 'LATEX PROFESIONAL VAINILLA 3,6LTS', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11054', 'LATEX PROFESIONAL VERDE MUSGO 3,6LTS', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11055', 'LATEX PROFESIONAL AZUL CLARO 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11056', 'LATEX PROFESIONAL AZUL CAPRI 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11057', 'LATEX PROFESIONAL CELESTE CIELO 3,6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11058', 'LATEX PROFESIONAL CITRUS 3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11059', 'LATEX PROFESIONAL ESMERALDA 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11060', 'LATEX PROFESIONAL NEGRO 3,6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11061', 'LATEX PROFESIONAL TURQUESA 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11062', 'LATEX PROFESIONAL VERDE AGUA 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11063', 'LATEX PROFESIONAL VIOLETA 3,6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11064', 'LATEX PROFESIONAL ARENA CLARO 3,6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11065', 'LATEX PROFESIONAL BLANCO 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11066', 'LATEX PROFESIONAL CEMENTO CRUDO 3,6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11067', 'LATEX PROFESIONAL DURAZNO 3,6LTS', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11068', 'LATEX PROFESIONAL GRIS CLARO 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11069', 'LATEX PROFESIONAL MAIZ 3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11070', 'LATEX PROFESIONAL OCRE 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11071', 'LATEX PROFESIONAL SEDA 3,6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11072', 'LATEX PROFESIONAL TOSTADO 3,6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11073', 'LATEX PROFESIONAL TOSTADO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11074', 'LATEX PROFESIONAL TERRACOTA 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11075', 'LATEX PROFESIONAL SEDA 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11076', 'LATEX PROFESIONAL OCRE 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11077', 'LATEX PROFESIONAL MAIZ 18LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11078', 'LATEX PROFESIONAL GRIS CLARO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11079', 'LATEX PROFESIONAL DURAZNO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11080', 'LATEX PROFESIONAL CEMENTO CRUDO 18LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11081', 'LATEX PROFESIONAL BLANCO 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11082', 'LATEX PROFESIONAL ARENA CLARO 18LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11083', 'LATEX PROFESIONAL CERAMICA 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11084', 'LATEX PROFESIONAL CONCRETO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11085', 'LATEX PROFESIONAL FUCSIA VIVO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11086', 'LATEX PROFESIONAL ROJO BORNEO 18LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11087', 'LATEX PROFESIONAL ROSA VIEJO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11088', 'LATEX PROFESIONAL TANGERINA 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11089', 'LATEX PROFESIONAL VAINILLA 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11090', 'LATEX PROFESIONAL VERDE MUSGO 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11091', 'LATEX PROFESIONAL AZUL CLARO 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11092', 'LATEX PROFESIONAL AZUL CAPRI 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11093', 'LATEX PROFESIONAL CELESTE CIELO 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11094', 'LATEX PROFESIONAL CITRUS 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11095', 'LATEX PROFESIONAL NEGRO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11096', 'LATEX PROFESIONAL TURQUESA 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11097', 'LATEX PROFESIONAL VERDE AGUA 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11098', 'LATEX PROFESIONAL VIOLETA 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11099', 'LATEX PROFESIONAL ESMERALDA 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10473', 'LATEX. TEJAS TEJA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10480', 'LATEX. TEJAS VERDE 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11236', 'LIJA AL AGUA TIGRE NRO 80', 0, 0,
    85.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11237', 'LIJA AL AGUA TIGRE NRO 80  (25UNIDADES)', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11238', 'LIJA AL AGUA TIGRE NRO 100', 0, 0,
    70.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11239', 'LIJA AL AGUA TIGRE NRO 100  (25UNIDADES)', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11240', 'LIJA AL AGUA TIGRE NRO 120', 0, 0,
    71.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11241', 'LIJA AL AGUA TIGRE NRO 120  (25UNIDADES)', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11242', 'LIJA AL AGUA TIGRE NRO 150', 0, 0,
    64.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11243', 'LIJA AL AGUA TIGRE NRO 150  (25UNIDADES)', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11244', 'LIJA AL AGUA TIGRE NRO 220  (25UNIDADES)', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11245', 'LIJA AL AGUA TIGRE NRO 220', 0, 0,
    53.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11447', 'LIJA AL AGUA TIGRE NRO 180  (25UNIDADES)', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11448', 'LIJA AL AGUA TIGRE NRO 180', 0, 0,
    100.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11314', 'MEGA SEMIBRILLO BLANCO  18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11315', 'MEGA SEMIBRILLO BLANCO  3,6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11316', 'MEGA TEXTURA PROYECTADA BLANCO 24KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11317', 'MEGA TEXTURA HIDROREPELENTE BLANCO 24KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11318', 'MEGA TEXTURA GRAFIATO BLANCO 24KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11319', 'MEGA TEXTURA LISA BLANCO 24KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11320', 'ENDUIDO INTERIOR ALTHACOR (MASA CORRIDA)  25KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11321', 'ENDUIDO EXTERIOR ALTHACOR (MASA ACRILICA)  25KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11322', 'MEGA MASA NIVELADORA 24KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11323', 'MEGA RESINA AL AGUA INCOLOR 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10463', 'MUROCRIL ROJO TANINO 20 KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10542', 'OPAL OPALATEX ARENA 3.6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10543', 'OPAL OPALATEX BLANCO 3.6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10544', 'OPAL OPALATEX BLANCO HIELO 3.6LTS', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10545', 'OPAL OPALATEX CERAMICA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PROFESIONAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10546', 'OPAL OPALATEX DURAZNO 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10547', 'OPAL OPALATEX MANDARINA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10548', 'OPAL OPALATEX OCRE 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10549', 'OPAL OPALATEX TRIGO  3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10550', 'OPAL OPALATEX TURQUESA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10551', 'OPAL OPALATEX VERDE FLORESTA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10552', 'OPAL OPALATEX VERDE MANZANA 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10553', 'OPAL OPALATEX ZANAHORIA 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10554', 'OPAL OPALATEX VERDE LIMON 3.6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10555', 'OPAL OPALATEX AMARILLO 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10556', 'OPAL OPALATEX VERDE AGUA 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10557', 'OPAL OPALATEX GRIS HUMO 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10558', 'OPAL OPALATEX FUCSIA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10559', 'OPAL OPALATEX LILA 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10560', 'OPAL OPALATEX GRANDE ARENA 18LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10561', 'OPAL OPALATEX GRANDE BLANCO 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10562', 'OPAL OPALATEX GRANDE BLANCO HIELO 18LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10563', 'OPAL OPALATEX GRANDE CERAMICA 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10564', 'OPAL OPALATEX GRANDE DURAZNO 18LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10565', 'OPAL OPALATEX GRANDE MANDARINA 18LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10566', 'OPAL OPALATEX GRANDE OCRE 18LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10567', 'OPAL OPALATEX GRANDE TRIGO 18LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10568', 'OPAL OPALATEX GRANDE TURQUESA 18LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10569', 'OPAL OPALATEX GRANDE VERDE FLORESTA  18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10571', 'OPAL OPALATEX GRANDE ZANAHORIA 18LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10572', 'OPAL OPALATEX GRANDE VERDE LIMON 18LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10573', 'OPAL OPALATEX GRANDE AMARILLO 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10574', 'OPAL OPALATEX GRANDE VERDE AGUA 18LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10575', 'OPAL OPALATEX GRANDE GRIS HUMO 18LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10576', 'OPAL OPALATEX GRANDE FUCSIA 18LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10577', 'OPAL OPALATEX GRANDE LILA 18LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10982', 'OPALATEX GRANDE VERDE MANZANA 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11110', 'PATINA QUARTZOLI NEGRO 1KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11111', 'PATINA QUARTZOLI BEIGE 1KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11112', 'PATINA BAUTECH MARRON 1KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11113', 'PATINA QUARTZOLI BLANCO 1KG', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11114', 'PATINA QUARTZOLI GRIS / CINZA 1KG', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11115', 'PATINA QUARTZOLI CARAMELO 1KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10332', 'PAVIMENTO AMARILLO 3,6 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10333', 'PAVIMENTO BLANCO 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10334', 'DILUYENTE PARA PAVIMENTO 1LT', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10865', 'PAVIMENTO BLANCO 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10866', 'PAVIMENTO NEGRO 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10867', 'PAVIMENTO NEGRO 3,6 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11170', 'PINTURA ATERMICA BLANCO 3.6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11171', 'PINTURA ATERMICA ARENA 3.6 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11172', 'PINTURA ATERMICA  MARFIL 3.6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'OPALATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11137', 'PVC 39000', 0, 0,
    20000.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11184', 'PVC', 0, 0,
    19980.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11185', 'CORNIZA P/ PVC', 0, 0,
    59.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11199', 'PVC BLANCO HIELO', 0, 0,
    19929.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10469', 'RESINA ACRILICA 850CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10470', 'RESINA ACRILICA 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10983', 'RESINA ACRILICA 18LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11226', 'RESINA EPOXI P/ MADERA', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11135', 'PANEL RIPADO  17CMX2.80 4 RANURAS', 0, 0,
    10.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11136', 'PANEL RIPADO  17CMX2.80 6 RANURAS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10868', 'SECADO RAP 0,850 L VERDE JOHN DEERE', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10869', 'SECADO RAP 0,850 L BLANCO PURO', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10870', 'SECADO RAP 0,850 L NEGRO INTENSO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10871', 'SECADO RAP 0,850 L GRIS SCANIA 78', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10490', 'AMAFLEX SELLADOR 3X1 ECO 1 LT', 0, 0,
    9.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10491', 'AMAFLEX SELLADOR 3X1 ECO 3,6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10492', 'AMAFLEX SELLADOR 3X1 ECO 18 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10493', 'SELLADOR PIGMENTADO 3.6LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10494', 'SELLADOR PIGMENTADO 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11044', 'SELLAFLEX SELLADOR ACRILICO PROFESIONAL 3,6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11106', 'SELLAFLEX SELLADOR ACRILICO PROFESIONAL 18LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11272', 'FLEXOPAL 1LTS', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11273', 'SELLADOR FLEXOPAL 5LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11308', 'SELLAFLEX SELLADOR ACRILICO PROFESIONAL 1LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11195', 'MUROCAL 1L SIKA', 0, 0,
    12.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11196', 'MUROCAL 5LTS SIKA', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10733', 'PIZARRON VERDE 250 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10734', 'PIZARRON VERDE 850 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11168', 'SATINADO PREMIUM BLANCO 850 CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11169', 'SATINADO PREMIUM BLANCO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11179', 'PIZARRON NEGRO 850CC', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11300', 'SATINADO PREMIUM NEGRO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11309', 'SATINADO PREMIUM BLANCO HIELO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11382', 'SINTETICO BELLACASA BASE A 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11383', 'SINTETICO BELLACASA BASE A 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11384', 'SINTETICO BELLACASA BASE B 0.9LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11385', 'SINTETICO BELLACASA BASE B 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11386', 'KISACRIL EMBORRACHADO BASE A 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11387', 'KISACRIL EMBORRACHADO BASE A 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11388', 'KISACRIL EMBORRACHADO BASE B 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11389', 'KISACRIL EMBORRACHADO BASE B 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11390', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE A 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11391', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE A 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11392', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE B 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11393', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE B 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11394', 'PISOS KISACRIL CINZA CHUMBO 3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11395', 'PISOS KISACRIL CINZA CHUMBO SEMIBRILLO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11396', 'PISOS KISACRIL NEGRO 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11397', 'PISOS KISACRIL NEGRO SEMIBRILLO 3.6LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11418', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE C 0.9LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11419', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE C 3.6LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11423', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE C 3.6 LTS', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11424', 'KISACRIL EMBORRACHADO BASE C 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11425', 'KISACRIL EMBORRACHADO BASE C 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11426', 'LATEX BELLACASA SEMIBRILLO BASE A 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11427', 'LATEX BELLACASA SEMIBRILLO BASE A 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11428', 'LATEX BELLACASA SEMIBRILLO BASE B 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11429', 'LATEX BELLACASA SEMIBRILLO BASE B 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11430', 'LATEX KISACRIL BASE A SEMIBRILLO 18 LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11441', 'LATEX KISACRIL BASE A SEMIBRILLO 3.6 LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11442', 'LATEX KISACRIL BASE B SEMIBRILLO 18 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11450', 'PISOS KISACRIL CINZA CHUMBO SEMIBRILLO 18 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10602', 'OPAL SINTETICO 35 DORADO 250CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10640', 'OPAL ESMALTE SINTETICO OPAL 23 CELESTE 3.6LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10661', 'OPAL ESMALTE SINTETICO OPAL 15 NEGRO 3.6LTS', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10882', 'OPAL ESMALTE SINTETICO OPAL BLANCO 850CC', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10883', 'OPAL ESMALTE SINTETICO OPAL BLANCO 3.6LT', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11187', 'BRILLOPLAST MAX BLANCO 900CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11188', 'BRILLOPLAST MAX NEGRO 900CC', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11189', 'BRILLOPLAST MAX GRIS 900CC', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11190', 'BRILLOPLAST MAX GRIS 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11191', 'BRILLOPLAST MAX NEGRO  3.6LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11192', 'BRILLOPLAST MAX BLANCO  3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10501', 'THINNER AMANECER UNIVERSAL 325 CC', 0, 0,
    54.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10502', 'THINNER AMANECER UNIVERSAL 1 LT (040)', 0, 0,
    17.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10503', 'THINNER AMANECER UNIVERSAL 5 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10504', 'THINNER AMANECER UNIVERSAL 18 LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10505', 'THINNER AMANECER ULTRA 1 LT (020)', 0, 0,
    35.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10506', 'THINNER AMANECER ULTRA  5 LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10508', 'AGUARRAS ULTRA 325CC', 0, 0,
    55.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10509', 'AGUARRAS ULTRA 1LTS', 0, 0,
    27.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10510', 'AGUARRAS ULTRA 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10511', 'REMOVEDORES DE PINTURA 1 LT', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10517', 'ACIDO MURIATICO 1 LT', 0, 0,
    8.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10519', 'KEROSENE 1 LT', 0, 0,
    11.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10520', 'KEROSENO 5 LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10902', 'AGUARRAS ULTRA 5LTS AMANECER', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10953', 'ACIDO MURIATICO 18 LT', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10923', 'AGUARRAS OPAL 5LT', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10980', 'AGUARRAS OPAL 325CC', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10981', 'THINNER OPAL UNIVERSAL 325CC', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10382', 'PROT. P/ MADERA STAIN CAOBA 850 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10383', 'PROT. P/ MADERA STAIN CEDRO 850 CC', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10384', 'PROT. P/ MADERA STAIN NATURAL 850 CC', 0, 0,
    7.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10385', 'PROT. P/ MADERA STAIN NOGAL 850 CC', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11263', 'SUVINIL SINTETICO BRILLANTE BLANCO 900ML', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11264', 'SUVINIL SINTETICO BRILLANTE NEGRO 900ML', 0, 0,
    6.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11265', 'SUVINIL TOQUE FOSCO BLANCO NIEVE 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11266', 'SUVINIL TOQUE BRILLO S/B BLANCO NIEVE 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11267', 'SUVINIL TOQUE FOSCO  BLANCO NIEVE 18LTS', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11268', 'SUVINIL TOQUE BRILLO S/B  BLANCO NIEVE 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11270', 'SUVINIL TOQUE FOSCO BASE 3.6LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11286', 'SUVINIL TOQUE FOSCO ARENA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11288', 'SUVINIL TOQUE FOSCO ALGODON EGIPCIO 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11289', 'SUVINIL TOQUE FOSCO ELEFANTE 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11290', 'SUVINIL TOQUE DE SEDA BLANCO NIEVE 3.6LTS', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11291', 'SUVINIL TOQUE CLASSICA BLANCO NIEVE 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11292', 'SUVINIL TOQUE CLASSICA ARENA 3.6LTS', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11296', 'SUVINIL TOQUE FOSCO  ARENA 18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11305', 'SUVINIL TOQUE BRILLO ALGODON EGIPCIO 18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11324', 'SUVINIL TOQUE CLASICO BLANCO NIEVE 18LTS', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11445', 'SUVINIL TOQUE FOSCO  CREMA DE MANI 18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11446', 'SUVINIL TOQUE FOSCO  SERTON 3.6LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11449', 'SUVINIL TOQUE FOSCO  DULCE DE LECHE 18LTS', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11468', 'SUVINIL TOQUE FOSCO GALLETA DE CHAMPAGNE B268 1LT', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10483', 'TEXTURATO LISO  ESTANDAR 25KG', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10955', 'TEXTURADO RUSTICO GRAFIATO PREMIUM 6KG', 0, 0,
    0.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10956', 'TEXTURADO RUSTICO GRAFIATO PREMIUM 26KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10957', 'TEXTURADO CLASICO AMANECER PREMIUM 6KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10958', 'TEXTURADO CLASICO AMANECER PREMIUM 26KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10961', 'TEXTURATO RUSTICO  ESTANDAR 25KG', 0, 0,
    3.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10962', 'TEXTURATO CLASICO ESTANDAR 25KG', 0, 0,
    5.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11014', 'TEXTURADO FINO QUARTZO BLANCO 6KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11015', 'TEXTURADO FINO QUARTZO CHINA DOLL 6KG', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11016', 'TEXTURADO FINO QUARTZO CLAY 6KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11017', 'TEXTURADO FINO QUARTZO BLANCO 25KG', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11018', 'TEXTURADO FINO QUARTZO CLAY 25KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11173', 'TEXTURADO FINO QUARTZO CHINA DOLL  25KG', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11186', 'TEXTURA PROYECTADA BLASCOR', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10774', 'THINNER OPAL UNIVERSAL 1LT (010)', 0, 0,
    29.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10775', 'THINNER OPAL UNIVERSAL 5LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11310', 'AGUARRAS OPAL  1LT', 0, 0,
    21.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11311', 'AGUARRAS OPAL  18LT', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11205', 'ESQUINERO EXTERIOR P/ ACABADO RECTO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11206', 'ESQUINERO INTERIOR P/ ACABADO RECTO', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11207', 'VOLTEADOR 11X5 ALUMINIO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11208', 'CHAROLA DE PLASTICO 14¨¨ P/RODILLO', 0, 0,
    2.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11209', 'ESCALERA ARTICULADA 4X3 - 150KGMAX', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11210', 'FLOTA ESPECIAL PLAST BLANDO 9-1/2X4X5/8', 0, 0,
    1.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11211', 'DESTAPADOR DE BALDES TRUPER', 0, 0,
    4.0, 0, 'UNIDAD', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;

  RAISE NOTICE '=== IMPORT OK: % productos procesados ===', v_ins;
END $do$;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verificación
SELECT count(*) AS productos_ferrecolor FROM ferrecolor.productos;
SELECT count(*) AS categorias_ferrecolor FROM ferrecolor.categorias_productos;
