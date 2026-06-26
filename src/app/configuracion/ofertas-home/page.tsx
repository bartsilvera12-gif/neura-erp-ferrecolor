"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { fetchWithSupabaseSession } from "@/lib/api/fetch-with-supabase-session";
import { ArrowLeft, Calendar, Plus, X, Search, Loader2, Save } from "lucide-react";

interface ProductoLite {
  id: string;
  nombre: string;
  sku: string;
  precio_venta: number;
}

function isoToDatetimeLocal(iso: string | null): string {
  if (!iso) return "";
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return "";
  const pad = (n: number) => String(n).padStart(2, "0");
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}`;
}

function fmtGs(n: number): string {
  return "Gs. " + String(Math.round(Number(n) || 0)).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

export default function OfertasHomePage() {
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [okMsg, setOkMsg] = useState<string | null>(null);

  const [countdownEnd, setCountdownEnd] = useState("");
  const [selected, setSelected] = useState<ProductoLite[]>([]);

  // Picker state
  const [pickerOpen, setPickerOpen] = useState(false);
  const [pickerQuery, setPickerQuery] = useState("");
  const [pickerResults, setPickerResults] = useState<ProductoLite[]>([]);
  const [pickerLoading, setPickerLoading] = useState(false);

  // Cargar estado inicial
  useEffect(() => {
    let cancel = false;
    (async () => {
      try {
        const res = await fetchWithSupabaseSession("/api/configuracion/ofertas-home");
        const json = await res.json();
        if (cancel) return;
        if (!res.ok || !json?.success) throw new Error(json?.error || "Error al cargar");
        setCountdownEnd(isoToDatetimeLocal(json.countdownEnd));
        setSelected(Array.isArray(json.productos) ? json.productos : []);
      } catch (e) {
        if (!cancel) setError(e instanceof Error ? e.message : String(e));
      } finally {
        if (!cancel) setLoading(false);
      }
    })();
    return () => {
      cancel = true;
    };
  }, []);

  // Buscar productos en el picker (debounce 300ms)
  useEffect(() => {
    if (!pickerOpen) return;
    const q = pickerQuery.trim();
    if (q.length < 2) {
      setPickerResults([]);
      return;
    }
    setPickerLoading(true);
    const t = setTimeout(async () => {
      try {
        const res = await fetchWithSupabaseSession(
          `/api/productos/search?q=${encodeURIComponent(q)}&limit=15`
        );
        const json = await res.json();
        const rows: ProductoLite[] = Array.isArray(json?.data)
          ? json.data.map((r: { id: string; nombre: string; sku: string; precio_venta: number }) => ({
              id: r.id,
              nombre: r.nombre,
              sku: r.sku,
              precio_venta: Number(r.precio_venta) || 0,
            }))
          : [];
        setPickerResults(rows);
      } catch {
        setPickerResults([]);
      } finally {
        setPickerLoading(false);
      }
    }, 300);
    return () => clearTimeout(t);
  }, [pickerQuery, pickerOpen]);

  function addProducto(p: ProductoLite) {
    if (selected.some((s) => s.id === p.id)) return;
    if (selected.length >= 3) {
      setError("Máximo 3 productos.");
      return;
    }
    setSelected([...selected, p]);
    setPickerQuery("");
    setPickerOpen(false);
  }
  function removeProducto(id: string) {
    setSelected(selected.filter((s) => s.id !== id));
  }

  async function save() {
    setSaving(true);
    setError(null);
    setOkMsg(null);
    try {
      const body = {
        countdownEnd: countdownEnd
          ? new Date(countdownEnd).toISOString()
          : null,
        productosIds: selected.map((s) => s.id),
      };
      const res = await fetchWithSupabaseSession("/api/configuracion/ofertas-home", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      const json = await res.json();
      if (!res.ok || !json?.success) throw new Error(json?.error || "Error al guardar");
      setOkMsg("Cambios guardados ✓");
      setTimeout(() => setOkMsg(null), 2500);
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <Loader2 className="h-6 w-6 animate-spin text-gray-400" />
      </div>
    );
  }

  return (
    <div className="max-w-3xl mx-auto py-8 px-4">
      <Link
        href="/configuracion"
        className="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        <ArrowLeft className="h-4 w-4" /> Volver a Configuración
      </Link>

      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Ofertas de la semana (home)</h1>
        <p className="text-sm text-gray-500 mt-1">
          Configurá el banner &quot;Descuentos por tiempo limitado&quot; del sitio público. Elegí
          hasta 3 productos y la fecha en que termina la promoción.
        </p>
      </div>

      {error && (
        <div className="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
          {error}
        </div>
      )}
      {okMsg && (
        <div className="mb-4 rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700">
          {okMsg}
        </div>
      )}

      {/* Countdown */}
      <div className="bg-white rounded-xl border border-gray-200 p-6 mb-6">
        <h2 className="text-sm font-semibold text-gray-700 uppercase tracking-wide mb-3 flex items-center gap-2">
          <Calendar className="h-4 w-4 text-amber-600" />
          Fin del countdown
        </h2>
        <div className="flex gap-3 items-center">
          <input
            type="datetime-local"
            value={countdownEnd}
            onChange={(e) => setCountdownEnd(e.target.value)}
            className="rounded-lg border border-gray-300 px-3 py-2 text-sm focus:ring-2 focus:ring-amber-500 focus:border-transparent"
          />
          {countdownEnd && (
            <button
              type="button"
              onClick={() => setCountdownEnd("")}
              className="text-xs text-gray-500 hover:text-gray-700"
            >
              Quitar (sin countdown)
            </button>
          )}
        </div>
        <p className="mt-2 text-xs text-gray-500">
          Si lo dejás vacío, el contador no se muestra en el banner. Si lo configurás en el
          pasado, también queda oculto.
        </p>
      </div>

      {/* Productos */}
      <div className="bg-white rounded-xl border border-gray-200 p-6 mb-6">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-sm font-semibold text-gray-700 uppercase tracking-wide">
            Productos destacados ({selected.length}/3)
          </h2>
          {selected.length < 3 && (
            <button
              type="button"
              onClick={() => setPickerOpen(true)}
              className="inline-flex items-center gap-1.5 text-sm font-medium text-amber-600 hover:text-amber-700"
            >
              <Plus className="h-4 w-4" /> Agregar producto
            </button>
          )}
        </div>

        {selected.length === 0 ? (
          <p className="text-sm text-gray-500 py-4 text-center bg-gray-50 rounded-lg">
            Sin productos seleccionados todavía. El banner del home se ocultará.
          </p>
        ) : (
          <ul className="divide-y divide-gray-100">
            {selected.map((p) => (
              <li key={p.id} className="flex items-center justify-between gap-3 py-3">
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-gray-900 truncate">{p.nombre}</p>
                  <p className="text-xs text-gray-500 mt-0.5">
                    SKU: {p.sku} · {fmtGs(p.precio_venta)}
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => removeProducto(p.id)}
                  className="text-gray-400 hover:text-red-600 p-1"
                  title="Quitar"
                >
                  <X className="h-4 w-4" />
                </button>
              </li>
            ))}
          </ul>
        )}

        <p className="mt-3 text-xs text-gray-500">
          Asegurate de que cada producto seleccionado tenga un &quot;Descuento promocional&quot;
          configurado en su edición. Si no, en el home se ve el precio normal sin tachado.
        </p>
      </div>

      {/* Save */}
      <div className="flex justify-end gap-3">
        <button
          type="button"
          onClick={save}
          disabled={saving}
          className="inline-flex items-center gap-2 rounded-lg bg-amber-600 hover:bg-amber-700 disabled:opacity-50 disabled:cursor-not-allowed text-white font-medium px-5 py-2.5 text-sm transition-colors"
        >
          {saving ? (
            <Loader2 className="h-4 w-4 animate-spin" />
          ) : (
            <Save className="h-4 w-4" />
          )}
          {saving ? "Guardando..." : "Guardar cambios"}
        </button>
      </div>

      {/* Picker modal */}
      {pickerOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4"
          onClick={() => setPickerOpen(false)}
        >
          <div
            className="bg-white rounded-xl shadow-2xl w-full max-w-md max-h-[80vh] flex flex-col"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="p-4 border-b border-gray-200">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                <input
                  type="text"
                  autoFocus
                  value={pickerQuery}
                  onChange={(e) => setPickerQuery(e.target.value)}
                  placeholder="Buscar por nombre o SKU..."
                  className="w-full pl-10 pr-3 py-2 rounded-lg border border-gray-300 text-sm focus:ring-2 focus:ring-amber-500 focus:border-transparent"
                />
              </div>
            </div>
            <div className="flex-1 overflow-y-auto p-2">
              {pickerLoading && (
                <div className="py-8 text-center">
                  <Loader2 className="h-5 w-5 animate-spin text-gray-400 mx-auto" />
                </div>
              )}
              {!pickerLoading && pickerQuery.length < 2 && (
                <p className="text-sm text-gray-500 py-8 text-center">
                  Escribí al menos 2 caracteres para buscar.
                </p>
              )}
              {!pickerLoading && pickerQuery.length >= 2 && pickerResults.length === 0 && (
                <p className="text-sm text-gray-500 py-8 text-center">Sin resultados.</p>
              )}
              {!pickerLoading &&
                pickerResults.map((p) => {
                  const yaSel = selected.some((s) => s.id === p.id);
                  return (
                    <button
                      key={p.id}
                      type="button"
                      onClick={() => addProducto(p)}
                      disabled={yaSel}
                      className="w-full text-left px-3 py-2.5 rounded-lg hover:bg-amber-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                    >
                      <p className="text-sm font-medium text-gray-900 truncate">{p.nombre}</p>
                      <p className="text-xs text-gray-500 mt-0.5">
                        SKU: {p.sku} · {fmtGs(p.precio_venta)}{" "}
                        {yaSel && <span className="text-amber-600 ml-2">(ya seleccionado)</span>}
                      </p>
                    </button>
                  );
                })}
            </div>
            <div className="p-3 border-t border-gray-200 text-right">
              <button
                type="button"
                onClick={() => setPickerOpen(false)}
                className="text-sm text-gray-600 hover:text-gray-900 font-medium"
              >
                Cerrar
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
