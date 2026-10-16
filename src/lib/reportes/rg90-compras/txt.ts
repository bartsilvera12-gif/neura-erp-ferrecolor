/**
 * Serialización del Libro de COMPRAS RG90 al formato de importación de la SET
 * («Marangatu»): archivo posicional de 20 campos, sin cabecera, CRLF, UTF-8.
 *
 * Campos del registro de COMPRAS (Especificación Técnica SET, junio 2021):
 *   1  Código tipo de registro .............. 2 (Compras)
 *   2  Código tipo identificación proveedor . Tabla 3 (11 RUC, 12 CI, 15 Sin nombre)
 *   3  Número de identificación proveedor ... RUC sin DV / CI
 *   4  Nombre o razón social ................ requerido salvo 11/12
 *   5  Código tipo de comprobante ........... Tabla 4 (109 Factura, 110 NC)
 *   6  Fecha de emisión ..................... dd/mm/aaaa
 *   7  Número de timbrado ................... 8 dígitos
 *   8  Número del comprobante ............... ###-###-#######
 *   9  Monto gravado 10% (IVA incluido) ..... entero
 *   10 Monto gravado 5% (IVA incluido) ...... entero
 *   11 Monto no gravado o exento ............ entero
 *   12 Monto total del comprobante .......... = 9 + 10 + 11
 *   13 Código condición de compra ........... Tabla 2 (1 Contado, 2 Crédito)
 *   14 Operación en moneda extranjera ....... Tabla 5 (vacío = N)
 *   15 Imputa al IVA ........................ S/N
 *   16 Imputa al IRE ........................ S/N
 *   17 Imputa al IRP-RSP .................... S/N
 *   18 No imputa ............................ S/N
 *   19 Nº comprobante de compra asociado .... solo NC (110) / ND (111)
 *   20 Timbrado comprobante asociado ........ solo NC (110) / ND (111)
 *
 * Reutiliza helpers del módulo RG90 de Ventas (NO lo modifica).
 */
import { BOOL_NO, BOOL_SI, fechaDdMmAaaa } from "@/lib/reportes/rg90/tablas";
import { nombreArchivoRg90, rg90TxtResponseHeaders, type Rg90Delimitador } from "@/lib/reportes/rg90/txt";
import type { Rg90ComprasReporte, Rg90CompraRow } from "./types";

export const REG_COMPRAS = 2;

// Imputación por defecto de una compra de mercadería de una comercializadora:
// toma crédito de IVA (S) y es costo deducible de IRE (S); IRP-RSP no (N); no "no imputa".
const IMPUTA_IVA_COMPRA = BOOL_SI;
const IMPUTA_IRE_COMPRA = BOOL_SI;
const IMPUTA_IRP_COMPRA = BOOL_NO;
const NO_IMPUTA_COMPRA = BOOL_NO;

export interface Rg90ComprasTxtOptions {
  delimitador?: Rg90Delimitador;
  /** Incluir moneda extranjera (por defecto false: solo GS). */
  incluirMonedaExtranjera?: boolean;
}

/** Filtra las filas que corresponden al archivo de importación Marangatu. */
export function filtrarComprasParaTxt(reporte: Rg90ComprasReporte, opts: Rg90ComprasTxtOptions = {}): Rg90CompraRow[] {
  return reporte.rows.filter((r) => {
    if (!opts.incluirMonedaExtranjera && r.moneda !== "GS") return false;
    return true;
  });
}

/** Un comprobante → arreglo de 20 campos string (sin delimitar). */
export function filaRg90Compras(r: Rg90CompraRow): string[] {
  const esNC = r.codigoComprobante === 110 || r.codigoComprobante === 111;
  const sinNombre = r.codigoTipoIdentificacion === 11 || r.codigoTipoIdentificacion === 12 || r.codigoTipoIdentificacion === 15;
  return [
    String(REG_COMPRAS), // 1 tipo de registro = Compras
    String(r.codigoTipoIdentificacion), // 2
    r.numeroIdentificacion, // 3
    sinNombre ? "" : r.nombre, // 4
    String(r.codigoComprobante), // 5
    fechaDdMmAaaa(r.fecha), // 6
    r.timbrado, // 7
    r.numeroComprobante, // 8
    String(r.gravado10), // 9
    String(r.gravado5), // 10
    String(r.exento), // 11
    String(r.total), // 12
    String(r.codigoCondicion), // 13
    r.moneda !== "GS" ? BOOL_SI : "", // 14
    IMPUTA_IVA_COMPRA, // 15
    IMPUTA_IRE_COMPRA, // 16
    IMPUTA_IRP_COMPRA, // 17
    NO_IMPUTA_COMPRA, // 18
    esNC ? (r.comprobanteAsociado ?? "") : "", // 19
    esNC ? (r.timbradoAsociado ?? "") : "", // 20
  ];
}

function escapar(campo: string, delim: Rg90Delimitador): string {
  const sep = delim === "csv" ? ";" : "\t";
  if (campo.includes(sep) || campo.includes('"') || campo.includes("\n")) {
    return `"${campo.replace(/"/g, '""')}"`;
  }
  return campo;
}

/** Serializa las filas al archivo posicional (sin cabecera, CRLF). */
export function serializarRg90Compras(rows: Rg90CompraRow[], opts: Rg90ComprasTxtOptions = {}): string {
  const delim: Rg90Delimitador = opts.delimitador ?? "csv";
  const sep = delim === "csv" ? ";" : "\t";
  return rows.map((r) => filaRg90Compras(r).map((c) => escapar(c, delim)).join(sep)).join("\r\n");
}

/** Nombre de archivo SET para Compras: RUC_REG_MMAAAA_C0001 (lote de compras). */
export function nombreArchivoRg90Compras(rucSinDv: string, mes: string): string {
  return nombreArchivoRg90(rucSinDv, mes, "C0001");
}

export { rg90TxtResponseHeaders };
export type { Rg90Delimitador };
