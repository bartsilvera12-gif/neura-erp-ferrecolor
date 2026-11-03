"use client";

/**
 * Reporte de pagos a proveedores, agrupado por FECHA DE PAGO.
 *
 * Es a propósito que agrupe por fecha de pago y no por fecha de compra: la
 * pregunta es "cuánto salió este mes", y una factura de agosto pagada en
 * septiembre es plata de septiembre. Esos casos se marcan aparte.
 */
import { useCallback, useEffect, useState } from "react";
import { RefreshCw } from "lucide-react";
import { fetchWithSupabaseSession } from "@/lib/api/fetch-with-supabase-session";
import ExportExcelButton from "@/components/ui/ExportExcelButton";

type Pago = {
  id: string; fecha_pago: string; numero_control: string;
  proveedor_nombre: string | null; fecha_compra: string | null;
  total_compra: number; monto: number; metodo_pago: string;
  referencia: string | null; salio_de_caja: boolean;
  usuario_nombre: string | null; de_mes_anterior: boolean; saldo_restante: number;
};
type Data = {
  total_pagado: number; cantidad_pagos: number; cantidad_facturas: number;
  pagado_de_meses_anteriores: number;
  por_proveedor: Array<{ proveedor_nombre: string; pagos: number; total: number }>;
  por_metodo: Array<{ metodo_pago: string; pagos: number; total: number }>;
  pagos: Pago[];
};

const METODO: Record<string, string> = {
  efectivo: "Efectivo", transferencia: "Transferencia",
  tarjeta: "Tarjeta", cheque: "Cheque", otro: "Otro",
};

function fmtGs(v: number) {
  return `Gs. ${Math.round(v || 0).toLocaleString("es-PY")}`;
}
function mesActual() {
  const d = new Date();
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const ult = new Date(y, d.getMonth() + 1, 0).getDate();
  return { desde: `${y}-${m}-01`, hasta: `${y}-${m}-${String(ult).padStart(2, "0")}` };
}

export default function PagosProveedoresPage() {
  const [rango, setRango] = useState(mesActual);
  const [d, setD] = useState<Data | null>(null);
  const [cargando, setCargando] = useState(false);
  const [err, setErr] = useState<string | null>(null);

  const cargar = useCallback(async () => {
    setCargando(true); setErr(null);
    try {
      const r = await fetchWithSupabaseSession(
        `/api/reportes/pagos-proveedores?desde=${rango.desde}&hasta=${rango.hasta}`,
        { cache: "no-store" }
      );
      const j = await r.json();
      if (!r.ok || j?.success === false) throw new Error(j?.error ?? `Error ${r.status}`);
      setD(j.data as Data);
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Error");
    } finally {
      setCargando(false);
    }
  }, [rango]);

  useEffect(() => { void cargar(); }, [cargar]);

  const inputC = "rounded-md border border-slate-200 px-3 py-1.5 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30";

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Pagos a proveedores</h1>
          <p className="mt-1 text-sm text-slate-500">
            Lo que efectivamente salió en el período, por fecha de pago. Incluye pagos parciales y pagos de facturas de meses anteriores.
          </p>
        </div>
        <div className="flex flex-wrap items-end gap-2">
          <div>
            <label className="mb-1 block text-[11px] font-semibold text-slate-500">Desde</label>
            <input type="date" value={rango.desde} onChange={(e) => setRango((r) => ({ ...r, desde: e.target.value }))} className={inputC} />
          </div>
          <div>
            <label className="mb-1 block text-[11px] font-semibold text-slate-500">Hasta</label>
            <input type="date" value={rango.hasta} onChange={(e) => setRango((r) => ({ ...r, hasta: e.target.value }))} className={inputC} />
          </div>
          <button onClick={() => setRango(mesActual())} className="rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-600 hover:bg-slate-50">Mes actual</button>
          <button onClick={() => void cargar()} disabled={cargando} className="inline-flex items-center gap-1 rounded-md bg-[#4FAEB2] px-3 py-1.5 text-xs font-semibold text-white hover:bg-[#3F8E91] disabled:opacity-50">
            <RefreshCw className={`h-3.5 w-3.5 ${cargando ? "animate-spin" : ""}`} /> Actualizar
          </button>
          <ExportExcelButton url={`/api/reportes/pagos-proveedores/export?desde=${rango.desde}&hasta=${rango.hasta}`} />
        </div>
      </div>

      {err && <p className="rounded-md border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">{err}</p>}

      {d && (
        <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
          <Tarjeta label="Total pagado" valor={fmtGs(d.total_pagado)} destacada />
          <Tarjeta label="Pagos registrados" valor={String(d.cantidad_pagos)} />
          <Tarjeta label="Facturas alcanzadas" valor={String(d.cantidad_facturas)} />
          <Tarjeta
            label="De facturas de meses anteriores"
            valor={fmtGs(d.pagado_de_meses_anteriores)}
            nota={d.pagado_de_meses_anteriores > 0 ? "ya incluido en el total" : undefined}
          />
        </div>
      )}

      <div className="overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
        <div className="border-b border-slate-200 bg-slate-50 px-4 py-2.5">
          <h2 className="text-sm font-bold text-slate-900">Detalle de pagos</h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full min-w-[900px] text-sm">
            <thead className="border-b border-slate-200 bg-slate-50/60">
              <tr>
                {["Fecha de pago", "Proveedor", "Compra", "Total compra", "Pagado", "Saldo", "Medio", "Caja"].map((h, i) => (
                  <th key={h} className={`px-4 py-2.5 text-[11px] font-bold uppercase tracking-wide text-slate-500 ${i >= 3 && i <= 5 ? "text-right" : "text-left"}`}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {!d || d.pagos.length === 0 ? (
                <tr><td colSpan={8} className="py-10 text-center text-sm text-slate-400">{cargando ? "Cargando…" : "No hubo pagos a proveedores en el período."}</td></tr>
              ) : d.pagos.map((p) => (
                <tr key={p.id} className="hover:bg-slate-50/50">
                  <td className="px-4 py-2.5 text-slate-600">
                    {p.fecha_pago.slice(0, 10)}
                    {p.de_mes_anterior && (
                      <span className="ml-2 rounded-full bg-amber-100 px-1.5 py-0.5 text-[10px] font-semibold text-amber-700">mes anterior</span>
                    )}
                  </td>
                  <td className="px-4 py-2.5 font-medium text-slate-800">{p.proveedor_nombre ?? "—"}</td>
                  <td className="px-4 py-2.5 font-mono text-xs text-slate-600">
                    {p.numero_control}
                    {p.fecha_compra && <span className="ml-2 text-slate-400">{p.fecha_compra.slice(0, 10)}</span>}
                  </td>
                  <td className="px-4 py-2.5 text-right tabular-nums text-slate-500">{fmtGs(p.total_compra)}</td>
                  <td className="px-4 py-2.5 text-right tabular-nums font-semibold text-slate-900">{fmtGs(p.monto)}</td>
                  <td className={`px-4 py-2.5 text-right tabular-nums ${p.saldo_restante > 0 ? "font-semibold text-amber-700" : "text-slate-400"}`}>
                    {p.saldo_restante > 0 ? fmtGs(p.saldo_restante) : "cancelada"}
                  </td>
                  <td className="px-4 py-2.5 text-slate-600">{METODO[p.metodo_pago] ?? p.metodo_pago}</td>
                  <td className="px-4 py-2.5 text-slate-500">{p.salio_de_caja ? "Sí" : "—"}</td>
                </tr>
              ))}
            </tbody>
            {d && d.pagos.length > 0 && (
              <tfoot className="border-t border-slate-200 bg-slate-50">
                <tr>
                  <td colSpan={4} className="px-4 py-3 text-sm font-bold text-slate-700">Total pagado en el período</td>
                  <td className="px-4 py-3 text-right text-sm font-bold tabular-nums text-slate-900">{fmtGs(d.total_pagado)}</td>
                  <td colSpan={3} />
                </tr>
              </tfoot>
            )}
          </table>
        </div>
      </div>

      {d && d.por_proveedor.length > 0 && (
        <div className="grid gap-4 lg:grid-cols-2">
          <Agrupado titulo="Por proveedor" filas={d.por_proveedor.map((r) => ({ k: r.proveedor_nombre, pagos: r.pagos, total: r.total }))} />
          <Agrupado titulo="Por medio de pago" filas={d.por_metodo.map((r) => ({ k: METODO[r.metodo_pago] ?? r.metodo_pago, pagos: r.pagos, total: r.total }))} />
        </div>
      )}
    </div>
  );
}

function Tarjeta({ label, valor, nota, destacada = false }: { label: string; valor: string; nota?: string; destacada?: boolean }) {
  return (
    <div className={`rounded-xl border p-4 ${destacada ? "border-[#4FAEB2]/30 bg-[#4FAEB2]/[0.06]" : "border-slate-200 bg-white"}`}>
      <p className="text-[10px] font-bold uppercase tracking-wider text-slate-500">{label}</p>
      <p className={`mt-1 text-lg font-bold tabular-nums ${destacada ? "text-[#3F8E91]" : "text-slate-800"}`}>{valor}</p>
      {nota && <p className="mt-0.5 text-[11px] text-slate-400">{nota}</p>}
    </div>
  );
}

function Agrupado({ titulo, filas }: { titulo: string; filas: Array<{ k: string; pagos: number; total: number }> }) {
  return (
    <div className="overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
      <div className="border-b border-slate-200 bg-slate-50 px-4 py-2.5">
        <h2 className="text-sm font-bold text-slate-900">{titulo}</h2>
      </div>
      <div className="overflow-x-auto">
        <table className="w-full text-sm">
          <tbody className="divide-y divide-slate-100">
            {filas.map((f) => (
              <tr key={f.k}>
                <td className="px-4 py-2.5 text-slate-700">{f.k}</td>
                <td className="px-4 py-2.5 text-right text-xs text-slate-400">{f.pagos} {f.pagos === 1 ? "pago" : "pagos"}</td>
                <td className="px-4 py-2.5 text-right tabular-nums font-semibold text-slate-900">{fmtGs(f.total)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
