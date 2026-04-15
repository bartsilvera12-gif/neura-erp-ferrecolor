/**
 * Taxonomía por defecto cuando la cola no tiene estados configurados en BD.
 * Los ids `fb:*` son sintéticos (solo cliente); el servidor valida contra esta lista.
 */
export const DEFAULT_CLOSURE_TAXONOMY: ReadonlyArray<{
  id: string;
  label: string;
  substates: ReadonlyArray<{ id: string; label: string }>;
}> = [
  {
    id: "fb:venta_cerrada",
    label: "Venta cerrada",
    substates: [
      { id: "fb:venta_cerrada:concretada", label: "Concretada" },
      { id: "fb:venta_cerrada:eval", label: "En evaluación" },
    ],
  },
  {
    id: "fb:no_interesado",
    label: "No interesado",
    substates: [
      { id: "fb:no_interesado:precio", label: "Precio" },
      { id: "fb:no_interesado:timing", label: "Timing" },
      { id: "fb:no_interesado:otro", label: "Otro motivo" },
    ],
  },
  {
    id: "fb:seguimiento",
    label: "Seguimiento",
    substates: [
      { id: "fb:seguimiento:callback", label: "Callback agendado" },
      { id: "fb:seguimiento:info", label: "Falta información" },
    ],
  },
  {
    id: "fb:soporte",
    label: "Soporte",
    substates: [
      { id: "fb:soporte:resuelto", label: "Resuelto" },
      { id: "fb:soporte:escalado", label: "Escalado" },
    ],
  },
  {
    id: "fb:cobranza",
    label: "Cobranza",
    substates: [
      { id: "fb:cobranza:acuerdo", label: "Acuerdo" },
      { id: "fb:cobranza:pendiente", label: "Pendiente" },
    ],
  },
];

export function isFallbackClosureStateId(id: string): boolean {
  return id.trim().startsWith("fb:");
}
