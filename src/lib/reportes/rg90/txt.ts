/**
 * Serialización del Libro de Ventas RG90 al formato de importación de la SET
 * («Marangatu»): archivo posicional de 19 campos, sin cabecera, CRLF, UTF-8.
 *
 * Campos del registro de VENTAS (Especificación Técnica SET, junio 2021):
 *   1  Código tipo de registro .............. 1 (Ventas)
 *   2  Código tipo identificación comprador . Tabla 3 (11 RUC, 12 CI, 15 Sin nombre)
 *   3  Número de identificación comprador ... RUC sin DV / CI
 *   4  Nombre o razón social ................ requerido salvo 11/12/15
 *   5  Código tipo de comprobante ........... Tabla 4 (109 Factura, 110 NC)
 *   6  Fecha de emisión ..................... dd/mm/aaaa
 *   7  Número de timbrado ................... 8 dígitos
 *   8  Número del comprobante ............... ###-###-#######
 *   9  Monto gravado 10% (IVA incluido) ..... entero
 *   10 Monto gravado 5% (IVA incluido) ...... entero
 *   11 Monto no gravado o exento ............ entero
 *   12 Monto total del comprobante .......... = 9 + 10 + 11
 *   13 Código condición de venta ............ Tabla 2 (1 Contado, 2 Crédito)
 *   14 Operación en moneda extranjera ....... Tabla 5 (vacío = N)
 *   15 Imputa al IVA ........................ S/N
 *   16 Imputa al IRE ........................ S/N
 *   17 Imputa al IRP-RSP .................... S/N
 *   18 Nº comprobante de venta asociado ..... solo NC (110) / ND (111)
 *   19 Timbrado comprobante asociado ........ solo NC (110) / ND (111)
 *
 * IMPORTANTE: el archivo a importar NO debe incluir comprobantes electrónicos
 * (e-Kuatia/SIFEN) ni comprobantes virtuales — la SET ya los posee. Por eso el
 * filtro por defecto deja solo comprobantes impresos (autoimpresor) en GS.
 */
import { BOOL_NO, BOOL_SI, fechaDdMmAaaa } from "./tablas";
import type { Rg90Reporte, Rg90VentaRow } from "./types";

export type Rg90Delimitador = "csv" | "txt"; // csv = ';'   txt = tab

export interface Rg90TxtOptions {
  /** Delimitador de salida. */
  delimitador?: Rg90Delimitador;
  /** Incluir también comprobantes electrónicos (por defecto false: solo impresos). */
  incluirElectronicos?: boolean;
  /** Incluir moneda extranjera (por defecto false: solo GS). */
  incluirMonedaExtranjera?: boolean;
}

/** Filtra las filas que corresponden al archivo de importación Marangatu. */
export function filtrarParaTxt(reporte: Rg90Reporte, opts: Rg90TxtOptions = {}): Rg90VentaRow[] {
  return reporte.rows.filter((r) => {
    if (!opts.incluirElectronicos && r.electronico) return false;
    if (!opts.incluirMonedaExtranjera && r.moneda !== "GS") return false;
    return true;
  });
}

/** Un comprobante → arreglo de 19 campos string (sin delimitar). */
export function filaRg90Ventas(r: Rg90VentaRow): string[] {
  const esNC = r.codigoComprobante === 110 || r.codigoComprobante === 111;
  const sinNombre = r.codigoTipoIdentificacion === 11 || r.codigoTipoIdentificacion === 12 || r.codigoTipoIdentificacion === 15;
  return [
    "1", // 1 tipo de registro = Ventas
    String(r.codigoTipoIdentificacion), // 2
    r.numeroIdentificacion, // 3
    sinNombre ? "" : r.nombre, // 4 (no requerido para RUC/CI/Sin nombre)
    String(r.codigoComprobante), // 5
    fechaDdMmAaaa(r.fecha), // 6
    r.timbrado, // 7
    r.numeroComprobante, // 8
    String(r.gravado10), // 9
    String(r.gravado5), // 10
    String(r.exento), // 11
    String(r.total), // 12
    String(r.codigoCondicion), // 13
    r.moneda !== "GS" ? BOOL_SI : "", // 14 operación en moneda extranjera (vacío = N)
    BOOL_SI, // 15 imputa al IVA
    BOOL_NO, // 16 imputa al IRE
    BOOL_NO, // 17 imputa al IRP-RSP
    esNC ? (r.comprobanteAsociado ?? "") : "", // 18
    esNC ? (r.timbradoAsociado ?? "") : "", // 19
  ];
}

/** Escapa un campo según el delimitador. CSV usa ';'; TXT usa tab. */
function escapar(campo: string, delim: Rg90Delimitador): string {
  const sep = delim === "csv" ? ";" : "\t";
  if (campo.includes(sep) || campo.includes('"') || campo.includes("\n")) {
    return `"${campo.replace(/"/g, '""')}"`;
  }
  return campo;
}

/** Serializa las filas al archivo posicional (sin cabecera, CRLF). */
export function serializarRg90(rows: Rg90VentaRow[], opts: Rg90TxtOptions = {}): string {
  const delim: Rg90Delimitador = opts.delimitador ?? "csv";
  const sep = delim === "csv" ? ";" : "\t";
  return rows
    .map((r) => filaRg90Ventas(r).map((c) => escapar(c, delim)).join(sep))
    .join("\r\n");
}

/**
 * Nombre de archivo según la SET: RUC_REG_MMAAAA_XXXXX (obligación mensual),
 * con el RUC sin dígito verificador. `lote` es el identificador único (hasta 5).
 */
export function nombreArchivoRg90(rucSinDv: string, mes: string, lote = "V0001"): string {
  const [y, m] = mes.split("-");
  const mmaaaa = `${m}${y}`;
  const ruc = (rucSinDv || "SINRUC").replace(/[^0-9A-Za-z]/g, "");
  return `${ruc}_REG_${mmaaaa}_${lote}`;
}

/** Headers para descargar el archivo (CSV o TXT). */
export function rg90TxtResponseHeaders(filename: string, delim: Rg90Delimitador): HeadersInit {
  const ext = delim === "csv" ? "csv" : "txt";
  const safe = filename.replace(/[^a-zA-Z0-9_.-]+/g, "_");
  const mime = delim === "csv" ? "text/csv; charset=utf-8" : "text/plain; charset=utf-8";
  return {
    "Content-Type": mime,
    "Content-Disposition": `attachment; filename="${safe}.${ext}"`,
    "Cache-Control": "no-store",
  };
}
