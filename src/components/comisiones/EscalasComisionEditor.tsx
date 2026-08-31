"use client";

/**
 * Editor de las escalas de comision, dentro del propio modulo de Comisiones.
 *
 * Guarda contra /api/comisiones/politica (las mismas tablas que
 * Configuracion > Comisiones), asi que los dos lugares muestran lo mismo.
 *
 * Sobre el modelo de datos: la politica tiene campos que Ferrecolor no usa
 * (base_calculo, timezone, modo_periodo) porque la comision se calcula sobre
 * las ventas del periodo. Se conservan tal como estan al guardar, y si todavia
 * no existe politica se crea con valores neutros: el endpoint los exige.
 *
 * Solo lo ven los roles que pueden configurar comisiones; al resto ni se le
 * muestra el boton.
 */

import { useCallback, useEffect, useState } from "react";
import { Plus, Save, Settings2, Trash2, X } from "lucide-react";
import MontoInput from "@/components/ui/MontoInput";
import { fetchWithSupabaseSession } from "@/lib/api/fetch-with-supabase-session";

/**
 * Un tramo solo guarda su piso y su porcentaje: el techo es el piso del tramo
 * siguiente, y el ultimo queda abierto. Asi por construccion no se pueden cargar
 * huecos ni solapes entre tramos, que es la forma facil de pagar comisiones mal.
 */
type Fila = { desde: number; porcentaje: number };

type PoliticaApi = {
  politica: {
    nombre?: string | null;
    activo?: boolean | null;
    base_calculo?: string | null;
    timezone?: string | null;
    modo_periodo?: string | null;
  } | null;
  escalas: Array<{
    desde_monto: number | string | null;
    hasta_monto: number | string | null;
    porcentaje_comision: number | string | null;
  }>;
  puedeEditar?: boolean;
  canEdit?: boolean;
};

const ENDPOINT = "/api/comisiones/politica";

/** Escalas que se ofrecen cuando la empresa todavia no cargo ninguna. */
const SUGERIDAS: Fila[] = [
  { desde: 0, porcentaje: 0 },
  { desde: 20_000_000, porcentaje: 5 },
  { desde: 35_000_000, porcentaje: 7 },
];

function fmtGs(v: number) {
  return `Gs. ${Math.round(v || 0).toLocaleString("es-PY")}`;
}

export default function EscalasComisionEditor({ onGuardado }: { onGuardado?: () => void }) {
  const [puedeEditar, setPuedeEditar] = useState(false);
  const [abierto, setAbierto] = useState(false);
  const [filas, setFilas] = useState<Fila[]>([]);
  const [politica, setPolitica] = useState<PoliticaApi["politica"]>(null);
  const [guardando, setGuardando] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [ok, setOk] = useState<string | null>(null);

  const cargar = useCallback(async () => {
    try {
      const r = await fetchWithSupabaseSession(ENDPOINT, { cache: "no-store" });
      const j = await r.json();
      if (!r.ok || j?.success === false) return;
      const d = j.data as PoliticaApi;
      setPuedeEditar(d.puedeEditar ?? d.canEdit ?? false);
      setPolitica(d.politica ?? null);
      const cargadas: Fila[] = (d.escalas ?? [])
        .map((e) => ({
          desde: Number(e.desde_monto) || 0,
          porcentaje: Number(e.porcentaje_comision) || 0,
        }))
        .sort((a, b) => a.desde - b.desde);
      setFilas(cargadas.length > 0 ? cargadas : SUGERIDAS);
    } catch {
      /* si falla, el boton simplemente no aparece */
    }
  }, []);

  useEffect(() => { void cargar(); }, [cargar]);

  function setFila(i: number, patch: Partial<Fila>) {
    setFilas((prev) => prev.map((f, k) => (k === i ? { ...f, ...patch } : f)));
  }

  function agregar() {
    setFilas((prev) => [...prev, { desde: prev[prev.length - 1]?.desde ?? 0, porcentaje: 0 }]);
  }

  function quitar(i: number) {
    setFilas((prev) => prev.filter((_, k) => k !== i));
  }

  /** El primer tramo tiene que arrancar en 0 y los pisos tienen que subir. */
  function validar(fs: Fila[]): string | null {
    if (fs.length === 0) return "Cargá al menos un tramo.";
    const orden = [...fs].sort((a, b) => a.desde - b.desde);
    if (orden[0].desde !== 0) return "El primer tramo tiene que arrancar en 0, si no queda un hueco sin porcentaje.";
    for (let i = 0; i < orden.length; i++) {
      const f = orden[i];
      if (f.porcentaje < 0 || f.porcentaje > 100) return `Tramo ${i + 1}: el porcentaje tiene que estar entre 0 y 100.`;
      if (i > 0 && f.desde <= orden[i - 1].desde) {
        return `Tramo ${i + 1}: tiene que arrancar por encima de ${fmtGs(orden[i - 1].desde)}.`;
      }
    }
    return null;
  }

  async function guardar() {
    const problema = validar(filas);
    if (problema) { setErr(problema); setOk(null); return; }
    setGuardando(true);
    setErr(null);
    setOk(null);
    try {
      const orden = [...filas].sort((a, b) => a.desde - b.desde);
      const r = await fetchWithSupabaseSession(ENDPOINT, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          // Campos que el endpoint exige: se preservan los actuales para no
          // pisar lo que este configurado en Configuracion > Comisiones.
          nombre: politica?.nombre?.trim() || "Comisiones por vendedor",
          activo: politica?.activo !== false,
          base_calculo: politica?.base_calculo || "factura_emitida",
          timezone: politica?.timezone || "America/Asuncion",
          modo_periodo: politica?.modo_periodo || "mensual_penultimo_dia_habil",
          // El techo de cada tramo es el piso del siguiente; el ultimo va sin tope.
          escalas: orden.map((f, i) => ({
            orden: i,
            desde_monto: f.desde,
            hasta_monto: i < orden.length - 1 ? orden[i + 1].desde : null,
            porcentaje_comision: f.porcentaje,
            premio_fijo: null,
          })),
        }),
      });
      const j = await r.json();
      if (!r.ok || j?.success === false) throw new Error(j?.error ?? `Error ${r.status}`);
      setOk("Escalas guardadas.");
      setAbierto(false);
      await cargar();
      onGuardado?.();
    } catch (e) {
      setErr(e instanceof Error ? e.message : "No se pudieron guardar las escalas.");
    } finally {
      setGuardando(false);
    }
  }

  if (!puedeEditar) return null;

  if (!abierto) {
    return (
      <div className="flex items-center gap-3">
        <button
          onClick={() => { setAbierto(true); setOk(null); setErr(null); }}
          className="inline-flex items-center gap-1.5 rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-600 hover:bg-slate-50"
        >
          <Settings2 className="h-3.5 w-3.5" /> Configurar escalas
        </button>
        {ok && <span className="text-xs font-medium text-emerald-600">{ok}</span>}
      </div>
    );
  }

  const inputPct = "w-20 rounded-md border border-slate-200 px-2 py-1.5 text-sm tabular-nums outline-none focus:ring-2 focus:ring-[#4FAEB2]/30";
  const inputMonto = "w-40 rounded-md border border-slate-200 px-2 py-1.5 text-sm tabular-nums outline-none focus:ring-2 focus:ring-[#4FAEB2]/30";

  return (
    <div className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
      <div className="mb-3 flex items-start justify-between gap-3">
        <div>
          <h2 className="text-sm font-bold text-slate-900">Escalas de comisión</h2>
          <p className="mt-0.5 text-xs text-slate-500">
            El tramo se decide por lo <strong>vendido</strong> en el período; el porcentaje se aplica sobre la <strong>ganancia</strong>.
          </p>
        </div>
        <button onClick={() => setAbierto(false)} className="rounded-md p-1 text-slate-400 hover:bg-slate-100" aria-label="Cerrar">
          <X className="h-4 w-4" />
        </button>
      </div>

      <div className="space-y-2">
        {filas.map((f, i) => {
          // Techo derivado: el piso del tramo siguiente. No se edita.
          const hasta = i < filas.length - 1 ? filas[i + 1].desde : null;
          return (
          <div key={i} className="flex flex-wrap items-center gap-2">
            <span className="w-6 text-xs font-semibold text-slate-400">{i + 1}</span>
            <label className="text-xs text-slate-500">Desde</label>
            <MontoInput value={f.desde} onChange={(n) => setFila(i, { desde: n })} decimals={false} className={inputMonto} />
            <label className="text-xs text-slate-500">Hasta</label>
            <span className="w-40 px-2 py-1.5 text-sm text-slate-400 tabular-nums">
              {hasta === null ? "sin tope (∞)" : fmtGs(hasta)}
            </span>
            <input
              type="number"
              min={0}
              max={100}
              step="0.01"
              value={f.porcentaje}
              onChange={(e) => setFila(i, { porcentaje: Number(e.target.value) || 0 })}
              className={inputPct}
            />
            <span className="text-xs text-slate-500">% de la ganancia</span>
            {filas.length > 1 && (
              <button onClick={() => quitar(i)} className="rounded-md p-1 text-slate-400 hover:bg-red-50 hover:text-red-600" aria-label={`Quitar tramo ${i + 1}`}>
                <Trash2 className="h-3.5 w-3.5" />
              </button>
            )}
          </div>
          );
        })}
      </div>
      <p className="mt-2 text-[11px] text-slate-400">
        El tope de cada tramo es el piso del siguiente; el último queda sin tope.
      </p>

      {err && <p className="mt-3 rounded-md border border-red-200 bg-red-50 px-3 py-2 text-xs text-red-700">{err}</p>}

      <div className="mt-4 flex items-center gap-2">
        <button onClick={agregar} className="inline-flex items-center gap-1 rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-600 hover:bg-slate-50">
          <Plus className="h-3.5 w-3.5" /> Agregar tramo
        </button>
        <div className="flex-1" />
        <button onClick={() => { setAbierto(false); void cargar(); }} disabled={guardando} className="rounded-md px-3 py-1.5 text-xs font-medium text-slate-500 hover:bg-slate-50 disabled:opacity-50">
          Cancelar
        </button>
        <button onClick={() => void guardar()} disabled={guardando} className="inline-flex items-center gap-1 rounded-md bg-[#4FAEB2] px-3 py-1.5 text-xs font-semibold text-white hover:bg-[#3F8E91] disabled:opacity-50">
          <Save className="h-3.5 w-3.5" /> {guardando ? "Guardando…" : "Guardar escalas"}
        </button>
      </div>
    </div>
  );
}
