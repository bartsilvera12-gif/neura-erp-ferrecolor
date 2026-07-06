"use client";

import { useEffect, useMemo, useState } from "react";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import { getRotacionAbcReporte, type RotacionAbc } from "@/lib/reportes/storage";
import { productoMatchesQuery } from "@/lib/productos/token-search";
import type { RangoABC } from "@/lib/reportes/abc";

function fmtGs(v: number) {
  return `Gs. ${Math.round(v).toLocaleString("es-PY")}`;
}
function fmtNum(v: number) {
  return v.toLocaleString("es-PY");
}

const RANGO_BADGE: Record<RangoABC, string> = {
  A: "bg-emerald-100 text-emerald-700",
  B: "bg-amber-100 text-amber-700",
  C: "bg-slate-200 text-slate-600",
};

const PERIODOS = [
  { meses: 1, label: "Último mes" },
  { meses: 2, label: "Últimos 2 meses" },
  { meses: 3, label: "Últimos 3 meses" },
];

export default function RotacionAbcPage() {
  const [meses, setMeses] = useState(3);
  const [data, setData] = useState<RotacionAbc | null>(null);
  const [cargando, setCargando] = useState(true);
  const [rango, setRango] = useState<RangoABC | "">("");
  const [busqueda, setBusqueda] = useState("");

  useEffect(() => {
    let cancel = false;
    setCargando(true);
    getRotacionAbcReporte(meses).then((d) => {
      if (!cancel) { setData(d); setCargando(false); }
    });
    return () => { cancel = true; };
  }, [meses]);

  const filtrados = useMemo(() => {
    if (!data) return [];
    return data.productos.filter((p) => {
      if (rango && p.rango !== rango) return false;
      if (busqueda.trim() && !productoMatchesQuery(busqueda, p.nombre, p.sku)) return false;
      return true;
    });
  }, [data, rango, busqueda]);

  const t = data?.totales;

  return (
    <div className="space-y-8">
      <PageHeader
        eyebrow="Zentra · Reportes"
        title="Rotación de productos (ABC)"
        description="Clasificación por ventas: A muy vendidos, B medios, C poca o ninguna venta."
        backHref="/reportes"
        backLabel="Reportes"
        actions={
          <div className="flex items-center gap-2">
            {PERIODOS.map((p) => (
              <button
                key={p.meses}
                onClick={() => setMeses(p.meses)}
                className={`rounded-lg border px-3 py-2 text-xs font-semibold transition-colors ${
                  meses === p.meses
                    ? "border-[#4FAEB2] bg-[#4FAEB2] text-white"
                    : "border-slate-200 bg-white text-slate-600 hover:bg-slate-50"
                }`}
              >
                {p.label}
              </button>
            ))}
          </div>
        }
      />

      {cargando ? (
        <p className="text-slate-500 animate-pulse">Cargando…</p>
      ) : !data || !t ? (
        <div className="rounded-xl border border-slate-200 bg-white p-6 text-slate-500 shadow-sm">
          No se pudo cargar la rotación de productos.
        </div>
      ) : (
        <>
          <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
            <StatCard compact accent label="Productos" value={String(t.total)} hint={`período ${data.desde} → ${data.hasta}`} />
            <StatCard compact label="Clase A" value={String(t.a)} hint="muy vendidos" />
            <StatCard compact label="Clase B" value={String(t.b)} hint="medianamente vendidos" />
            <StatCard compact label="Clase C" value={String(t.c)} hint={`${t.sin_ventas} sin ventas`} />
          </div>

          <div className="rounded-2xl border border-[#4FAEB2]/30 bg-white p-6 shadow-sm ring-1 ring-[#4FAEB2]/10">
            <div className="mb-4 flex flex-wrap items-center gap-3">
              <input
                type="text"
                placeholder="Buscar por nombre o SKU…"
                value={busqueda}
                onChange={(e) => setBusqueda(e.target.value)}
                className="min-w-0 flex-1 rounded-lg border border-slate-200 px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30 sm:min-w-72"
              />
              <select
                value={rango}
                onChange={(e) => setRango(e.target.value as RangoABC | "")}
                className="w-40 rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30"
              >
                <option value="">Todos los rangos</option>
                <option value="A">Rango A</option>
                <option value="B">Rango B</option>
                <option value="C">Rango C</option>
              </select>
              <span className="ml-auto text-sm text-slate-400">{filtrados.length} de {t.total}</span>
            </div>

            <div className="overflow-x-auto rounded-xl border border-slate-200">
              <table className="w-full min-w-[880px] text-sm">
                <thead className="border-b-2 border-[#4FAEB2]/40 bg-[#E5F4F4]">
                  <tr>
                    <th className="px-3 py-3 text-left text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Producto</th>
                    <th className="px-3 py-3 text-left text-xs font-bold uppercase tracking-wide text-[#3F8E91]">SKU</th>
                    <th className="px-3 py-3 text-right text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Stock</th>
                    <th className="px-3 py-3 text-right text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Stock mín.</th>
                    <th className="px-3 py-3 text-right text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Cant. vendida</th>
                    <th className="px-3 py-3 text-right text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Importe vendido</th>
                    <th className="px-3 py-3 text-center text-xs font-bold uppercase tracking-wide text-[#3F8E91]">Rango</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                  {filtrados.length === 0 ? (
                    <tr><td colSpan={7} className="py-8 text-center text-sm text-slate-400">Sin productos para el filtro.</td></tr>
                  ) : filtrados.map((p) => (
                    <tr key={p.producto_id} className="transition-colors hover:bg-[#4FAEB2]/5">
                      <td className="px-3 py-2.5 text-xs font-semibold text-slate-900">{p.nombre}</td>
                      <td className="px-3 py-2.5 font-mono text-xs text-slate-500">{p.sku ?? "—"}</td>
                      <td className={`px-3 py-2.5 text-right text-xs tabular-nums font-medium ${p.stock_actual <= p.stock_minimo ? "text-red-600" : "text-slate-700"}`}>{fmtNum(p.stock_actual)}</td>
                      <td className="px-3 py-2.5 text-right text-xs tabular-nums text-slate-500">{fmtNum(p.stock_minimo)}</td>
                      <td className="px-3 py-2.5 text-right text-xs tabular-nums font-bold text-slate-900">{fmtNum(p.cantidad_vendida)}</td>
                      <td className="px-3 py-2.5 text-right text-xs tabular-nums text-slate-700">{fmtGs(p.importe_vendido)}</td>
                      <td className="px-3 py-2.5 text-center">
                        <span className={`inline-flex h-6 w-6 items-center justify-center rounded-full text-xs font-bold ${RANGO_BADGE[p.rango]}`}>{p.rango}</span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
