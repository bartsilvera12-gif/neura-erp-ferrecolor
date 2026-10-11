/**
 * Tipos del reporte RG90 — Libro de Ventas (Resolución General 90/2021 SET/DNIT).
 *
 * El RG90 es el registro de comprobantes de ventas que el contribuyente remite
 * a la SET por el Sistema «Marangatu». Este módulo cubre SOLO el libro de VENTAS
 * (facturas + notas de crédito emitidas), en guaraníes (GS).
 *
 * Fuente fiscal: `facturas` + `factura_items` (desglose IVA) y `nota_credito`
 * (prorrateado sobre la composición de la factura de origen). Se excluyen las
 * anuladas. El archivo de importación a Marangatu NO debe incluir comprobantes
 * electrónicos (e-Kuatia/SIFEN) — ver `txt.ts`.
 */

/** Tipo de comprobante soportado en el libro de ventas. */
export type Rg90TipoComprobante = "factura" | "nota_credito";

/** Un comprobante del Libro de Ventas, ya con el desglose de IVA resuelto. */
export interface Rg90VentaRow {
  /** id interno (factura.id o nota_credito.id) — para keys de UI. */
  id: string;
  tipo: Rg90TipoComprobante;
  /** Fecha de emisión (YYYY-MM-DD, Asunción). */
  fecha: string;
  /** Tipo de comprobante SET (Tabla 4): 109 Factura, 110 Nota de crédito. */
  codigoComprobante: number;
  /** Número del comprobante formato ###-###-####### (estab-punto-número). */
  numeroComprobante: string;
  /** Timbrado (8 dígitos). */
  timbrado: string;
  /** Tipo de identificación del comprador (Tabla 3): 11 RUC, 12 CI, 15 Sin Nombre. */
  codigoTipoIdentificacion: number;
  /** Número de identificación (RUC sin DV, o CI). */
  numeroIdentificacion: string;
  /** Nombre o razón social (requerido salvo RUC/CI/Sin Nombre). */
  nombre: string;
  /** Condición de la operación (Tabla 2): 1 Contado, 2 Crédito. */
  codigoCondicion: number;
  /** Monto gravado al 10% (IVA incluido), entero GS. */
  gravado10: number;
  /** Monto gravado al 5% (IVA incluido), entero GS. */
  gravado5: number;
  /** Monto no gravado o exento, entero GS. */
  exento: number;
  /** Monto total del comprobante (= gravado10 + gravado5 + exento). */
  total: number;
  /** Moneda del comprobante (GS | USD). El RG90 se reporta en GS. */
  moneda: string;
  /** true si el comprobante es electrónico (e-Kuatia/SIFEN) y la SET ya lo tiene. */
  electronico: boolean;
  /** Para notas de crédito: número del comprobante de venta asociado (factura origen). */
  comprobanteAsociado: string | null;
  /** Para notas de crédito: timbrado del comprobante de venta asociado. */
  timbradoAsociado: string | null;
}

/** Totales agregados del período. */
export interface Rg90Totales {
  comprobantes: number;
  facturas: number;
  notasCredito: number;
  gravado10: number;
  gravado5: number;
  exento: number;
  total: number;
}

export interface Rg90Reporte {
  mes: string; // YYYY-MM
  /** RUC del emisor (con DV, tal como está en la config). */
  rucEmisor: string;
  /** Modo de facturación de la empresa: sifen | autoimpresor | sin_factura_fiscal. */
  modoFacturacion: string;
  rows: Rg90VentaRow[];
  totales: Rg90Totales;
  /** Totales solo de comprobantes impresos (lo que iría al TXT Marangatu por defecto). */
  totalesImpresos: Rg90Totales;
  /** Comprobantes en moneda extranjera (excluidos del TXT), para avisar en UI. */
  excluidosMonedaExtranjera: number;
}
