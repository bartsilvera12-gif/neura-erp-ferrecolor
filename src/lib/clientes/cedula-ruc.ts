/**
 * Clasificación Cédula vs RUC para personas físicas.
 *
 * En Paraguay el RUC de una persona física es la cédula + dígito verificador (DV),
 * escrito como "cuerpo-DV" (ej. "1390182-6"). Una cédula sola no lleva DV (ej. "1390182").
 *
 * Regla: si el valor viene con DV explícito (formato "dígitos-DV") lo tratamos como RUC
 * → se factura como CONTRIBUYENTE (iNatRec=1). Si es solo la cédula → CONSUMIDOR FINAL.
 *
 * El generador SIFEN (src/lib/sifen/rde-xml.ts) decide contribuyente vs consumidor final
 * según haya o no `ruc` en el cliente, así que enrutar el dato al campo correcto es todo
 * lo que hace falta para que la factura salga bien.
 */

/** Quita puntos y espacios; deja dígitos y un eventual guion del DV. */
export function normalizarDocIdentidad(raw: string): string {
  return (raw ?? "").replace(/[.\s]/g, "").trim();
}

/** ¿El valor tiene forma de RUC (cuerpo de 2-8 dígitos + guion + dígito verificador)? Ej. "1390182-6". */
export function pareceRuc(raw: string): boolean {
  return /^\d{2,8}-\d$/.test(normalizarDocIdentidad(raw));
}

export type ClasificacionDocumento = {
  /** true si se interpretó como RUC (contribuyente). */
  esRuc: boolean;
  /** Valor para el campo `ruc` del cliente (o null). */
  ruc: string | null;
  /** Valor para el campo `documento`/CI del cliente (o null). */
  documento: string | null;
};

/**
 * Enruta un valor tipeado en el campo "Cédula / RUC" hacia `ruc` o `documento`.
 * Con DV → RUC (contribuyente). Sin DV → cédula (consumidor final).
 */
export function clasificarCedulaRuc(raw: string): ClasificacionDocumento {
  const v = normalizarDocIdentidad(raw);
  if (!v) return { esRuc: false, ruc: null, documento: null };
  if (pareceRuc(v)) return { esRuc: true, ruc: v, documento: null };
  return { esRuc: false, ruc: null, documento: v };
}
