/**
 * Tablas de códigos y helpers de formato del RG90 (Libro de Ventas SET/DNIT).
 * Basado en la "Especificación Técnica para Importación — Registro de
 * Comprobantes de Ventas, Compras, Ingresos y/o Egresos" (SET, junio 2021).
 */

// ── Tabla 1: tipos de registro ───────────────────────────────────────────────
export const REG_VENTAS = 1;

// ── Tabla 2: condición de la operación ───────────────────────────────────────
export const COND_CONTADO = 1;
export const COND_CREDITO = 2;

// ── Tabla 3: tipos de identificación ─────────────────────────────────────────
export const ID_RUC = 11;
export const ID_CEDULA = 12;
export const ID_SIN_NOMBRE = 15;

// ── Tabla 4: tipos de comprobante (los usados en ventas) ─────────────────────
export const COMP_FACTURA = 109;
export const COMP_NOTA_CREDITO = 110;

// ── Tabla 5: booleanos ───────────────────────────────────────────────────────
export const BOOL_SI = "S";
export const BOOL_NO = "N";

/** Condición de venta a partir del campo `tipo` de la factura/NC. */
export function condicionDesdeTipo(tipo: string | null | undefined): number {
  const t = String(tipo ?? "").trim().toLowerCase();
  return t === "credito" || t === "crédito" ? COND_CREDITO : COND_CONTADO;
}

/**
 * Quita el dígito verificador de un RUC. La SET exige el RUC sin DV en los
 * campos de identificación. Acepta "80024627-1", "80024627/1" o "800246271".
 * Para RUC con guion/barra devuelve la parte antes del separador. Para un RUC
 * numérico sin separador se devuelve tal cual (no se puede inferir el DV).
 */
export function rucSinDv(raw: string | null | undefined): string {
  const s = String(raw ?? "").trim();
  if (!s) return "";
  const m = /^([0-9A-Za-z]+)[-/]([0-9kK])$/.exec(s);
  if (m) return m[1];
  return s;
}

/** Solo dígitos (para timbrado, números, etc.). */
export function soloDigitos(raw: string | null | undefined): string {
  return String(raw ?? "").replace(/\D+/g, "");
}

/**
 * Normaliza el número de comprobante al formato ###-###-####### (estab-punto-número).
 * Acepta:
 *   - ya formateado "001-002-0000250" → se re-pad por seguridad.
 *   - solo el correlativo "250" + estab/punto de la config.
 */
export function formatNumeroComprobante(
  numeroFactura: string | null | undefined,
  establecimiento: string | null | undefined,
  puntoExpedicion: string | null | undefined
): string {
  const raw = String(numeroFactura ?? "").trim();
  const partes = raw.split("-").map((p) => p.trim()).filter(Boolean);
  let est: string;
  let pun: string;
  let num: string;
  if (partes.length === 3) {
    [est, pun, num] = partes;
  } else {
    est = String(establecimiento ?? "").trim();
    pun = String(puntoExpedicion ?? "").trim();
    num = raw.replace(/\D+/g, "");
  }
  est = soloDigitos(est).padStart(3, "0").slice(-3);
  pun = soloDigitos(pun).padStart(3, "0").slice(-3);
  num = soloDigitos(num).padStart(7, "0").slice(-7);
  return `${est}-${pun}-${num}`;
}

/** Fecha YYYY-MM-DD → dd/mm/aaaa (formato exigido por la SET). */
export function fechaDdMmAaaa(ymd: string | null | undefined): string {
  const s = String(ymd ?? "").trim().slice(0, 10);
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(s);
  if (!m) return "";
  return `${m[3]}/${m[2]}/${m[1]}`;
}

/**
 * Determina tipo de identificación + número del comprador.
 * Preferencia: RUC (11) → Cédula (12) → Sin Nombre (15).
 */
export function identificacionComprador(input: {
  ruc?: string | null;
  documento?: string | null;
}): { codigo: number; numero: string } {
  const ruc = rucSinDv(input.ruc);
  if (ruc) return { codigo: ID_RUC, numero: ruc };
  const ci = soloDigitos(input.documento);
  if (ci) return { codigo: ID_CEDULA, numero: ci };
  return { codigo: ID_SIN_NOMBRE, numero: "0" };
}

/**
 * Clasifica una línea por su tasa de IVA a partir de (subtotal base, iva) o del
 * texto `tipo_iva` denormalizado. Devuelve 10 | 5 | 0.
 */
export function tasaIvaLinea(input: {
  subtotal: number;
  iva: number;
  tipoIva?: string | null;
}): 10 | 5 | 0 {
  const t = String(input.tipoIva ?? "").trim().toLowerCase();
  if (t) {
    if (t.includes("exent") || t === "iva_0" || t === "0" || t === "exenta") return 0;
    if (t.includes("5")) return 5;
    if (t.includes("10")) return 10;
  }
  const iva = Number(input.iva) || 0;
  const base = Number(input.subtotal) || 0;
  if (iva <= 0) return 0;
  if (base <= 0) return 10;
  const ratio = iva / base;
  if (Math.abs(ratio - 0.05) < 0.02) return 5;
  if (Math.abs(ratio - 0.1111) < 0.03 || Math.abs(ratio - 0.1) < 0.03) return 10;
  return 10;
}
