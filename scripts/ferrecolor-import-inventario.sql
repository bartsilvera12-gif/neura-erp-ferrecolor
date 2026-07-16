-- =============================================================================
-- Import inventario Ferrecolor desde plantilla_productos_nuevo_excel.xlsx
-- 40 categorías + 810 productos con precio, costo y stock reales.
-- =============================================================================

BEGIN;

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

  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ADHESIVOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ADITIVOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'AEROSOL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'AMANECER DECO', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'AMATECH', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ANTIOXIDO AMANECER', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ATLAS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BARNIZ AMANECER', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BASE DECO', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BLASCOR', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'BRILLALUX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'CUBRELUX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'DECO CLASSIC', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'DURAFRENT', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ENDUIDOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'ENTONADOR', true)
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
  VALUES (v_empresa_id, 'LATEX MAX', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'LATEX PISOS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'LIJAS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'MEGA', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'PATINAS', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'PAVIMENTO', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'PVC', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SELLADOR', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SIKA', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICO AMANECER', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICO KILLING', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICO OPAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SINTETICOS SINTEPLAST', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SOLVENTE AMANECER', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SOLVENTE OPAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'SUVINIL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'THINNER OPAL', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'TINTA LUSTRE', true)
  ON CONFLICT DO NOTHING;
  INSERT INTO ferrecolor.categorias_productos (empresa_id, nombre, activo)
  VALUES (v_empresa_id, 'TRUPER', true)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Categorías OK (% total)', 40;

  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10513', 'ANTIOX AEROSOL GRIS', NULL,
    25000.0, 19500.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10514', 'ANTIOX AEROSOL NEGRO', NULL,
    25000.0, 19500.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10737', 'PINCEL TIGRE AZUL REF 728 1 -1/2''''', NULL,
    6000.0, 3550.0,
    20.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10738', 'PINCEL TIGRE AZUL REF 728 2''''', NULL,
    8000.0, 4032.0,
    50.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10739', 'PINCEL TIGRE AZUL REF 728 2- 1/2''''', NULL,
    10000.0, 5568.0,
    28.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10740', 'PINCEL TIGRE AZUL REF 728 3''''', NULL,
    14000.0, 8141.0,
    40.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10352', 'PINTURA EN AEROSOL AMARILLO-41', NULL,
    23000.0, 18300.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10750', 'RODILLO ANTIGOTEO TIGRE 23CM', NULL,
    18000.0, 9200.0,
    23.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10517', 'ACIDO MURIATICO 1 LT', NULL,
    16000.0, 11300.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10953', 'ACIDO MURIATICO 18 LT', NULL,
    297000.0, 207900.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10518', 'ACIDO MURIATICO 5 LTS', NULL,
    80000.0, 56200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10427', 'ADHESIVO DE CONTACTO 125CC', NULL,
    13000.0, 8900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10429', 'ADHESIVO DE CONTACTO 3.6LTS', NULL,
    185000.0, 129800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11262', 'AEROSOL AGRICOLA VERDE JHON DEERE MUNDIAL', NULL,
    25000.0, 16032.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11261', 'AEROSOL AGRICOLA VERMELHO MASSEY MUNDIAL', NULL,
    25000.0, 16032.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10877', 'AEROSOL ANTIOXIDO GRIS AMANECER', NULL,
    28000.0, 19500.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10873', 'AEROSOL ANTIOXIDO NEGRO AMANECER', NULL,
    28000.0, 19500.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11401', 'AEROSOL BYP BERMELLON BRILLANTE 400ML', NULL,
    20000.0, 12600.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11403', 'AEROSOL BYP BLANCO BRILLANTE 400ML', NULL,
    20000.0, 12600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11398', 'AEROSOL BYP SUPER NEGRO BRILLANTE 400ML', NULL,
    20000.0, 12600.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'THINNER OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11311', 'AGUARRAS OPAL  18LT', NULL,
    320000.0, 223125.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'THINNER OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11310', 'AGUARRAS OPAL  1LT', NULL,
    15000.0, 10500.0,
    21.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10980', 'AGUARRAS OPAL 325CC', NULL,
    7000.0, 4600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10923', 'AGUARRAS OPAL 5LT', NULL,
    78000.0, 54400.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11307', 'AGUARRAS SOLCOR 1LT', NULL,
    18000.0, 13296.0,
    24.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10490', 'AMAFLEX SELLADOR 3X1 ECO 1 LT', NULL,
    22000.0, 14800.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10492', 'AMAFLEX SELLADOR 3X1 ECO 18 LTS', NULL,
    256000.0, 179400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10491', 'AMAFLEX SELLADOR 3X1 ECO 3,6 LTS', NULL,
    65000.0, 45500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10985', 'AMATECH  CERAMICA 20KG  SIN FIBRA', NULL,
    440000.0, 308900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11009', 'AMATECH BLANCO 1 KG SIN FIBRA', NULL,
    25000.0, 16800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11010', 'AMATECH BLANCO 20KG  SIN FIBRA', NULL,
    440000.0, 308900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11008', 'AMATECH BLANCO 4 KG SIN FIBRA', NULL,
    98000.0, 67700.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11011', 'AMATECH CERAMICA 1 KG SIN FIBRA', NULL,
    25000.0, 16800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10984', 'AMATECH CERAMICA 4 KG  SIN FIBRA', NULL,
    98000.0, 67700.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10439', 'AMATECH FIBRADO BLANCO 1 KG', NULL,
    25000.0, 16800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10447', 'AMATECH FIBRADO BLANCO 20 KG', NULL,
    440000.0, 308900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10443', 'AMATECH FIBRADO BLANCO 4 KG', NULL,
    98000.0, 67700.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMATECH' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10440', 'AMATECH FIBRADO CERAMICA 1 KG', NULL,
    25000.0, 16800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10448', 'AMATECH FIBRADO CERAMICA 20 KG', NULL,
    440000.0, 308900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10445', 'AMATECH FIBRADO GRIS 4 KG', NULL,
    98000.0, 67700.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10442', 'AMATECH FIBRADO VERDE 1 KG', NULL,
    25000.0, 16800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10450', 'AMATECH FIBRADO VERDE 20 KG', NULL,
    440000.0, 308900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10446', 'AMATECH FIBRADO VERDE 4 KG', NULL,
    98000.0, 67700.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11012', 'AMATECH GRIS 20KG  SIN FIBRA', NULL,
    440000.0, 308900.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11013', 'AMATECH GRIS 4 KG  SIN FIBRA', NULL,
    98000.0, 67700.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11030', 'AMATECH ROJO TANINO 4KG SIN FIBRA', NULL,
    98000.0, 67700.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10757', 'ANTIHUMEDAD 3,6LT IMPERM', NULL,
    410000.0, 300700.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10457', 'ANTIHUMEDAD 850LT IMPERM', NULL,
    110000.0, 80100.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11040', 'ANTIOXIDO CUBRELUX 3EN1 AZUL FRANCIA 850CC', NULL,
    45000.0, 30000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11042', 'ANTIOXIDO CUBRELUX 3EN1 COLORADO MATE 3,6 LTS', NULL,
    155000.0, 117000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10311', 'ANTIOXIDO CUBRELUX 3EN1 VERDE M. 3,6 LTS', NULL,
    155000.0, 117000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10288', 'ANTIOXIDO CUBRELUX 3EN1 VERDE M. 850 CC', NULL,
    45000.0, 30000.0,
    13.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11116', 'ANTIOXIDO ECONOMICO 1L', NULL,
    10000.0, 8000.0,
    20.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADITIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10522', 'ARGAFLEX 5 LTS', NULL,
    133000.0, 92800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11269', 'ARGAMASA ACI', NULL,
    18000.0, 16000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10920', 'BANDEJA ATLAS P/RODILLO 46CM AT1492P', NULL,
    51000.0, 36072.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11306', 'BANDEJA DE PINTURA PLASTICA TIGRE 2304-23', NULL,
    10000.0, 6240.0,
    42.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11274', 'BARNIZ IMBUIA BLASCOR', NULL,
    130000.0, 103670.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11275', 'BARNIZ NATURAL BLASCOR', NULL,
    650000.0, 406000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10431', 'BARNIZ. MARINO BRILLANTE  AMANECER 3,6 LTS', NULL,
    179000.0, 125000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10430', 'BARNIZ. MARINO BRILLANTE AMANECER 850 CC', NULL,
    48000.0, 33500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10433', 'BARNIZ. MARINO MATE AMANECER 3,6 LTS', NULL,
    215000.0, 150000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BARNIZ AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10432', 'BARNIZ. MARINO MATE AMANECER 850 CC', NULL,
    59000.0, 41000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10243', 'BASE M SEMIBRILLO 17,4 LTS', NULL,
    629000.0, 483400.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10222', 'BASE M ULTRAMATE 3,3 LTS', NULL,
    131000.0, 100200.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10219', 'BASE M ULTRAMATE 900 CC', NULL,
    34000.0, 26100.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10242', 'BASE P SEMIBRILLO 17,4 LTS', NULL,
    732000.0, 562400.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10239', 'BASE P SEMIBRILLO 3,3 LTS', NULL,
    153000.0, 117400.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10236', 'BASE P SEMIBRILLO 900 CC', NULL,
    41000.0, 31500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10233', 'BASE P TERCIOPELO 17,4 LTS', NULL,
    718000.0, 551900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10224', 'BASE P ULTRAMATE 17,4 LTS', NULL,
    668000.0, 513200.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10238', 'BASE T SEMIBRILLO 900 CC', NULL,
    37000.0, 28400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10235', 'BASE T TERCIOPELO 17,4 LTS', NULL,
    556000.0, 427200.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10232', 'BASE T TERCIOPELO 3,3 LTS', NULL,
    123000.0, 94100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10229', 'BASE T TERCIOPELO 900 CC', NULL,
    34000.0, 25400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10226', 'BASE T ULTRAMATE 17,4 LTS', NULL,
    495000.0, 377100.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11330', 'BOTA', NULL,
    95000.0, 70000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11182', 'BRILLALUX  2EN1 GRIS ESPACIAL 3,6', NULL,
    205000.0, 152600.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10704', 'BRILLALUX 2EN1  MARRON COÑAC 850 CC', NULL,
    56000.0, 39400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10693', 'BRILLALUX 2EN1 BLANCO  850 CC', NULL,
    56000.0, 39400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10708', 'BRILLALUX 2EN1 GRIS 850 CC', NULL,
    56000.0, 39400.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10713', 'BRILLALUX 2EN1 GRIS ESPACIAL 850 CC', NULL,
    56000.0, 39400.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10718', 'BRILLALUX 2EN1 MARRON TABACO 850 CC', NULL,
    56000.0, 39400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10703', 'BRILLALUX 2EN1 NEGRO 850 CC', NULL,
    56000.0, 39400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10365', 'BRILLALUX BARNIZ COPAL CAOBA  250 CC', NULL,
    20000.0, 13400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10375', 'BRILLALUX BARNIZ COPAL CAOBA  3,6 LTS', NULL,
    165000.0, 116600.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10370', 'BRILLALUX BARNIZ COPAL CAOBA  850 CC', NULL,
    45000.0, 31800.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10364', 'BRILLALUX BARNIZ COPAL CEDRO 250 CC', NULL,
    20000.0, 13400.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10374', 'BRILLALUX BARNIZ COPAL CEDRO 3,6 LTS', NULL,
    165000.0, 116600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10369', 'BRILLALUX BARNIZ COPAL CEDRO 850 CC', NULL,
    45000.0, 31800.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10363', 'BRILLALUX BARNIZ COPAL LAPACHO 250 CC', NULL,
    20000.0, 13400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10373', 'BRILLALUX BARNIZ COPAL LAPACHO 3,6 LTS', NULL,
    165000.0, 116600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10368', 'BRILLALUX BARNIZ COPAL LAPACHO 850 CC', NULL,
    45000.0, 31800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10362', 'BRILLALUX BARNIZ COPAL NATURAL 250 CC', NULL,
    20000.0, 13400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10372', 'BRILLALUX BARNIZ COPAL NATURAL 3,6 LTS', NULL,
    165000.0, 116600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10367', 'BRILLALUX BARNIZ COPAL NATURAL 850 CC', NULL,
    45000.0, 31800.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10366', 'BRILLALUX BARNIZ COPAL NOGAL 250 CC', NULL,
    20000.0, 13400.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10376', 'BRILLALUX BARNIZ COPAL NOGAL 3,6 LTS', NULL,
    165000.0, 116600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10371', 'BRILLALUX BARNIZ COPAL NOGAL 850 CC', NULL,
    45000.0, 31800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ANTIOXIDO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10989', 'BRILLALUX FONDO ANTIOXIDO 3.6LTS GRIS', NULL,
    198000.0, 140900.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ANTIOXIDO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10988', 'BRILLALUX FONDO ANTIOXIDO 3.6LTS NEGRO', NULL,
    198000.0, 140900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ANTIOXIDO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10314', 'BRILLALUX GRAFITO GRIS CLARO 850', NULL,
    73000.0, 51500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ANTIOXIDO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10317', 'BRILLALUX GRAFITO GRIS OSCURO 3.6', NULL,
    248000.0, 176500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ANTIOXIDO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10316', 'BRILLALUX GRAFITO GRIS OSCURO 850', NULL,
    73000.0, 51500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11192', 'BRILLOPLAST MAX BLANCO  3.6LTS', NULL,
    240000.0, 166367.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11187', 'BRILLOPLAST MAX BLANCO 900CC', NULL,
    85000.0, 45417.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11190', 'BRILLOPLAST MAX GRIS 3.6LTS', NULL,
    240000.0, 166367.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11189', 'BRILLOPLAST MAX GRIS 900CC', NULL,
    85000.0, 45417.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11191', 'BRILLOPLAST MAX NEGRO  3.6LTS', NULL,
    240000.0, 166367.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICOS SINTEPLAST' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11188', 'BRILLOPLAST MAX NEGRO 900CC', NULL,
    85000.0, 45417.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10888', 'BROCHA 165X58CM RF5100 MAX', NULL,
    8000.0, 5300.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10889', 'BROCHA 180X75 RF 4810 MAX', NULL,
    10000.0, 7350.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11326', 'BYP RODILLO DE PUAS', NULL,
    115000.0, 80000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11327', 'BYP ZAPATO DE PICO TIPO PLANTILLA', NULL,
    170000.0, 120000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11126', 'CAL EN PASTA 4KG PINTU PLAS', NULL,
    12000.0, 7000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10187', 'CEMENTO QUEMADO GRIS 6KG', NULL,
    139000.0, 97300.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11281', 'CEMENTO QUEMADO MULTISUPERFICIES ARENA 5KG', NULL,
    92000.0, 69750.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11282', 'CEMENTO QUEMADO MULTISUPERFICIES CHOCOLATE 5KG', NULL,
    92000.0, 69750.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11280', 'CEMENTO QUEMADO MULTISUPERFICIES ELEFANTE 5KG', NULL,
    92000.0, 69750.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11443', 'CEMENTO QUEMADO SUVINIL TUNEL DE CONCRETO 6KG', NULL,
    235000.0, 196744.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11254', 'CEPILLO DE ACERO TIGRE 1777 -04', NULL,
    12000.0, 8928.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10992', 'CINTA  SEPARADORA PAPEL 24MMX50M TIGRE   REF', NULL,
    10000.0, 4560.0,
    50.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10756', 'CINTA  SEPARADORA PAPEL TIGRE 48X50  REF 2151-050', NULL,
    15000.0, 10500.0,
    18.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10831', 'CINTA ADVERTENCIA  70MM X 200MTS  CT212 FASCY', NULL,
    30000.0, 20600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10834', 'CINTA ADVERTENCIA  PRECAUCION 70MMX 200MT  CT242', NULL,
    30000.0, 20600.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11022', 'CINTA AISLANTE 19MMX10MTS NEGRO TIGRE', NULL,
    5000.0, 2200.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11221', 'CINTA ASFALTICA 10X10', NULL,
    30000.0, 22350.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11222', 'CINTA ASFALTICA 20X10', NULL,
    67000.0, 50450.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10972', 'CINTA DECORATIVA 12MMX10M 9UNID EUROGEL', NULL,
    40000.0, 28840.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10814', 'CINTA EMBALAJE TRANSPARENTE 48MM 100M FASCY', NULL,
    10000.0, 6386.0,
    15.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10829', 'CINTA MALLA YESO FY AUTOADHESIV 50MM 90M   CT311', NULL,
    25000.0, 16480.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11120', 'CINTA METRICA 3MX16MM KOMELON', NULL,
    45000.0, 30350.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11121', 'CINTA METRICA 5MX19MM KOMELON', NULL,
    55000.0, 36800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10823', 'CINTA METRICA FASCY FIBRA 20MM CM0120', NULL,
    38000.0, 24720.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10822', 'CINTA METRICA FASCY FIBRA 30MM CM0130', NULL,
    43000.0, 29870.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11341', 'CINTA P/ DRYWALL 50X45 AT2945', NULL,
    27000.0, 19014.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11276', 'CINTA SEPARADORA CREPE EUROCEL 24MMX50MM', NULL,
    14000.0, 8755.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11278', 'CINTA SEPARADORA CREPE EUROCEL 25MMX50MM', NULL,
    23000.0, 16480.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11277', 'CINTA SEPARADORA CREPE EUROCEL 36MMX50MM', NULL,
    18000.0, 13390.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11279', 'CINTA SEPARADORA CREPE EUROCEL 50MMX50MM', NULL,
    42000.0, 30900.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10991', 'CINTA SEPARADORA PAPEL RAPIFIX 18X50MM', NULL,
    12000.0, 7800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10754', 'CINTA SEPARADORA PAPEL TIGRE 18X50', NULL,
    8000.0, 4500.0,
    33.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10815', 'CINTILLO NYLON NEGRO 3,6X150MM CN236150 FASCY', NULL,
    200.0, 47.0,
    170.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10817', 'CINTILLO NYLON NEGRO 4,8X200MM CN248200 FASCY', NULL,
    300.0, 78.0,
    200.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10819', 'CINTILLO NYLON NEGRO 4,8X300MM CN248300 FASCY', NULL,
    500.0, 113.0,
    194.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10820', 'CINTILLO NYLON NEGRO 4,8X350MM CN248350 FASCY', NULL,
    1000.0, 129.0,
    184.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10821', 'CINTILLO NYLON NEGRO 4,8X400MM CN248400 FASCY', NULL,
    1000.0, 155.0,
    200.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10818', 'CINTILLO NYLON NEGRO 4.8X250MM CN248250 FASCY', NULL,
    500.0, 100.0,
    100.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10425', 'COLAMAX 1 LT', NULL,
    35000.0, 24900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11380', 'COLORANTE KILLING AMARILLO AXX', NULL,
    218.0, 175.0,
    2584.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11439', 'COLORANTE KILLING AMARILLO MEDIO T', NULL,
    390.0, 312.0,
    2683.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11431', 'COLORANTE KILLING AMARILLO OXIDO C', NULL,
    130.0, 104.0,
    2418.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11433', 'COLORANTE KILLING AZUL E', NULL,
    136.0, 109.0,
    2700.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11436', 'COLORANTE KILLING BLANCO KX', NULL,
    260.0, 208.0,
    2700.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11440', 'COLORANTE KILLING MAGENTA', NULL,
    377.0, 302.0,
    2700.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11434', 'COLORANTE KILLING ROJO OXIDO F', NULL,
    236.0, 189.0,
    2700.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11185', 'CORNIZA P/ PVC', NULL,
    25000.0, 20000.0,
    59.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11105', 'CUBRETODO PLASTICO MEDIO 4X5M  20M2 PENTRILO', NULL,
    25000.0, 15360.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10824', 'CUTTER FASCY MASTER ALUMNIO 18MM CUT181', NULL,
    20000.0, 13390.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10192', 'DECO CLASSIC CHINA DOLL 3,6LTS', NULL,
    140000.0, 105900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10204', 'DECO CLASSIC COSMIC 18LTS', NULL,
    620000.0, 475900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10195', 'DECO CLASSIC COSMIC 3,6LTS', NULL,
    140000.0, 105900.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10200', 'DECO CLASSIC FROST 18LTS', NULL,
    620000.0, 475900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10193', 'DECO CLASSIC ROJO CARMIN 3,6LTS', NULL,
    140000.0, 105900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10198', 'DECO CLASSIC WHITE 18LTS', NULL,
    620000.0, 475900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DECO CLASSIC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10189', 'DECO CLASSIC WHITE 3.6LTS', NULL,
    140000.0, 105900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BASE DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10963', 'DECO SEMIBRILLO  3,6LTS ROCK RIVER- COCOA CREAM', NULL,
    170000.0, 120000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10890', 'DESENGRIPANTE CHEMICOLOR 300ML', NULL,
    14000.0, 8500.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TRUPER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11211', 'DESTAPADOR DE BALDES TRUPER', NULL,
    15000.0, 9198.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TRUPER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10421', 'DILUYENTE LACA 1 LT 24600', NULL,
    37000.0, 25800.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10334', 'DILUYENTE PARA PAVIMENTO 1LT', NULL,
    37000.0, 25400.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10851', 'DISCO DIAM  PARA VIDRIO 110MM  D149 FASCY', NULL,
    35000.0, 25750.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10842', 'DISCO DIAM CONTINUO 110MM  D141 FASCY', NULL,
    16000.0, 11330.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10849', 'DISCO DIAM MULTIUSO 110MM  D146 FASCY', NULL,
    35000.0, 25750.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10839', 'DISCO DIAM PORCELANATO FINO 110MM  D147 FASCY', NULL,
    30000.0, 21630.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10844', 'DISCO DIAM SEGMENTADO 110MM  D140 FASCY', NULL,
    16000.0, 11330.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10846', 'DISCO DIAM SEGMENTADO 180MM  D170 FASCY', NULL,
    35000.0, 25750.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10833', 'DISCO FLAP ALUM OXIDAD 115MM #100 D3410 FASCY', NULL,
    8000.0, 4841.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PAVIMENTO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10832', 'DISCO FLAP ALUM OXIDAD 115MM #80 D3480 FASCY', NULL,
    8000.0, 4841.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10837', 'DISCO SIERRA TCT MADERA 110MM 24T D11024 FASCY', NULL,
    20000.0, 12875.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10835', 'DISCO SIERRA TCT MADERA 110MM 40T D111040 FASCY', NULL,
    25000.0, 16995.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10996', 'DURAFRENT AZUL 1LT', NULL,
    55000.0, 38600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10928', 'DURAFRENT AZUL 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11001', 'DURAFRENT BLANCO 1LT', NULL,
    55000.0, 38600.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10933', 'DURAFRENT BLANCO 3.6LT', NULL,
    175000.0, 134000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10940', 'DURAFRENT BORDO 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11005', 'DURAFRENT GRIS 1LT', NULL,
    55000.0, 38600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10938', 'DURAFRENT GRIS 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11002', 'DURAFRENT NARANJA ESTERINADA 1LT', NULL,
    55000.0, 38600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10140', 'DURAFRENT NARANJA ESTIRENADA 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10936', 'DURAFRENT NARANJA ESTIRENADA 3.6LT', NULL,
    175000.0, 134000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10141', 'DURAFRENT NEGRO  18LTS', NULL,
    815000.0, 623490.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11004', 'DURAFRENT NEGRO 1LT', NULL,
    55000.0, 38600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10937', 'DURAFRENT NEGRO 3.6LT', NULL,
    175000.0, 134000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10142', 'DURAFRENT OCRE 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10995', 'DURAFRENT OCRE 1LT', NULL,
    55000.0, 38600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10929', 'DURAFRENT OCRE 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10143', 'DURAFRENT ROJO ELECTRICO 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11003', 'DURAFRENT ROJO ELECTRICO 1LT', NULL,
    55000.0, 38600.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10935', 'DURAFRENT ROJO ELECTRICO 3.6LT', NULL,
    175000.0, 134000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10144', 'DURAFRENT ROJO TANINO 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10998', 'DURAFRENT ROJO TANINO 1LT', NULL,
    55000.0, 38600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11220', 'DURAFRENT ROJO TANINO 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10145', 'DURAFRENT TEJA 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10997', 'DURAFRENT TEJA 1LT', NULL,
    55000.0, 38600.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10931', 'DURAFRENT TEJA 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10146', 'DURAFRENT VERDE MUSGO 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11000', 'DURAFRENT VERDE MUSGO 1LT', NULL,
    55000.0, 38600.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10934', 'DURAFRENT VERDE MUSGO 3.6LT', NULL,
    175000.0, 134000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10147', 'DURAFRENT VERDE TENIS 18LTS', NULL,
    815000.0, 623500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10999', 'DURAFRENT VERDE TENIS 1LT', NULL,
    55000.0, 38600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'DURAFRENT' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10932', 'DURAFRENT VERDE TENIS 3.6LT', NULL,
    175000.0, 134000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10486', 'ENDUIDO 1.6KG ACRILICO PREMIUM ENV BCO', NULL,
    25000.0, 14700.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'MEGA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11321', 'ENDUIDO EXTERIOR ALTHACOR (MASA ACRILICA)  25KG', NULL,
    135000.0, 91200.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'MEGA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11293', 'ENDUIDO INTERIOR 15KG BLASCOR (MASA CORRIDA)', NULL,
    40000.0, 32605.0,
    26.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'MEGA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11334', 'ENDUIDO INTERIOR 15KG TINSUL (MASA CORRIDA)', NULL,
    32000.0, 21900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'MEGA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11312', 'ENDUIDO INTERIOR 25KG BALDE BLASCOR (MASA', NULL,
    110000.0, 83603.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11320', 'ENDUIDO INTERIOR ALTHACOR (MASA CORRIDA)  25KG', NULL,
    70000.0, 48960.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10489', 'ENDUIDO INTERIOR PROFESIONAL AMANECER 1.6KG', NULL,
    15000.0, 9500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10390', 'ENTONADO PARA MADERA CAOBA 240 CC', NULL,
    60000.0, 41600.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10386', 'ENTONADO PARA MADERA CAOBA 60 CC', NULL,
    21000.0, 14500.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10217', 'ENTONADOR BASE 1L AMAR HP ORG YQZ', NULL,
    612.0, 428.0,
    1906.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10208', 'ENTONADOR BASE 1L AMAR ORG YRZ', NULL,
    503.0, 352.0,
    2419.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10214', 'ENTONADOR BASE 1L AMAR OXIDO YXZ', NULL,
    256.0, 179.0,
    4487.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10210', 'ENTONADOR BASE 1L NARANJA HP ORG ARZ', NULL,
    808.0, 565.0,
    3087.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10206', 'ENTONADOR BASE 1L ROSA HP ORG PNZ', NULL,
    612.0, 428.0,
    3050.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR COROB' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10212', 'ENTONADOR BASE 1L VERDE PTHALO GPZ', NULL,
    338.0, 236.0,
    2530.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10924', 'ENTONADOR MAQUINA', NULL,
    4700.0, 4500.0,
    89.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10394', 'ENTONADORES 120 CC AMARILLO', NULL,
    17000.0, 11600.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10399', 'ENTONADORES 120 CC AZUL', NULL,
    17000.0, 11600.0,
    22.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10395', 'ENTONADORES 120 CC BERMELLON', NULL,
    17000.0, 11600.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10400', 'ENTONADORES 120 CC CEDRO', NULL,
    17000.0, 11600.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10405', 'ENTONADORES 120 CC MARRON', NULL,
    17000.0, 11600.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10403', 'ENTONADORES 120 CC NARANJA', NULL,
    17000.0, 11600.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10402', 'ENTONADORES 120 CC NEGRO', NULL,
    17000.0, 11600.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10396', 'ENTONADORES 120 CC OCRE', NULL,
    17000.0, 11600.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10401', 'ENTONADORES 120 CC SIENA', NULL,
    17000.0, 11600.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENTONADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10397', 'ENTONADORES 120 CC V. CLARO', NULL,
    17000.0, 11600.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10398', 'ENTONADORES 120 CC V. OSCURO', NULL,
    17000.0, 11600.0,
    17.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10407', 'ENTONADORES 50CC BERMELLON', NULL,
    10000.0, 7400.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10412', 'ENTONADORES 50CC CEDRO', NULL,
    10000.0, 7400.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10417', 'ENTONADORES 50CC MARRON', NULL,
    10000.0, 7400.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10415', 'ENTONADORES 50CC NARANJA', NULL,
    10000.0, 7400.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10414', 'ENTONADORES 50CC NEGRO', NULL,
    10000.0, 7400.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10408', 'ENTONADORES 50CC OCRE', NULL,
    10000.0, 7400.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10410', 'ENTONADORES 50CC V. OSCURO', NULL,
    10000.0, 7400.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11209', 'ESCALERA ARTICULADA 4X3 - 150KGMAX', NULL,
    950000.0, 675906.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11304', 'ESMALTE BASE AGUA EFECTO GOLD BLASCOR 900ML', NULL,
    65000.0, 50602.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11470', 'ESMALTE SR BLASCOR BLANCO 3.6LTS', NULL,
    189000.0, 132492.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11302', 'ESMALTE SR BLASCOR BLANCO 900ML', NULL,
    50000.0, 35288.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11469', 'ESMALTE SR BLASCOR NEGRO CADILAC 3.6LTS', NULL,
    189000.0, 132492.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10917', 'ESPATULA  ACERO ATLAS 6255/10  6,4', NULL,
    19000.0, 13102.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10916', 'ESPATULA  ACERO ATLAS 6255/12  7,6', NULL,
    20000.0, 13767.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10919', 'ESPATULA  ACERO ATLAS 6255/16 10,2', NULL,
    25000.0, 14500.0,
    13.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11246', 'ESPATULA ACERO MULTIUSO REF 2320 2" 1/2', NULL,
    13000.0, 8709.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11174', 'ESPATULA ACERO TIGRE 2151-3', NULL,
    10000.0, 6400.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11175', 'ESPATULA ACERO TIGRE 2151-4', NULL,
    12000.0, 7850.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10800', 'ESPATULA MEZCLADORA DE PINTURA 010X60CM GRANDE', NULL,
    50000.0, 37900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10801', 'ESPATULA MEZCLADORA DE PINTURA 08X40CM ATLAS', NULL,
    27000.0, 17500.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10913', 'ESPATULA P/YESO INOX ATLAS AT6455/8 8"', NULL,
    70000.0, 50558.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11247', 'ESPATULA TIGRE PRO REF 2330 -00', NULL,
    34000.0, 23520.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11198', 'ESPUMA EXPANSIVA CHEMICOLOR', NULL,
    30000.0, 18500.0,
    13.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TRUPER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11205', 'ESQUINERO EXTERIOR P/ ACABADO RECTO', NULL,
    35000.0, 23560.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TRUPER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11206', 'ESQUINERO INTERIOR P/ ACABADO RECTO', NULL,
    35000.0, 23560.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11212', 'ESQUINERO PARA PVC', NULL,
    10000.0, 6000.0,
    992.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11351', 'EXTENSOR  P/ PINCEL AT179 ATLAS', NULL,
    35000.0, 24905.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10845', 'EXTENSOR PARA RODILLO  ALUMNIO 2MT EXT201 FASCY', NULL,
    45000.0, 29870.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10841', 'EXTENSOR PARA RODILLO  METAL 3MT EXT204 FASCY', NULL,
    45000.0, 24720.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10419', 'FIJADOR PROF. 2X1 3,6 LTS', NULL,
    170000.0, 119700.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10418', 'FIJADOR PROF. 2X1 850 CC', NULL,
    48000.0, 33600.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11272', 'FLEXOPAL 1LTS', NULL,
    22000.0, 15965.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10454', 'GOMA LIQUIDA BLANCO 1.2KG', NULL,
    43000.0, 30200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10451', 'GOMA LIQUIDA GRIS 1.2KG', NULL,
    43000.0, 30200.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10898', 'GOMA LIQUIDA GRIS PLOMO 5 KG', NULL,
    152000.0, 105900.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10893', 'GOMA LIQUIDA NEGRO 1,2 KG', NULL,
    43000.0, 30200.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10894', 'GOMA LIQUIDA NEGRO 21 KG', NULL,
    649000.0, 454000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10892', 'GOMA LIQUIDA NEGRO 5KG', NULL,
    152000.0, 105900.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10896', 'GOMA LIQUIDA ROJO TANINO 1,2 KG', NULL,
    43000.0, 30200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10895', 'GOMA LIQUIDA ROJO TANINO 21 KG', NULL,
    649000.0, 454200.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10897', 'GOMA LIQUIDA ROJO TANINO 5 KG', NULL,
    152000.0, 105900.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10808', 'GUANTE FASCY LATEX L', NULL,
    8000.0, 4635.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10807', 'GUANTE FASCY LATEX M', NULL,
    8000.0, 4635.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11142', 'HIDROEPOXI BRILLANTE BLANCO 900 CC SINTEPLAST', NULL,
    93000.0, 67100.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11219', 'HIDROEPOXI BRILLANTE BLANCO3.6 LTS SINTEPLAST', NULL,
    370000.0, 260900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11217', 'HIDROEPOXI BRILLANTE ELEFANTE 900 CC SINTEPLAST', NULL,
    96000.0, 70467.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11143', 'HIDROEPOXI BRILLANTE GRIS ELEFANTE 3.6 LTS', NULL,
    405000.0, 287700.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11223', 'HIDROLAVADORA DE ALTA PRESION', NULL,
    765000.0, 567000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11335', 'JARRA ELECTRICA SUPREMA', NULL,
    40000.0, 29000.0,
    13.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11387', 'KISACRIL EMBORRACHADO BASE A 18LTS', NULL,
    595000.0, 425000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11386', 'KISACRIL EMBORRACHADO BASE A 3.6LTS', NULL,
    143000.0, 102000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11368', 'KISACRIL EPOXI AGUA ACE BLANCO BASE 3.6LTS', NULL,
    265000.0, 195500.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11367', 'KISACRIL EPOXI AGUA BR BLANCO BASE 3.6LTS', NULL,
    275000.0, 195500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11392', 'KISACRIL ESMALTE BASE AGUA BRILLANTE BASE B 0.9LTS', NULL,
    48000.0, 34000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BLASCOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11458', 'KIT BARNIZ PU 7800 BLASCOR 900ML', NULL,
    63000.0, 48402.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11202', 'KIT DE PINTURA ATLAS AT2004', NULL,
    50000.0, 35900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10748', 'KIT ECONOMICO ANTIGOTEO', NULL,
    25000.0, 13200.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10422', 'LACA BRILLALUX BRILLANTE', NULL,
    60000.0, 44700.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BLASCOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11452', 'LACA NITRO BLANCO PURO BLASCOR 900ML', NULL,
    55000.0, 41174.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BLASCOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11453', 'LACA NITRO NEGRO CADILAC BLASCOR 900ML', NULL,
    55000.0, 41174.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10838', 'LAPIZ CARPINTERO 7° LC72 FASCY', NULL,
    5000.0, 1202.0,
    21.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11377', 'LATEX BELLA CASA FOSCO BASE A 18LT', NULL,
    410000.0, 289000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11376', 'LATEX BELLA CASA FOSCO BASE A 3.6LT', NULL,
    105000.0, 73950.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11379', 'LATEX BELLA CASA FOSCO BASE B 18LT', NULL,
    400000.0, 280500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11378', 'LATEX BELLA CASA FOSCO BASE B 3.6LT', NULL,
    105000.0, 72250.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11427', 'LATEX BELLACASA SEMIBRILLO BASE A 18LTS', NULL,
    524000.0, 374000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11362', 'LATEX CONTRATISTA BLANCO SHERWIN 18 LTS', NULL,
    285000.0, 208000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11361', 'LATEX CONTRATISTA BLANCO SHERWIN 3.6LTS', NULL,
    75000.0, 52000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11412', 'LATEX KISACRIL ACRILICO FOSCO BASE A 0.9LTS', NULL,
    40000.0, 28050.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11413', 'LATEX KISACRIL ACRILICO FOSCO BASE B 0.9LTS', NULL,
    35000.0, 24650.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11414', 'LATEX KISACRIL ACRILICO FOSCO BASE C 0.9LTS', NULL,
    29000.0, 20400.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11430', 'LATEX KISACRIL BASE A SEMIBRILLO 18 LTS', NULL,
    691000.0, 493000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11370', 'LATEX KISACRIL FOSCO BASE A 18 LTS', NULL,
    584000.0, 416500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11371', 'LATEX KISACRIL FOSCO BASE A 3.6 LTS', NULL,
    140000.0, 97750.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11373', 'LATEX KISACRIL FOSCO BASE B 18 LTS', NULL,
    482000.0, 344250.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11372', 'LATEX KISACRIL FOSCO BASE B 3.6 LTS', NULL,
    120000.0, 85000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11375', 'LATEX KISACRIL FOSCO BASE C 18LT', NULL,
    365000.0, 259250.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11374', 'LATEX KISACRIL FOSCO BASE C 3.6LT', NULL,
    95000.0, 68000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11415', 'LATEX KISACRIL SEMIBRILLO BASE A 0.9LTS', NULL,
    46000.0, 32300.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11411', 'LATEX KISACRIL SEMIBRLLO BASE C 18LTS', NULL,
    447000.0, 318750.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11410', 'LATEX KISACRIL SEMIBRLLO BASE C 3.6LTS', NULL,
    108000.0, 76500.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11369', 'LATEX KISAPRO FOSCO BASE A - BC PREMIUM  18LTS', NULL,
    423000.0, 301750.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11365', 'LATEX KISAPRO FOSCO BLANCO BC 410 18LTS', NULL,
    480000.0, 352750.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11420', 'LATEX KISAPRO-BELLACASA FOSCO BASE A BC PREMIUN', NULL,
    114000.0, 80750.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11422', 'LATEX KISAPRO-BELLACASA FOSCO BASE B BC PREMIUN', NULL,
    363000.0, 259250.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11407', 'LATEX KISAPRO-BELLACASA SEMIBRILLO BLANCO BC 1810', NULL,
    655000.0, 467500.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11082', 'LATEX PROFESIONAL ARENA CLARO 18LTS', NULL,
    370000.0, 267800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11064', 'LATEX PROFESIONAL ARENA CLARO 3,6LTS', NULL,
    98000.0, 68300.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11092', 'LATEX PROFESIONAL AZUL CAPRI 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11056', 'LATEX PROFESIONAL AZUL CAPRI 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11091', 'LATEX PROFESIONAL AZUL CLARO 18LTS', NULL,
    370000.0, 268300.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11055', 'LATEX PROFESIONAL AZUL CLARO 3,6LTS', NULL,
    98000.0, 68300.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11081', 'LATEX PROFESIONAL BLANCO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11065', 'LATEX PROFESIONAL BLANCO 3,6LTS', NULL,
    98000.0, 58055.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11045', 'LATEX PROFESIONAL BORDO 3,6LTS', NULL,
    105000.0, 72500.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11093', 'LATEX PROFESIONAL CELESTE CIELO 18LTS', NULL,
    370000.0, 267800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11057', 'LATEX PROFESIONAL CELESTE CIELO 3,6LTS', NULL,
    98000.0, 68300.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11080', 'LATEX PROFESIONAL CEMENTO CRUDO 18LTS', NULL,
    370000.0, 267800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11066', 'LATEX PROFESIONAL CEMENTO CRUDO 3,6LTS', NULL,
    98000.0, 58055.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11083', 'LATEX PROFESIONAL CERAMICA 18LTS', NULL,
    370000.0, 267800.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11046', 'LATEX PROFESIONAL CERAMICA 3,6LTS', NULL,
    98000.0, 68300.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11094', 'LATEX PROFESIONAL CITRUS 18LTS', NULL,
    370000.0, 267800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11058', 'LATEX PROFESIONAL CITRUS 3,6LTS', NULL,
    98000.0, 68300.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11084', 'LATEX PROFESIONAL CONCRETO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11047', 'LATEX PROFESIONAL CONCRETO 3,6LTS', NULL,
    98000.0, 68300.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11079', 'LATEX PROFESIONAL DURAZNO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11067', 'LATEX PROFESIONAL DURAZNO 3,6LTS', NULL,
    98000.0, 68300.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11099', 'LATEX PROFESIONAL ESMERALDA 18LTS', NULL,
    465000.0, 325500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11059', 'LATEX PROFESIONAL ESMERALDA 3,6LTS', NULL,
    105000.0, 72500.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11085', 'LATEX PROFESIONAL FUCSIA VIVO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11048', 'LATEX PROFESIONAL FUCSIA VIVO 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11078', 'LATEX PROFESIONAL GRIS CLARO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11068', 'LATEX PROFESIONAL GRIS CLARO 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11077', 'LATEX PROFESIONAL MAIZ 18LTS', NULL,
    370000.0, 267800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11069', 'LATEX PROFESIONAL MAIZ 3,6LTS', NULL,
    98000.0, 68300.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11095', 'LATEX PROFESIONAL NEGRO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11060', 'LATEX PROFESIONAL NEGRO 3,6LTS', NULL,
    98000.0, 68300.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11076', 'LATEX PROFESIONAL OCRE 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11070', 'LATEX PROFESIONAL OCRE 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11086', 'LATEX PROFESIONAL ROJO BORNEO 18LTS', NULL,
    370000.0, 267800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11049', 'LATEX PROFESIONAL ROJO BORNEO 3,6LTS', NULL,
    98000.0, 68300.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11087', 'LATEX PROFESIONAL ROSA VIEJO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11050', 'LATEX PROFESIONAL ROSA VIEJO 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11075', 'LATEX PROFESIONAL SEDA 18LTS', NULL,
    370000.0, 267800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11071', 'LATEX PROFESIONAL SEDA 3,6LTS', NULL,
    98000.0, 68300.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11088', 'LATEX PROFESIONAL TANGERINA 18LTS', NULL,
    465000.0, 325000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11051', 'LATEX PROFESIONAL TANGERINA 3,6LTS', NULL,
    105000.0, 72500.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11074', 'LATEX PROFESIONAL TERRACOTA 18LTS', NULL,
    370000.0, 267800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11052', 'LATEX PROFESIONAL TERRACOTA 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11073', 'LATEX PROFESIONAL TOSTADO 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11072', 'LATEX PROFESIONAL TOSTADO 3,6LTS', NULL,
    98000.0, 68300.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11096', 'LATEX PROFESIONAL TURQUESA 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11061', 'LATEX PROFESIONAL TURQUESA 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11089', 'LATEX PROFESIONAL VAINILLA 18LTS', NULL,
    370000.0, 267800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11053', 'LATEX PROFESIONAL VAINILLA 3,6LTS', NULL,
    98000.0, 68300.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11097', 'LATEX PROFESIONAL VERDE AGUA 18LTS', NULL,
    370000.0, 267800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11062', 'LATEX PROFESIONAL VERDE AGUA 3,6LTS', NULL,
    98000.0, 68300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11090', 'LATEX PROFESIONAL VERDE MUSGO 18LTS', NULL,
    370000.0, 267800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11054', 'LATEX PROFESIONAL VERDE MUSGO 3,6LTS', NULL,
    98000.0, 68300.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11098', 'LATEX PROFESIONAL VIOLETA 18LTS', NULL,
    370000.0, 267800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11063', 'LATEX PROFESIONAL VIOLETA 3,6LTS', NULL,
    98000.0, 68300.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10182', 'LATEX SEMIBRILLO BLANCO MEGA 3.6LTS', NULL,
    150000.0, 103500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10003', 'LATEX. MAX  ARENA 3.6LTS', NULL,
    60000.0, 42200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10022', 'LATEX. MAX  AZUL MAR 18 LTS', NULL,
    210000.0, 156900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10004', 'LATEX. MAX  AZUL MAR 3.6LTS', NULL,
    60000.0, 42200.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10001', 'LATEX. MAX  BLANCO  1LT', NULL,
    20000.0, 11900.0,
    13.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10023', 'LATEX. MAX  BLANCO 18 LTS', NULL,
    210000.0, 156900.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10005', 'LATEX. MAX  BLANCO 3.6LTS', NULL,
    60000.0, 42200.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AMANECER DECO' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10024', 'LATEX. MAX  CELESTE 18 LTS', NULL,
    210000.0, 156900.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10008', 'LATEX. MAX  FUCSIA SUAVE  3.6LTS', NULL,
    70000.0, 47000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10036', 'LATEX. MAX  GRIS 18 LTS', NULL,
    210000.0, 156900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10011', 'LATEX. MAX  LILA 3.6LTS', NULL,
    60000.0, 42200.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10030', 'LATEX. MAX  MOSTAZA 18 LTS', NULL,
    210000.0, 156900.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10012', 'LATEX. MAX  MOSTAZA 3.6LTS', NULL,
    60000.0, 42200.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10031', 'LATEX. MAX  NARANJA 18 LTS', NULL,
    210000.0, 156900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10013', 'LATEX. MAX  NARANJA 3.6LTS', NULL,
    60000.0, 42200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10035', 'LATEX. MAX  TURQUESA 18 LTS', NULL,
    210000.0, 156900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX MAX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10014', 'LATEX. MAX  VERDE AGUA 3.6LTS', NULL,
    60000.0, 42200.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10850', 'LENTE PROTECTOR FX TRANSPARENTE PP113 FASCY', NULL,
    10000.0, 4635.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10769', 'LIJA AL AGUA N°220 T277', NULL,
    3000.0, 1786.0,
    47.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10770', 'LIJA AL AGUA N°240 T277', NULL,
    3000.0, 1786.0,
    141.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10771', 'LIJA AL AGUA N°400 T277', NULL,
    3000.0, 1870.0,
    150.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10772', 'LIJA AL AGUA N°500 T277', NULL,
    3000.0, 1870.0,
    147.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10763', 'LIJA AL AGUA N°60 T277', NULL,
    3000.0, 1963.0,
    96.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10773', 'LIJA AL AGUA N°600 T277', NULL,
    3000.0, 1870.0,
    141.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10764', 'LIJA AL AGUA N°80 T277', NULL,
    3000.0, 1963.0,
    33.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11238', 'LIJA AL AGUA TIGRE NRO 100', NULL,
    2000.0, 1152.0,
    70.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11239', 'LIJA AL AGUA TIGRE NRO 100  (25UNIDADES)', NULL,
    40000.0, 28800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11245', 'LIJA AL AGUA TIGRE NRO 220', NULL,
    2000.0, 1152.0,
    53.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11244', 'LIJA AL AGUA TIGRE NRO 220  (25UNIDADES)', NULL,
    40000.0, 28800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11236', 'LIJA AL AGUA TIGRE NRO 80', NULL,
    2000.0, 1152.0,
    85.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LIJAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11237', 'LIJA AL AGUA TIGRE NRO 80  (25UNIDADES)', NULL,
    40000.0, 28800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10761', 'LIJA MADERA Y PARED N°120 A257', NULL,
    2000.0, 1066.0,
    40.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11472', 'LIMPIA PIEDRA BD 5LTS', NULL,
    65000.0, 52000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10825', 'LINEA PINTOR 30M FASCY LP31 (CHOCLA)', NULL,
    31000.0, 21630.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11234', 'LLANA ACERO INOX NIVELOPRO 25CM AT933/25', NULL,
    90000.0, 65090.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11233', 'LLANA ACERO INOX NIVELOPRO 40CM AT933/40', NULL,
    135000.0, 97769.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11231', 'LLANA ACERO INOX NIVELOPRO 60CM AT933/60', NULL,
    190000.0, 137000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11232', 'LLANA ACERO INOX NIVELOPRO 80CM AT933/80', NULL,
    250000.0, 182421.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10795', 'LLANA ACERO LISA 12X35CM ATLAS GRANDE', NULL,
    55000.0, 40900.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10796', 'LLANA ACERO LISA C/ FEC 12X25CM ATLAS', NULL,
    45000.0, 31900.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10803', 'LLANA DENTADA 10X35 RF511 CASTOR', NULL,
    39000.0, 29675.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10793', 'LLANA LISA 10X35 RF510 CASTOR', NULL,
    39000.0, 29516.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10794', 'LLANA P/ EFECTOS DECORATIVOS PROFESIONAL ATLAS', NULL,
    125000.0, 95000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10790', 'LLANA PLASTICA CORRUGADA 15X26 CASTOR 024', NULL,
    12000.0, 8612.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10792', 'LLANA PLASTICA CORRUGADO 18X30 RF121', NULL,
    13000.0, 9709.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10789', 'LLANA PLASTICA P/ TEXTURA 15X26  RF325CASTOR', NULL,
    20000.0, 14768.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11336', 'MASA NIVELADORA BLASCOR DE 3KG', NULL,
    38000.0, 26500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11451', 'MASA PEQUEÑAS CORRECCIONES SHERWIN LAZZUDUR', NULL,
    25000.0, 18000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10810', 'MASCARA RESPIRATORIA FASCY 1 FILTRO', NULL,
    20000.0, 13390.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10856', 'MECHA CONCRETO 10X120MM MC010 FASCY', NULL,
    7000.0, 4326.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10857', 'MECHA CONCRETO 12X150MM MC012 FASCY', NULL,
    10000.0, 5768.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10816', 'MECHA HSS FY 10MM FASCY', NULL,
    15000.0, 10300.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10811', 'MECHA HSS FY 4MM FASCY', NULL,
    5000.0, 1751.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10812', 'MECHA HSS FY 6MM  FASCY', NULL,
    6000.0, 3399.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10813', 'MECHA HSS FY 8MM FASCY', NULL,
    10000.0, 5974.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11318', 'MEGA TEXTURA GRAFIATO BLANCO 24KG', NULL,
    130000.0, 91200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11317', 'MEGA TEXTURA HIDROREPELENTE BLANCO 24KG', NULL,
    160000.0, 113280.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11319', 'MEGA TEXTURA LISA BLANCO 24KG', NULL,
    155000.0, 109440.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11316', 'MEGA TEXTURA PROYECTADA BLANCO 24KG', NULL,
    156000.0, 110400.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11284', 'MEZCLADOR ATLAS PLASTICO AT176/3', NULL,
    7000.0, 3630.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11032', 'MEZCLADOR P/ PINTURA DE MADERA TIGRE', NULL,
    5000.0, 2100.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SIKA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11195', 'MUROCAL 1L SIKA', NULL,
    15000.0, 10000.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SIKA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11196', 'MUROCAL 5LTS SIKA', NULL,
    60000.0, 47000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SIKA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10459', 'MUROCRIL CERAMICA 5 KG', NULL,
    146000.0, 102200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SIKA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10463', 'MUROCRIL ROJO TANINO 20 KG', NULL,
    535000.0, 374700.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SIKA' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10460', 'MUROCRIL ROJO TANINO 5 KG', NULL,
    146000.0, 102200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10862', 'NEUM PISTOLA PULVERIZADOR C/ MANGUERA WG20', NULL,
    30000.0, 19520.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11359', 'NOVACOR COBRE MAIS BLANCO SHERWIN 3.6LTS', NULL,
    132000.0, 93500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10667', 'OPAL ENDUIDO INTERIOR OPAL 15KG (MASA CORRIDA)', NULL,
    40000.0, 28000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10668', 'OPAL ENDUIDO PLASTICO EXTERIOR OPAL 15KG (MASA', NULL,
    68000.0, 43220.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10587', 'OPAL ESMALTE SINTETICO OPAL 10 BEIGE 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10643', 'OPAL ESMALTE SINTETICO OPAL 10 BEIGE 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10615', 'OPAL ESMALTE SINTETICO OPAL 10 BEIGE 850CC', NULL,
    45000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10635', 'OPAL ESMALTE SINTETICO OPAL 11 MARFIL 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10607', 'OPAL ESMALTE SINTETICO OPAL 11 MARFIL 850CC', NULL,
    45000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10595', 'OPAL ESMALTE SINTETICO OPAL 12 CERAMICA 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10651', 'OPAL ESMALTE SINTETICO OPAL 12 CERAMICA 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10623', 'OPAL ESMALTE SINTETICO OPAL 12 CERAMICA 850CC', NULL,
    45000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10655', 'OPAL ESMALTE SINTETICO OPAL 13 CEDRO 3.6LTS', NULL,
    170000.0, 133591.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10627', 'OPAL ESMALTE SINTETICO OPAL 13 CEDRO 850CC', NULL,
    50000.0, 35535.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10605', 'OPAL ESMALTE SINTETICO OPAL 15 NEGRO 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10661', 'OPAL ESMALTE SINTETICO OPAL 15 NEGRO 3.6LTS', NULL,
    170000.0, 133591.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10633', 'OPAL ESMALTE SINTETICO OPAL 15 NEGRO 850CC', NULL,
    50000.0, 35535.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10626', 'OPAL ESMALTE SINTETICO OPAL 17 ALUMINIO 850CC', NULL,
    55000.0, 39037.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10637', 'OPAL ESMALTE SINTETICO OPAL 19 VERDE CLARO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10609', 'OPAL ESMALTE SINTETICO OPAL 19 VERDE CLARO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10594', 'OPAL ESMALTE SINTETICO OPAL 2 BERMELLON 250CC', NULL,
    17000.0, 12669.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10650', 'OPAL ESMALTE SINTETICO OPAL 2 BERMELLON 3.6LTS', NULL,
    170000.0, 125900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10622', 'OPAL ESMALTE SINTETICO OPAL 2 BERMELLON 850CC', NULL,
    50000.0, 35535.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10604', 'OPAL ESMALTE SINTETICO OPAL 20 GRIS OSCURO 250CC', NULL,
    17000.0, 12669.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10660', 'OPAL ESMALTE SINTETICO OPAL 20 GRIS OSCURO 3.6LTS', NULL,
    170000.0, 125900.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10632', 'OPAL ESMALTE SINTETICO OPAL 20 GRIS OSCURO 850CC', NULL,
    50000.0, 35535.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10589', 'OPAL ESMALTE SINTETICO OPAL 22 VERDE ESMERALDA', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10645', 'OPAL ESMALTE SINTETICO OPAL 22 VERDE ESMERALDA', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10617', 'OPAL ESMALTE SINTETICO OPAL 22 VERDE ESMERALDA', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10584', 'OPAL ESMALTE SINTETICO OPAL 23 CELESTE 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10640', 'OPAL ESMALTE SINTETICO OPAL 23 CELESTE 3.6LTS', NULL,
    175000.0, 140300.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10612', 'OPAL ESMALTE SINTETICO OPAL 23 CELESTE 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10596', 'OPAL ESMALTE SINTETICO OPAL 25 VIOLETA 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10652', 'OPAL ESMALTE SINTETICO OPAL 25 VIOLETA 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10624', 'OPAL ESMALTE SINTETICO OPAL 25 VIOLETA 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10592', 'OPAL ESMALTE SINTETICO OPAL 27 AZUL OSCURO 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10648', 'OPAL ESMALTE SINTETICO OPAL 27 AZUL OSCURO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10620', 'OPAL ESMALTE SINTETICO OPAL 27 AZUL OSCURO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10600', 'OPAL ESMALTE SINTETICO OPAL 28 GRIS PERLA 250CC', NULL,
    17000.0, 12669.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10656', 'OPAL ESMALTE SINTETICO OPAL 28 GRIS PERLA 3.6LTS', NULL,
    170000.0, 125900.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10628', 'OPAL ESMALTE SINTETICO OPAL 28 GRIS PERLA 850CC', NULL,
    50000.0, 35535.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10590', 'OPAL ESMALTE SINTETICO OPAL 3 NARANJA 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10646', 'OPAL ESMALTE SINTETICO OPAL 3 NARANJA 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10618', 'OPAL ESMALTE SINTETICO OPAL 3 NARANJA 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10593', 'OPAL ESMALTE SINTETICO OPAL 30 VERDE LIMON 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10649', 'OPAL ESMALTE SINTETICO OPAL 30 VERDE LIMON 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10621', 'OPAL ESMALTE SINTETICO OPAL 30 VERDE LIMON 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10597', 'OPAL ESMALTE SINTETICO OPAL 31 VERDE INGLES 250CC', NULL,
    17000.0, 12669.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10653', 'OPAL ESMALTE SINTETICO OPAL 31 VERDE INGLES 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10625', 'OPAL ESMALTE SINTETICO OPAL 31 VERDE INGLES 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10644', 'OPAL ESMALTE SINTETICO OPAL 32 AZULEJO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10616', 'OPAL ESMALTE SINTETICO OPAL 32 AZULEJO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10658', 'OPAL ESMALTE SINTETICO OPAL 35 DORADO 3.6LTS', NULL,
    400000.0, 319300.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10630', 'OPAL ESMALTE SINTETICO OPAL 35 DORADO 850CC', NULL,
    115000.0, 85902.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10639', 'OPAL ESMALTE SINTETICO OPAL 36 CREMA 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10611', 'OPAL ESMALTE SINTETICO OPAL 36 CREMA 850CC', NULL,
    50000.0, 36200.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10634', 'OPAL ESMALTE SINTETICO OPAL 4 AMARILLO 3.6LTS', NULL,
    158000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10606', 'OPAL ESMALTE SINTETICO OPAL 4 AMARILLO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10642', 'OPAL ESMALTE SINTETICO OPAL 5 ROSADO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10614', 'OPAL ESMALTE SINTETICO OPAL 5 ROSADO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10638', 'OPAL ESMALTE SINTETICO OPAL 56 AMA. MEDIANO', NULL,
    170000.0, 133591.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10610', 'OPAL ESMALTE SINTETICO OPAL 56 AMA. MEDIANO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10657', 'OPAL ESMALTE SINTETICO OPAL 6 VERDE OSCURO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10629', 'OPAL ESMALTE SINTETICO OPAL 6 VERDE OSCURO 850CC', NULL,
    50000.0, 33500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10641', 'OPAL ESMALTE SINTETICO OPAL 7 VERDE MUSGO 3.6LTS', NULL,
    170000.0, 125900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10882', 'OPAL ESMALTE SINTETICO OPAL BLANCO 850CC', NULL,
    50000.0, 35535.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10555', 'OPAL OPALATEX AMARILLO 3.6LTS', NULL,
    45000.0, 34000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10542', 'OPAL OPALATEX ARENA 3.6LTS', NULL,
    50000.0, 34000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10543', 'OPAL OPALATEX BLANCO 3.6LTS', NULL,
    45000.0, 34000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10544', 'OPAL OPALATEX BLANCO HIELO 3.6LTS', NULL,
    45000.0, 34000.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10545', 'OPAL OPALATEX CERAMICA 3.6LTS', NULL,
    45000.0, 34000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10546', 'OPAL OPALATEX DURAZNO 3.6LTS', NULL,
    50000.0, 34000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10558', 'OPAL OPALATEX FUCSIA 3.6LTS', NULL,
    45000.0, 34000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10573', 'OPAL OPALATEX GRANDE AMARILLO 18LT', NULL,
    165000.0, 129800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10560', 'OPAL OPALATEX GRANDE ARENA 18LT', NULL,
    180000.0, 136300.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10561', 'OPAL OPALATEX GRANDE BLANCO 18LT', NULL,
    180000.0, 129800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10562', 'OPAL OPALATEX GRANDE BLANCO HIELO 18LT', NULL,
    180000.0, 136290.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10563', 'OPAL OPALATEX GRANDE CERAMICA 18LT', NULL,
    180000.0, 132201.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10564', 'OPAL OPALATEX GRANDE DURAZNO 18LT', NULL,
    180000.0, 129800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10576', 'OPAL OPALATEX GRANDE FUCSIA 18LT', NULL,
    180000.0, 129800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10575', 'OPAL OPALATEX GRANDE GRIS HUMO 18LT', NULL,
    180000.0, 129800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10577', 'OPAL OPALATEX GRANDE LILA 18LT', NULL,
    180000.0, 129800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10565', 'OPAL OPALATEX GRANDE MANDARINA 18LT', NULL,
    180000.0, 129800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10566', 'OPAL OPALATEX GRANDE OCRE 18LT', NULL,
    180000.0, 129800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10567', 'OPAL OPALATEX GRANDE TRIGO 18LT', NULL,
    180000.0, 129800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10568', 'OPAL OPALATEX GRANDE TURQUESA 18LT', NULL,
    180000.0, 129800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10574', 'OPAL OPALATEX GRANDE VERDE AGUA 18LT', NULL,
    180000.0, 129800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10569', 'OPAL OPALATEX GRANDE VERDE FLORESTA  18LT', NULL,
    180000.0, 129800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10572', 'OPAL OPALATEX GRANDE VERDE LIMON 18LT', NULL,
    180000.0, 129800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10571', 'OPAL OPALATEX GRANDE ZANAHORIA 18LT', NULL,
    180000.0, 129800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10557', 'OPAL OPALATEX GRIS HUMO 3.6LTS', NULL,
    50000.0, 34000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10559', 'OPAL OPALATEX LILA 3.6LTS', NULL,
    50000.0, 34000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10547', 'OPAL OPALATEX MANDARINA 3.6LTS', NULL,
    50000.0, 34000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10548', 'OPAL OPALATEX OCRE 3.6LTS', NULL,
    50000.0, 34000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10549', 'OPAL OPALATEX TRIGO  3.6LTS', NULL,
    50000.0, 34000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10550', 'OPAL OPALATEX TURQUESA 3.6LTS', NULL,
    50000.0, 34000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10556', 'OPAL OPALATEX VERDE AGUA 3.6LTS', NULL,
    50000.0, 34000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10551', 'OPAL OPALATEX VERDE FLORESTA 3.6LTS', NULL,
    50000.0, 34000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10554', 'OPAL OPALATEX VERDE LIMON 3.6LTS', NULL,
    50000.0, 34000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10552', 'OPAL OPALATEX VERDE MANZANA 3.6LTS', NULL,
    50000.0, 34000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10553', 'OPAL OPALATEX ZANAHORIA 3.6LTS', NULL,
    50000.0, 34000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10601', 'OPAL SINTETICO 6 VERDE OSCURO 250CC', NULL,
    19000.0, 12900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10585', 'OPAL SINTETICO 7 VERDE MUSGO 250CC', NULL,
    19000.0, 12900.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10982', 'OPALATEX GRANDE VERDE MANZANA 18 LTS', NULL,
    180000.0, 129800.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11135', 'PANEL RIPADO  17CMX2.80 4 RANURAS', NULL,
    120000.0, 88000.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11136', 'PANEL RIPADO  17CMX2.80 6 RANURAS', NULL,
    90000.0, 68000.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11112', 'PATINA BAUTECH MARRON 1KG', NULL,
    8000.0, 5500.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11111', 'PATINA QUARTZOLI BEIGE 1KG', NULL,
    8000.0, 6000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11113', 'PATINA QUARTZOLI BLANCO 1KG', NULL,
    8000.0, 6000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11115', 'PATINA QUARTZOLI CARAMELO 1KG', NULL,
    8000.0, 6000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11114', 'PATINA QUARTZOLI GRIS / CINZA 1KG', NULL,
    8000.0, 6000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PATINAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11110', 'PATINA QUARTZOLI NEGRO 1KG', NULL,
    8000.0, 6000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11125', 'PAVIMENTO AMARILLO 18 LTS', NULL,
    945000.0, 709400.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10866', 'PAVIMENTO NEGRO 18 LTS', NULL,
    812000.0, 567800.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10867', 'PAVIMENTO NEGRO 3,6 LTS', NULL,
    178000.0, 124400.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11230', 'PENTRILO PLASTICO C/CINTA 20MX120CM 9623', NULL,
    50000.0, 35888.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11229', 'PENTRILO PLASTICO C/CINTA 20MX60CM 9621', NULL,
    35000.0, 24800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11117', 'PIGMENTO EN POLVO MARRON BAUTECH  500GR', NULL,
    25000.0, 17500.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11119', 'PIGMENTO EN POLVO NEGRO BAUTECH  500GR', NULL,
    25000.0, 17500.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11028', 'PIGMENTO EN POLVO ROJO BAUTECH  500GR', NULL,
    25000.0, 17000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11118', 'PIGMENTO EN POLVO VERDE BAUTECH  500GR', NULL,
    25000.0, 17500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10747', 'PINCEL TIGRE AZUL 728 1/2"', NULL,
    3000.0, 1850.0,
    29.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10746', 'PINCEL TIGRE AZUL 728 3/4"', NULL,
    4000.0, 1850.0,
    19.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10745', 'PINCEL TIGRE AZUL 728 4"', NULL,
    24000.0, 16100.0,
    38.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10736', 'PINCEL TIGRE AZUL REF 728 1"', NULL,
    5000.0, 2016.0,
    46.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10742', 'PINCEL TIGRE RF518 MARRON 2"', NULL,
    18000.0, 7300.0,
    42.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11172', 'PINTURA ATERMICA  MARFIL 3.6 LTS', NULL,
    195000.0, 145000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11171', 'PINTURA ATERMICA ARENA 3.6 LTS', NULL,
    195000.0, 145000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11170', 'PINTURA ATERMICA BLANCO 3.6 LTS', NULL,
    195000.0, 145000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10343', 'PINTURA EN AEROSOL ALTA TEMPERATURA', NULL,
    50000.0, 35000.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10337', 'PINTURA EN AEROSOL ALTA TEMPERATURA  NEGRO 1200', NULL,
    50000.0, 35000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10335', 'PINTURA EN AEROSOL ALUMINIO -1680', NULL,
    37000.0, 25400.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10358', 'PINTURA EN AEROSOL AMARILLO FLUOR-1005', NULL,
    39000.0, 27300.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10351', 'PINTURA EN AEROSOL CELESTE-15', NULL,
    25000.0, 18300.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10348', 'PINTURA EN AEROSOL CROMADO-3012', NULL,
    35000.0, 25400.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10346', 'PINTURA EN AEROSOL GRIS-22', NULL,
    25000.0, 18300.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10345', 'PINTURA EN AEROSOL MARRON-29', NULL,
    25000.0, 18300.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10356', 'PINTURA EN AEROSOL NARANJA FLUOR-1011', NULL,
    39000.0, 27300.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10354', 'PINTURA EN AEROSOL NARANJA-31', NULL,
    25000.0, 18300.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10336', 'PINTURA EN AEROSOL ORO-188', NULL,
    35000.0, 25400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10359', 'PINTURA EN AEROSOL ROSA-30', NULL,
    25000.0, 18300.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10349', 'PINTURA EN AEROSOL TRANSPARENTE-190', NULL,
    25000.0, 18300.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10355', 'PINTURA EN AEROSOL VERDE FLUOR-1003', NULL,
    39000.0, 27300.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10347', 'PINTURA EN AEROSOL VERDE-37', NULL,
    25000.0, 18300.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10357', 'PINTURA EN AEROSOL VIOLETA-603', NULL,
    25000.0, 18300.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10127', 'PINTURA PARA PISOS AZUL 18 LTS', NULL,
    450000.0, 337400.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10123', 'PINTURA PARA PISOS GRIS 3.6LTS', NULL,
    105000.0, 75900.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10131', 'PINTURA PARA PISOS NEGRO 18 LTS', NULL,
    450000.0, 337400.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10124', 'PINTURA PARA PISOS NEGRO 3.6LTS', NULL,
    105000.0, 75900.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10132', 'PINTURA PARA PISOS ROJO TANINO 18 LTS', NULL,
    450000.0, 337400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10125', 'PINTURA PARA PISOS ROJO TANINO 3.6LTS', NULL,
    105000.0, 75900.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'LATEX PISOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10133', 'PINTURA PARA PISOS VERDE TENIS 18 LTS', NULL,
    450000.0, 337400.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11396', 'PISOS KISACRIL NEGRO 3.6LTS', NULL,
    105000.0, 76000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11397', 'PISOS KISACRIL NEGRO SEMIBRILLO 3.6LTS', NULL,
    115000.0, 80000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11183', 'PISOS Y BORDES ATERMICOS PISCINA BLANCO 10 LTS', NULL,
    530000.0, 345750.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11155', 'PISOS Y BORDES ATERMICOS PISCINA BLANCO 4 LTS', NULL,
    206000.0, 143900.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10858', 'PISTOLA DE PINTAR FASCY 1000CC 1.8MM H1000W FASCY', NULL,
    238000.0, 169950.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10860', 'PISTOLA DE PINTAR FASCY 400CC 1.5MM H400W FASCY', NULL,
    135000.0, 87550.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10859', 'PISTOLA DE PINTAR FASCY 600CC 1.4MM H827W FASCY', NULL,
    210000.0, 144200.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10861', 'PISTOLA DE PINTAR FASCY 750CC VD90 FASCY', NULL,
    105000.0, 72100.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11033', 'PISTOLA P/ PINTAR FY TEXTURADO 5L', NULL,
    185000.0, 123600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11179', 'PIZARRON NEGRO 850CC', NULL,
    70000.0, 49400.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10733', 'PIZARRON VERDE 250 CC', NULL,
    25000.0, 18800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10734', 'PIZARRON VERDE 850 CC', NULL,
    70000.0, 49400.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10382', 'PROT. P/ MADERA STAIN CAOBA 850 CC', NULL,
    77000.0, 54100.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10383', 'PROT. P/ MADERA STAIN CEDRO 850 CC', NULL,
    77000.0, 54100.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10384', 'PROT. P/ MADERA STAIN NATURAL 850 CC', NULL,
    77000.0, 54100.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10385', 'PROT. P/ MADERA STAIN NOGAL 850 CC', NULL,
    77000.0, 54100.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11444', 'PULVERIZADOR 2L RIO NARANJA', NULL,
    30000.0, 19000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11184', 'PVC', NULL,
    43000.0, 39000.0,
    19980.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11218', 'RECUBLOCK ANTIHUMENDAD 3.6 LTS SINTEPLAST', NULL,
    648000.0, 453550.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11146', 'RECUBLOCK CIMIENTOS BOLSA 5KG', NULL,
    130000.0, 88100.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11145', 'RECUBRIPLAST CUBRE TODO 3.6B KG SINTEPLAST', NULL,
    283000.0, 197700.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11144', 'RECUBRIPLAST CUBRE TODO 900 GR SINTEPLAST', NULL,
    75000.0, 57167.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11156', 'RECUPLAST GRIETAS Y JUNTAS BLANCOS 1 KG', NULL,
    64000.0, 44550.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11157', 'RECUPLAST GRIETAS Y JUNTAS BLANCOS 5 KG', NULL,
    249000.0, 174250.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'PVC' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11153', 'RECUPLAST TECHOS GRIS 18 LTS SINTEPLAST', NULL,
    805000.0, 641900.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'AEROSOL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10512', 'REMOVEDOR EN AEROSOL AMANECER', NULL,
    28000.0, 19500.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE AMANECER' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10511', 'REMOVEDORES DE PINTURA 1 LT', NULL,
    39000.0, 27100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11213', 'REPUESTO PISTOLA FASCY 400CC', NULL,
    40000.0, 25750.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11102', 'RODILLO  P/  TEXTURA FINA 110/75 23CM ATLAS', NULL,
    35000.0, 22300.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10908', 'RODILLO ANTIGOTAS ATLAS 23CM 321/100', NULL,
    35000.0, 25500.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10782', 'RODILLO ANTIGOTAS TIGRE 90MM RF1377 PROFESIONAL', NULL,
    12000.0, 8500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11256', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 15CM RF1375', NULL,
    13000.0, 8832.0,
    19.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10781', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 23CM RF1374', NULL,
    20000.0, 9264.0,
    77.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11255', 'RODILLO ANTIGOTEO ESTANDAR TIGRE 9CM RF1375', NULL,
    10000.0, 6528.0,
    20.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11360', 'RODILLO BYP 10" COVER MAX PLUS ACRIL 3/4', NULL,
    45000.0, 32000.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10784', 'RODILLO DE ESPUMA TIGRE 40MM  RF1345', NULL,
    3000.0, 1400.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10945', 'RODILLO DE ESPUMA TIGRE RF 1341-15CM', NULL,
    9000.0, 5500.0,
    19.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11340', 'RODILLO DRYWALL 23CM AT321/80 ATLAS', NULL,
    24000.0, 16601.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11131', 'RODILLO ESPUMA  ATLAS 15CM 406/15A POLYESTER', NULL,
    15000.0, 8472.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11130', 'RODILLO ESPUMA  ATLAS 23CM 406/230 POLYESTER', NULL,
    35000.0, 24800.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11132', 'RODILLO ESPUMA  ATLAS 5CM 406/5A POLYESTER', NULL,
    12000.0, 6764.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10950', 'RODILLO ESPUMA TIGRE 1330-23CM', NULL,
    20000.0, 13150.0,
    25.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10973', 'RODILLO FELPA ARTISAN 1/2 9° FARBE', NULL,
    20000.0, 14000.0,
    75.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11204', 'RODILLO LANA CARNEIRO ATLAS 23CM 328/22', NULL,
    35000.0, 21000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10947', 'RODILLO LANA TIGRE RF 1346-15CM', NULL,
    25000.0, 17400.0,
    23.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10946', 'RODILLO LANA TIGRE RF 1346-9CM', NULL,
    18000.0, 12300.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11343', 'RODILLO NIVELO PRO AT1122/23 ATLAS', NULL,
    60000.0, 40865.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11104', 'RODILLO P/  TEXTURA  RUSTICA  11550 23CM  ATLAS', NULL,
    60000.0, 44600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11103', 'RODILLO P/  TEXTURA  RUSTICA  AT1155/5 5CM  ATLAS', NULL,
    20000.0, 14800.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10778', 'RODILLO P/ TEXTURA CONDOR10CM RF969', NULL,
    30000.0, 23000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10921', 'RODILLO RENDEPLUS 46CM AT927/19', NULL,
    40000.0, 27200.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10911', 'RODILLO RESIMAX ATLAS 15CM 339/15A', NULL,
    17000.0, 12000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ATLAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10910', 'RODILLO RESIMAX ATLAS 23CM 339/5A', NULL,
    38000.0, 27415.0,
    17.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11342', 'RODILLO TEXTURA RUSTICA AT1155/10SR ATLAS', NULL,
    35000.0, 24905.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11133', 'SACA MANCHAS PISO TITAN CLEAN 1L', NULL,
    20000.0, 10000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11129', 'SACA MANCHAS PISO TITAN CLEAN 5LT', NULL,
    80000.0, 50000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11127', 'SALVA PISOS 1MX25MTS PROTECTOR PARA PISOS', NULL,
    180000.0, 150000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11128', 'SALVA PISOS 1MX25MTS PROTECTOR PARA PISOS X', NULL,
    10000.0, 9500.0,
    25.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11273', 'SELLADOR FLEXOPAL 5LTS', NULL,
    85000.0, 61697.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10420', 'SELLADOR P/ MAD. ECONOMICO 1 LT', NULL,
    54000.0, 37500.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11299', 'SELLADOR PIGMENTADO BLASCOR 18LTS', NULL,
    148000.0, 117000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'BRILLALUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11298', 'SELLADOR PIGMENTADO BLASCOR 3.6LTS', NULL,
    45000.0, 34200.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11044', 'SELLAFLEX SELLADOR ACRILICO PROFESIONAL 3,6LTS', NULL,
    83000.0, 58200.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10852', 'SIERRA COPA TCT CONCRETO 55MM EN KIT', NULL,
    68000.0, 48410.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SELLADOR' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10853', 'SIERRA COPA TCT CONCRETO 65MM EN KIT', NULL,
    80000.0, 55620.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ADHESIVOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10954', 'SIKAFLEX 1A PLUS SELLADOR/ SELLANTE', NULL,
    72000.0, 55000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10971', 'SILICONA ACETICA 280G BLANCO TEKBOND', NULL,
    28000.0, 20000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10970', 'SILICONA ACETICA 280G NEGRO TEKBOND', NULL,
    28000.0, 20000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11382', 'SINTETICO BELLACASA BASE A 0.9LTS', NULL,
    41000.0, 28900.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11383', 'SINTETICO BELLACASA BASE A 3.6LTS', NULL,
    135000.0, 96050.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11384', 'SINTETICO BELLACASA BASE B 0.9LTS', NULL,
    40000.0, 28050.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11385', 'SINTETICO BELLACASA BASE B 3.6LTS', NULL,
    130000.0, 93500.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10730', 'SINTETICO BRILLALUX 2EN1  PERLA (GRIS) 3,6 LTS', NULL,
    205000.0, 152600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10729', 'SINTETICO BRILLALUX 2EN1 AZUL FRANCIA 3,6 LTS', NULL,
    205000.0, 152600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10720', 'SINTETICO BRILLALUX 2EN1 BLANCO  3,6 LTS', NULL,
    205000.0, 152600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10732', 'SINTETICO BRILLALUX 2EN1 CREMA 3,6 LTS', NULL,
    205000.0, 152600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10728', 'SINTETICO BRILLALUX 2EN1 ESMERALDA 3,6 LTS', NULL,
    205000.0, 152600.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10727', 'SINTETICO BRILLALUX 2EN1 GRIS 3,6 LTS', NULL,
    205000.0, 152600.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10725', 'SINTETICO BRILLALUX 2EN1 MARRON COÑAC 3,6 LTS', NULL,
    205000.0, 152600.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10724', 'SINTETICO BRILLALUX 2EN1 NEGRO 3,6 LTS', NULL,
    732000.0, 562400.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10726', 'SINTETICO BRILLALUX ALUMINIO 3,6 LTS', NULL,
    185000.0, 145300.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SINTETICO KILLING' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10699', 'SINTETICO BRILLALUX OCRE 850 CC', NULL,
    50000.0, 37500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11100', 'SINTETICO CUBRELUX  3EN1 ANTIOX. BLANCO 18 LTS', NULL,
    815000.0, 570500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10313', 'SINTETICO CUBRELUX  3EN1 ANTIOX. BLANCO 3,6 LTS', NULL,
    155000.0, 117000.0,
    15.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10245', 'SINTETICO CUBRELUX AMARILLO 250 CC', NULL,
    17000.0, 12100.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10291', 'SINTETICO CUBRELUX AMARILLO 3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10268', 'SINTETICO CUBRELUX AMARILLO 850 CC', NULL,
    45000.0, 30000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10260', 'SINTETICO CUBRELUX AZUL 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10306', 'SINTETICO CUBRELUX AZUL 3,6 LTS', NULL,
    155000.0, 117000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10283', 'SINTETICO CUBRELUX AZUL 850 CC', NULL,
    45000.0, 30000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10271', 'SINTETICO CUBRELUX AZUL FRANCIA 850 CC', NULL,
    45000.0, 30000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10292', 'SINTETICO CUBRELUX BERMELLON 3,6 LTS', NULL,
    155000.0, 117000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10269', 'SINTETICO CUBRELUX BERMELLON 850 CC', NULL,
    45000.0, 30000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10254', 'SINTETICO CUBRELUX BLANCO 250 CC', NULL,
    17000.0, 12100.0,
    11.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10300', 'SINTETICO CUBRELUX BLANCO 3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10277', 'SINTETICO CUBRELUX BLANCO 850 CC', NULL,
    45000.0, 30000.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11109', 'SINTETICO CUBRELUX CEDRO 18 LTS', NULL,
    815000.0, 570500.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10251', 'SINTETICO CUBRELUX CEDRO 250 CC', NULL,
    17000.0, 12100.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10297', 'SINTETICO CUBRELUX CEDRO 3,6 LTS', NULL,
    155000.0, 117000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10274', 'SINTETICO CUBRELUX CEDRO 850 CC', NULL,
    45000.0, 30000.0,
    12.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10255', 'SINTETICO CUBRELUX CELESTE  250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10301', 'SINTETICO CUBRELUX CELESTE  3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10278', 'SINTETICO CUBRELUX CELESTE  850 CC', NULL,
    45000.0, 30000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10258', 'SINTETICO CUBRELUX CERAMICA 250 CC', NULL,
    17000.0, 12100.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10304', 'SINTETICO CUBRELUX CERAMICA 3,6 LTS', NULL,
    155000.0, 117000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10281', 'SINTETICO CUBRELUX CERAMICA 850 CC', NULL,
    45000.0, 30000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10262', 'SINTETICO CUBRELUX FUCSIA 250 CC', NULL,
    17000.0, 12100.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10308', 'SINTETICO CUBRELUX FUCSIA 3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10285', 'SINTETICO CUBRELUX FUCSIA 850 CC', NULL,
    45000.0, 30000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10249', 'SINTETICO CUBRELUX GRIS 250 CC', NULL,
    17000.0, 12100.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10295', 'SINTETICO CUBRELUX GRIS 3,6 LTS', NULL,
    155000.0, 117000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10272', 'SINTETICO CUBRELUX GRIS 850 CC', NULL,
    45000.0, 30000.0,
    7.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10256', 'SINTETICO CUBRELUX GRIS ESPACIAL 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10302', 'SINTETICO CUBRELUX GRIS ESPACIAL 3,6 LTS', NULL,
    155000.0, 117000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10279', 'SINTETICO CUBRELUX GRIS ESPACIAL 850 CC', NULL,
    45000.0, 30000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10263', 'SINTETICO CUBRELUX MARFIL 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10309', 'SINTETICO CUBRELUX MARFIL 3,6 LTS', NULL,
    155000.0, 117000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10286', 'SINTETICO CUBRELUX MARFIL 850 CC', NULL,
    45000.0, 30000.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10259', 'SINTETICO CUBRELUX MARRON CLARO 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10305', 'SINTETICO CUBRELUX MARRON CLARO 3,6 LTS', NULL,
    155000.0, 117000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10282', 'SINTETICO CUBRELUX MARRON CLARO 850 CC', NULL,
    45000.0, 30000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10250', 'SINTETICO CUBRELUX MARRON TABACO 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10296', 'SINTETICO CUBRELUX MARRON TABACO 3,6 LTS', NULL,
    155000.0, 117000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10273', 'SINTETICO CUBRELUX MARRON TABACO 850 CC', NULL,
    45000.0, 30000.0,
    16.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10257', 'SINTETICO CUBRELUX NARANJA 250 CC', NULL,
    17000.0, 12100.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10303', 'SINTETICO CUBRELUX NARANJA 3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10280', 'SINTETICO CUBRELUX NARANJA 850 CC', NULL,
    45000.0, 30000.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10253', 'SINTETICO CUBRELUX NEGRO  250 CC', NULL,
    17000.0, 12100.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10299', 'SINTETICO CUBRELUX NEGRO  3,6 LTS', NULL,
    155000.0, 117000.0,
    8.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10276', 'SINTETICO CUBRELUX NEGRO  850 CC', NULL,
    45000.0, 30000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10261', 'SINTETICO CUBRELUX VERDE CLARO 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10307', 'SINTETICO CUBRELUX VERDE CLARO 3,6 LTS', NULL,
    155000.0, 117000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10284', 'SINTETICO CUBRELUX VERDE CLARO 850 CC', NULL,
    45000.0, 30000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10247', 'SINTETICO CUBRELUX VERDE INGLES 250 CC', NULL,
    17000.0, 12100.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10293', 'SINTETICO CUBRELUX VERDE INGLES 3,6 LTS', NULL,
    155000.0, 117000.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11134', 'SOLUPAN', NULL,
    25000.0, 20000.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'CUBRELUX' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11203', 'SOPORTE P/ LIJA MANUAL TIGRE PRO 23X8CM', NULL,
    40000.0, 27504.0,
    10.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11347', 'SOPORTE P/LIJA 100/4 ATLAS', NULL,
    69000.0, 48914.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10925', 'SOPORTE RODILLO 46CM ATLAS AT360/46', NULL,
    130000.0, 91684.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11225', 'SR GRIS MUNSELL 3,6LTS BLASCOR', NULL,
    165000.0, 127000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11328', 'SR GRIS SCANIA 3,6LTS BLASCOR', NULL,
    195000.0, 139465.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11263', 'SUVINIL SINTETICO BRILLANTE BLANCO 900ML', NULL,
    55000.0, 42827.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11264', 'SUVINIL SINTETICO BRILLANTE NEGRO 900ML', NULL,
    55000.0, 42827.0,
    6.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11305', 'SUVINIL TOQUE BRILLO ALGODON EGIPCIO 18LTS', NULL,
    895000.0, 721582.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11268', 'SUVINIL TOQUE BRILLO S/B  BLANCO NIEVE 18LTS', NULL,
    895000.0, 721583.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11266', 'SUVINIL TOQUE BRILLO S/B BLANCO NIEVE 3.6LTS', NULL,
    198000.0, 163463.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11324', 'SUVINIL TOQUE CLASICO BLANCO NIEVE 18LTS', NULL,
    575000.0, 460753.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11292', 'SUVINIL TOQUE CLASSICA ARENA 3.6LTS', NULL,
    135000.0, 109077.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11291', 'SUVINIL TOQUE CLASSICA BLANCO NIEVE 3.6LTS', NULL,
    135000.0, 109077.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11290', 'SUVINIL TOQUE DE SEDA BLANCO NIEVE 3.6LTS', NULL,
    225000.0, 181542.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11296', 'SUVINIL TOQUE FOSCO  ARENA 18LTS', NULL,
    695000.0, 569374.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11267', 'SUVINIL TOQUE FOSCO  BLANCO NIEVE 18LTS', NULL,
    695000.0, 569375.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11445', 'SUVINIL TOQUE FOSCO  CREMA DE MANI 18LTS', NULL,
    810000.0, 620000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11449', 'SUVINIL TOQUE FOSCO  DULCE DE LECHE 18LTS', NULL,
    960000.0, 779400.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11446', 'SUVINIL TOQUE FOSCO  SERTON 3.6LTS', NULL,
    190000.0, 148050.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11288', 'SUVINIL TOQUE FOSCO ALGODON EGIPCIO 3.6LTS', NULL,
    170000.0, 135456.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11286', 'SUVINIL TOQUE FOSCO ARENA 3.6LTS', NULL,
    170000.0, 135456.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11270', 'SUVINIL TOQUE FOSCO BASE 3.6LTS', NULL,
    170000.0, 135456.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11265', 'SUVINIL TOQUE FOSCO BLANCO NIEVE 3.6LTS', NULL,
    170000.0, 135456.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11289', 'SUVINIL TOQUE FOSCO ELEFANTE 3.6LTS', NULL,
    170000.0, 135456.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SUVINIL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11468', 'SUVINIL TOQUE FOSCO GALLETA DE CHAMPAGNE B268', NULL,
    55000.0, 40500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11349', 'TACO PARA LIJA 100/1 ATLAS', NULL,
    28000.0, 19944.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11164', 'TECHOPAL FIBRADO BLANCO 20KG', NULL,
    370000.0, 265225.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11163', 'TECHOPAL FIBRADO BLANCO 4KG', NULL,
    80000.0, 58401.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11162', 'TECHOPAL FIBRADO CERAMICA 4KG', NULL,
    80000.0, 58401.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10669', 'TECHOPAL FIBRADO CERAMICO 20KG', NULL,
    370000.0, 257500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'HERRAMIENTAS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10670', 'TECHOPAL FIBRADO GRIS 20KG', NULL,
    370000.0, 250000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11160', 'TECHOPAL FIBRADO GRIS 4KG', NULL,
    80000.0, 58401.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11165', 'TECHOPAL FIBRADO VERDE 20KG', NULL,
    370000.0, 265225.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10976', 'TELA TIPO BIDIN SUPREMA (TELA VINILICA) X ROLLO', NULL,
    350000.0, 234000.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10901', 'TELA VINILICA SUPREMA X METRO', NULL,
    8000.0, 2385.0,
    76.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11333', 'TEXTURA GRAFIATO BLASCOR BLANCO 15KG', NULL,
    95000.0, 68640.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10957', 'TEXTURADO CLASICO AMANECER PREMIUM 6KG', NULL,
    65000.0, 50300.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11017', 'TEXTURADO FINO QUARTZO BLANCO 25KG', NULL,
    240000.0, 168000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11014', 'TEXTURADO FINO QUARTZO BLANCO 6KG', NULL,
    63000.0, 44100.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11173', 'TEXTURADO FINO QUARTZO CHINA DOLL  25KG', NULL,
    240000.0, 168000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11015', 'TEXTURADO FINO QUARTZO CHINA DOLL 6KG', NULL,
    63000.0, 44100.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11018', 'TEXTURADO FINO QUARTZO CLAY 25KG', NULL,
    240000.0, 168000.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'IMPERMEABILIZANTE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11016', 'TEXTURADO FINO QUARTZO CLAY 6KG', NULL,
    63000.0, 44100.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11329', 'THINNER 4L 010 BLASCOR', NULL,
    80000.0, 60502.0,
    3.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10502', 'THINNER AMANECER UNIVERSAL 1 LT (040)', NULL,
    22000.0, 15300.0,
    16.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10504', 'THINNER AMANECER UNIVERSAL 18 LTS', NULL,
    385000.0, 295300.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10501', 'THINNER AMANECER UNIVERSAL 325 CC', NULL,
    9000.0, 6300.0,
    53.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10503', 'THINNER AMANECER UNIVERSAL 5 LTS', NULL,
    117000.0, 81800.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11167', 'THINNER BLASCOR 020 1LT', NULL,
    20000.0, 15700.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'GENERAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10774', 'THINNER OPAL UNIVERSAL 1LT (010)', NULL,
    15000.0, 11500.0,
    27.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10981', 'THINNER OPAL UNIVERSAL 325CC', NULL,
    8000.0, 5800.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11259', 'TIGRE PRO BALDE DE MANO 2LT 2309-01', NULL,
    28000.0, 19680.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11251', 'TIGRE PRO EXTENSOR 0.9 MTS 1309 -01', NULL,
    130000.0, 95040.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11252', 'TIGRE PRO EXTENSOR 1.5 MTS 1309 -15', NULL,
    160000.0, 114240.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11253', 'TIGRE PRO EXTENSOR 2.7 MTS 1309 -27', NULL,
    190000.0, 145920.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11248', 'TIGRE PRO LLANA ALISADORA 2190 - 25CM', NULL,
    45000.0, 25440.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11249', 'TIGRE PRO LLANA ALISADORA 2190 - 40CM', NULL,
    70000.0, 41280.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11258', 'TIGRE PRO SOPORTE LLANA 2160', NULL,
    65000.0, 46080.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11460', 'TINGIDOR MUEBLES  CEDRO BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11461', 'TINGIDOR MUEBLES  CEREZA BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11462', 'TINGIDOR MUEBLES  IPE BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11463', 'TINGIDOR MUEBLES  MIEL BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11464', 'TINGIDOR MUEBLES  MOGNO BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11465', 'TINGIDOR MUEBLES  NARANJA BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    1.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'SOLVENTE OPAL' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11466', 'TINGIDOR MUEBLES  NEGRO BLASCOR 225ML', NULL,
    28000.0, 21451.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11038', 'TINTA LUSTRE AMANECER CEDRO 3.6LTS', NULL,
    269000.0, 188500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11037', 'TINTA LUSTRE AMANECER CEDRO 850CC', NULL,
    72000.0, 50200.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11141', 'ULTRA PISO DE BLASCOR 18LT', NULL,
    1100000.0, 880000.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11140', 'ULTRA PISO DE BLASCOR 3,6LTS GRIS OSCURO', NULL,
    260000.0, 192632.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11297', 'UNION PVC', NULL,
    48000.0, 40000.0,
    9.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '10776', 'VARIOS', NULL,
    1100.0, 1000.0,
    9982.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11358', 'VEDACALHA 280GR ADHESIVO', NULL,
    28000.0, 18500.0,
    4.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11207', 'VOLTEADOR 11X5 ALUMINIO', NULL,
    35000.0, 24700.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11025', 'XADREZ EN POLVO NEGRO 500GR', NULL,
    30000.0, 22500.0,
    0.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'TINTA LUSTRE' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11026', 'XADREZ EN POLVO VERDE 500GR', NULL,
    30000.0, 22500.0,
    2.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;
  SELECT id INTO v_cat_id FROM ferrecolor.categorias_productos
  WHERE empresa_id = v_empresa_id AND nombre = 'ENDUIDOS' LIMIT 1;
  INSERT INTO ferrecolor.productos (
    empresa_id, sku, nombre, codigo_barras,
    precio_venta, costo_promedio,
    stock_actual, stock_minimo, unidad_medida,
    metodo_valuacion, controla_stock,
    es_vendible, es_insumo, categoria_principal_id
  ) VALUES (
    v_empresa_id, '11024', 'YESO NACIONAL 2KG', NULL,
    13000.0, 8625.0,
    5.0, 0.0, 'UNIDAD',
    'cpp', true,
    true, false, v_cat_id
  ) ON CONFLICT DO NOTHING;
  v_ins := v_ins + 1;

  RAISE NOTICE '=== IMPORT OK: % productos ===', v_ins;
END $do$;

COMMIT;

NOTIFY pgrst, 'reload schema';

-- Verificación
SELECT count(*) AS productos FROM ferrecolor.productos;
SELECT count(*) AS categorias FROM ferrecolor.categorias_productos;
SELECT round(sum(precio_venta * stock_actual))::text AS valorizado_venta FROM ferrecolor.productos;
