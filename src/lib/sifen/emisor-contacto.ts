/**
 * Datos de contacto del emisor que van en el XML de SIFEN (dTelEmi / dEmailE).
 *
 * Viven en un solo lugar a proposito: estaban repetidos en la factura y en la
 * nota de credito, y al corregir el telefono habia que acordarse de tocar los
 * dos archivos. Si se desincronizan, SIFEN recibe un dato distinto segun el
 * tipo de documento.
 *
 * Telefono confirmado por el cliente el 31/08/2026 (antes figuraba 09923602828,
 * con un digito de mas).
 */
export const SIFEN_EMISOR_TELEFONO = "0992602828";
export const SIFEN_EMISOR_EMAIL = "ferrecolorpinturas@gmail.com";
