/**
 * Escalas de comision de Ferrecolor.
 *
 * Regla del cliente: el TRAMO se determina por el monto total VENDIDO en el
 * periodo, pero el porcentaje se aplica sobre la GANANCIA generada por esas
 * ventas (no sobre el total vendido).
 *
 *   Vendido 0 a 20.000.000    -> 0% de la ganancia
 *   Vendido 20.000.000 a 35M  -> 5% de la ganancia
 *   Vendido mas de 35.000.000 -> 7% de la ganancia
 *
 * Ej: vendio 40.000.000 con 12.000.000 de ganancia -> tramo 7% -> 840.000.
 *
 * Los tramos son CONFIGURABLES desde Administracion (Configuracion >
 * Comisiones), que los guarda en `comision_politicas` + `comision_escalas`.
 * Si esa configuracion todavia no existe se usan los valores de abajo, para que
 * el modulo funcione desde el dia uno sin depender de una carga previa.
 */

export type EscalaComision = {
  desde: number;
  /** null = sin tope (ultimo tramo). */
  hasta: number | null;
  porcentaje: number;
};

export const ESCALAS_FERRECOLOR_DEFAULT: EscalaComision[] = [
  { desde: 0, hasta: 20_000_000, porcentaje: 0 },
  { desde: 20_000_000, hasta: 35_000_000, porcentaje: 5 },
  { desde: 35_000_000, hasta: null, porcentaje: 7 },
];

/** De donde salieron las escalas que se usaron para calcular. */
export type OrigenEscalas = "configurada" | "default";

type EscalaRow = {
  desde_monto: number | string | null;
  hasta_monto: number | string | null;
  porcentaje_comision: number | string | null;
};

/** Cliente minimo que necesitamos; evita atar este modulo al tipo del tenant. */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
type SupabaseLike = { from: (t: string) => any };

function normalizar(rows: EscalaRow[]): EscalaComision[] {
  const escalas = rows
    .map((r) => ({
      desde: Math.max(0, Number(r.desde_monto) || 0),
      hasta:
        r.hasta_monto === null || r.hasta_monto === undefined || String(r.hasta_monto).trim() === ""
          ? null
          : Number(r.hasta_monto),
      porcentaje: Math.max(0, Number(r.porcentaje_comision) || 0),
    }))
    .filter((e) => e.hasta === null || e.hasta > e.desde)
    .sort((a, b) => a.desde - b.desde);
  if (escalas.length === 0) return [];
  // El ultimo tramo siempre queda abierto: si el admin cargo un tope, igual
  // tiene que haber un porcentaje para quien lo supere.
  escalas[escalas.length - 1] = { ...escalas[escalas.length - 1], hasta: null };
  return escalas;
}

/**
 * Escalas vigentes de la empresa. NUNCA lanza: si la configuracion no existe,
 * esta vacia o la tabla no esta creada en este schema, devuelve las por defecto.
 */
export async function getEscalasComision(
  sb: SupabaseLike,
  empresaId: string
): Promise<{ escalas: EscalaComision[]; origen: OrigenEscalas }> {
  try {
    const pol = await sb
      .from("comision_politicas")
      .select("id")
      .eq("empresa_id", empresaId)
      .maybeSingle();
    if (pol.error || !pol.data) return { escalas: ESCALAS_FERRECOLOR_DEFAULT, origen: "default" };

    const esc = await sb
      .from("comision_escalas")
      .select("desde_monto, hasta_monto, porcentaje_comision")
      .eq("empresa_id", empresaId)
      .eq("politica_id", String((pol.data as { id: string }).id))
      .order("orden", { ascending: true })
      .order("desde_monto", { ascending: true });
    if (esc.error) return { escalas: ESCALAS_FERRECOLOR_DEFAULT, origen: "default" };

    const escalas = normalizar((esc.data ?? []) as EscalaRow[]);
    if (escalas.length === 0) return { escalas: ESCALAS_FERRECOLOR_DEFAULT, origen: "default" };
    return { escalas, origen: "configurada" };
  } catch {
    return { escalas: ESCALAS_FERRECOLOR_DEFAULT, origen: "default" };
  }
}

/** Tramo que le corresponde a un vendedor segun lo que VENDIO en el periodo. */
export function tramoParaVentas(escalas: EscalaComision[], vendido: number): EscalaComision {
  const lista = escalas.length > 0 ? escalas : ESCALAS_FERRECOLOR_DEFAULT;
  for (const e of lista) {
    if (vendido >= e.desde && (e.hasta === null || vendido < e.hasta)) return e;
  }
  return lista[lista.length - 1];
}

/** Comision = porcentaje del tramo (definido por lo vendido) sobre la ganancia. */
export function calcularComision(
  escalas: EscalaComision[],
  vendido: number,
  ganancia: number
): { tramo: EscalaComision; comision: number } {
  const tramo = tramoParaVentas(escalas, vendido);
  return { tramo, comision: Math.max(0, Math.round((ganancia * tramo.porcentaje) / 100)) };
}
