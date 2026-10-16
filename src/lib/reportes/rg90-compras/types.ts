/**
 * Tipos del reporte RG90 — Libro de COMPRAS (Resolución General 90/2021 SET/DNIT).
 *
 * Registro de comprobantes de compras recibidos de proveedores: facturas de
 * compra + notas de crédito de compra. Se reporta en guaraníes (GS).
 *
 * Fuente fiscal: `compras` (modelo PLANO: N líneas por `numero_control`) y
 * `notas_credito_compra` (+ items). Se excluyen las anuladas y las compras
 * marcadas "No RG90" (`incluir_rg90 = false`).
 *
 * El detalle del registro de Compras tiene 20 campos (ver `txt.ts`), uno más que
 * Ventas: el campo "NO IMPUTA".
 */

export type Rg90CompraTipo = "factura" | "nota_credito";

/** Un comprobante del Libro de Compras, con el desglose de IVA resuelto. */
export interface Rg90CompraRow {
  /** Clave interna (numero_control de la compra, o id de la NC) para keys de UI. */
  id: string;
  tipo: Rg90CompraTipo;
  /** Fecha de emisión (YYYY-MM-DD, Asunción). */
  fecha: string;
  /** Tipo de comprobante SET (Tabla 4): 109 Factura, 110 Nota de crédito. */
  codigoComprobante: number;
  /** Número del comprobante del proveedor (###-###-#######). */
  numeroComprobante: string;
  /** Timbrado del proveedor (8 dígitos). */
  timbrado: string;
  /** Tipo de identificación del proveedor (Tabla 3): 11 RUC, 12 CI, 15 Sin Nombre. */
  codigoTipoIdentificacion: number;
  /** Número de identificación (RUC sin DV). */
  numeroIdentificacion: string;
  /** Nombre o razón social del proveedor. */
  nombre: string;
  /** Condición de la operación (Tabla 2): 1 Contado, 2 Crédito. */
  codigoCondicion: number;
  gravado10: number;
  gravado5: number;
  exento: number;
  total: number;
  /** Moneda del comprobante (GS | USD). El RG90 se reporta en GS. */
  moneda: string;
  /** Marca "Incluir en RG90": true = entra al registro; false = No RG90. */
  incluirRg90: boolean;
  /** Para NC: número del comprobante de compra asociado (factura origen). */
  comprobanteAsociado: string | null;
  /** Para NC: timbrado del comprobante de compra asociado. */
  timbradoAsociado: string | null;
}

export interface Rg90CompraTotales {
  comprobantes: number;
  facturas: number;
  notasCredito: number;
  gravado10: number;
  gravado5: number;
  exento: number;
  total: number;
}

export interface Rg90CompraNeto {
  gravado10: number;
  gravado5: number;
  exento: number;
  total: number;
}

export interface Rg90ComprasReporte {
  mes: string; // YYYY-MM
  rucEmisor: string;
  /** true si la columna incluir_rg90 existe en la BD (migración aplicada). */
  flagDisponible: boolean;
  /** Comprobantes incluidos en el RG90 (incluir_rg90 = true). */
  rows: Rg90CompraRow[];
  /** Comprobantes marcados "No RG90" (incluir_rg90 = false) — reporte aparte. */
  rowsNoRg90: Rg90CompraRow[];
  /** Totales de los incluidos (brutos: NC suman). */
  totales: Rg90CompraTotales;
  totalesFacturas: Rg90CompraTotales;
  totalesNotasCredito: Rg90CompraTotales;
  /** Neto de los incluidos: Facturas − Notas de crédito. */
  neto: Rg90CompraNeto;
  /** Totales de los "No RG90" (para el reporte aparte). */
  totalesNoRg90: Rg90CompraTotales;
  /** Comprobantes en moneda extranjera (excluidos del TXT), para avisar. */
  excluidosMonedaExtranjera: number;
}
