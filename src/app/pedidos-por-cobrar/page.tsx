"use client";

/**
 * /pedidos-por-cobrar — Cola de Caja.
 *
 * Lista los pedidos que el cajero tiene que cobrar (estados `pendiente` y
 * `en_caja`) y permite realizar el cobro. El cobro se sacó del listado
 * general /pedidos (que ahora es solo gestión: ver/editar/cancelar).
 *
 * Acción "Cobrar": marca el pedido `en_caja` (POST /tomar) y redirige a
 * /ventas/nueva?pedido_caja_id=... para facturarlo.
 */

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  Search,
  X,
  Clock,
  Lock,
  Receipt,
  Eye,
  ArrowRight,
  Unlock,
  Loader2,
} from "lucide-react";
import { fetchWithSupabaseSession } from "@/lib/api/fetch-with-supabase-session";

type PedidoCobrable = {
  id: string;
  numero: string | null;
  titulo: string;
  cliente_nombre: string | null;
  total_estimado: number;
  items_count: number;
  estado: "pendiente" | "en_caja";
  armado_por_email: string | null;
  abierto_por_email: string | null;
  created_at: string | null;
};

function fmtGs(n: number) {
  return `Gs. ${Math.round(n || 0).toLocaleString("es-PY")}`;
}
function fmtFecha(iso: string | null) {
  if (!iso) return "—";
  try {
    const d = new Date(iso);
    return (
      d.toLocaleDateString("es-PY", { day: "2-digit", month: "2-digit", year: "2-digit" }) +
      " · " +
      d.toLocaleTimeString("es-PY", { hour: "2-digit", minute: "2-digit" })
    );
  } catch {
    return iso;
  }
}

function mapPedido(p: Record<string, unknown>): PedidoCobrable {
  return {
    id: String(p.id),
    numero: p.numero ? String(p.numero) : null,
    titulo: String(p.titulo ?? ""),
    cliente_nombre: p.cliente_nombre ? String(p.cliente_nombre) : null,
    total_estimado: Number(p.total_estimado) || 0,
    items_count: Array.isArray(p.items) ? (p.items as unknown[]).length : 0,
    estado: p.estado === "en_caja" ? "en_caja" : "pendiente",
    armado_por_email: p.armado_por_email ? String(p.armado_por_email) : null,
    abierto_por_email: p.abierto_por_email ? String(p.abierto_por_email) : null,
    created_at: p.created_at ? String(p.created_at) : null,
  };
}

export default function PedidosPorCobrarPage() {
  const router = useRouter();
  const [items, setItems] = useState<PedidoCobrable[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busqueda, setBusqueda] = useState("");
  const [busquedaDebounced, setBusquedaDebounced] = useState("");
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    const t = setTimeout(() => setBusquedaDebounced(busqueda), 350);
    return () => clearTimeout(t);
  }, [busqueda]);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const qParam = busquedaDebounced.trim() ? `&q=${encodeURIComponent(busquedaDebounced.trim())}` : "";
      // Cobrables = pendiente + en_caja. Dos consultas en paralelo y se unen.
      const [rPend, rCaja] = await Promise.all([
        fetchWithSupabaseSession(`/api/pedidos-caja?estado=pendiente${qParam}`, { cache: "no-store" }),
        fetchWithSupabaseSession(`/api/pedidos-caja?estado=en_caja${qParam}`, { cache: "no-store" }),
      ]);
      const [jPend, jCaja] = await Promise.all([rPend.json(), rCaja.json()]);
      if (!rPend.ok || !jPend?.success) throw new Error(jPend?.error ?? "No se pudo cargar");
      if (!rCaja.ok || !jCaja?.success) throw new Error(jCaja?.error ?? "No se pudo cargar");
      const pend = (jPend.data?.pedidos ?? []) as Array<Record<string, unknown>>;
      const caja = (jCaja.data?.pedidos ?? []) as Array<Record<string, unknown>>;
      const merged = [...pend, ...caja].map(mapPedido);
      // En caja primero (lo que ya está tomado), luego por fecha desc.
      merged.sort((a, b) => {
        if (a.estado !== b.estado) return a.estado === "en_caja" ? -1 : 1;
        return (b.created_at ?? "").localeCompare(a.created_at ?? "");
      });
      setItems(merged);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Error de red");
    } finally {
      setLoading(false);
    }
  }, [busquedaDebounced]);

  useEffect(() => {
    load();
  }, [load]);

  async function handleCobrar(p: PedidoCobrable) {
    setBusyId(p.id);
    try {
      if (p.estado === "pendiente") {
        const r = await fetchWithSupabaseSession(`/api/pedidos-caja/${p.id}/tomar`, { method: "POST" });
        const j = await r.json();
        if (!r.ok || !j?.success) {
          // No bloqueamos: create-venta acepta facturar pendiente o en_caja.
          console.warn("tomar fallo:", j?.error);
        }
      }
      router.push(`/ventas/nueva?pedido_caja_id=${p.id}`);
    } finally {
      setBusyId(null);
    }
  }

  async function handleLiberar(p: PedidoCobrable) {
    setBusyId(p.id);
    try {
      const r = await fetchWithSupabaseSession(`/api/pedidos-caja/${p.id}/liberar`, { method: "POST" });
      const j = await r.json();
      if (!r.ok || !j?.success) throw new Error(j?.error ?? "Error");
      await load();
    } catch (e) {
      window.alert(e instanceof Error ? e.message : "No se pudo liberar.");
    } finally {
      setBusyId(null);
    }
  }

  const inputClass =
    "h-10 rounded-lg border-2 border-slate-200 bg-white px-3 text-sm outline-none transition-all hover:border-slate-300 focus:border-[#4FAEB2] focus:ring-2 focus:ring-[#4FAEB2]/20";

  const totalAcobrar = items.reduce((s, p) => s + p.total_estimado, 0);

  return (
    <div className="w-full py-8 px-4 sm:px-6 lg:px-8 space-y-6">
      {/* Header */}
      <header className="flex items-start justify-between gap-4 flex-wrap">
        <div>
          <div className="inline-flex items-center gap-2 rounded-full bg-[#4FAEB2]/8 border border-[#4FAEB2]/30 px-3 py-1 text-[10.5px] font-bold uppercase tracking-[0.14em] text-[#3F8E91] mb-3">
            <Receipt className="h-3 w-3 text-[#4FAEB2]" />
            Operaciones · Caja
          </div>
          <h1 className="text-3xl sm:text-4xl font-bold text-slate-800 tracking-tight leading-tight">
            Pedidos por cobrar
          </h1>
          <p className="text-[14px] text-slate-500 mt-1.5">
            Cola de caja: cobrá y facturá los pedidos que armaron los vendedores. El stock se descuenta al facturar.
          </p>
        </div>
        <Link
          href="/pedidos"
          className="inline-flex items-center gap-2 rounded-lg border border-slate-200 bg-white px-3 py-2.5 text-sm font-semibold text-slate-700 hover:border-[#4FAEB2] hover:text-[#3F8E91]"
        >
          Ver todos los pedidos →
        </Link>
      </header>

      {/* Card */}
      <section className="bg-white rounded-2xl border-2 border-[#4FAEB2]/20 shadow-[0_2px_10px_-2px_rgba(79,174,178,0.12)] overflow-hidden">
        {/* Buscador */}
        <div className="px-5 py-4 border-b border-[#4FAEB2]/15 bg-gradient-to-r from-[#4FAEB2]/5 to-transparent">
          <div className="relative max-w-xl">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
            <input
              type="text"
              placeholder="Buscar por número, cliente o vendedor..."
              value={busqueda}
              onChange={(e) => setBusqueda(e.target.value)}
              className={`${inputClass} w-full pl-9 pr-9`}
            />
            {busqueda && (
              <button
                onClick={() => setBusqueda("")}
                className="absolute right-2.5 top-1/2 -translate-y-1/2 rounded p-0.5 text-slate-400 hover:bg-slate-100 hover:text-slate-700"
              >
                <X className="h-3.5 w-3.5" />
              </button>
            )}
          </div>
        </div>

        {/* Tabla */}
        <div className="overflow-x-auto">
          <table className="w-full min-w-[860px] text-left text-sm">
            <thead className="bg-slate-50/70 text-slate-500 text-[11px] uppercase tracking-wider">
              <tr>
                <th className="px-5 py-3 font-semibold">Pedido</th>
                <th className="px-3 py-3 font-semibold">Cliente</th>
                <th className="px-3 py-3 font-semibold">Vendedor</th>
                <th className="px-3 py-3 text-right font-semibold">Items</th>
                <th className="px-3 py-3 text-right font-semibold">Total</th>
                <th className="px-3 py-3 font-semibold">Estado</th>
                <th className="px-3 py-3 font-semibold">Fecha</th>
                <th className="px-3 py-3 text-right font-semibold">Acción</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                <tr>
                  <td colSpan={8} className="py-12 text-center text-sm text-slate-400">
                    Cargando...
                  </td>
                </tr>
              ) : items.length === 0 ? (
                <tr>
                  <td colSpan={8} className="py-16 text-center">
                    <div className="inline-flex items-center justify-center h-14 w-14 rounded-2xl bg-[#4FAEB2]/8 border border-[#4FAEB2]/20 mb-3">
                      <Receipt className="h-6 w-6 text-[#4FAEB2]" />
                    </div>
                    <p className="text-sm font-semibold text-slate-700">
                      {error ?? "No hay pedidos por cobrar"}
                    </p>
                    {!error && (
                      <p className="mt-1 text-xs text-slate-400">
                        Cuando los vendedores armen pedidos, aparecerán acá para cobrar.
                      </p>
                    )}
                  </td>
                </tr>
              ) : (
                items.map((p) => (
                  <tr key={p.id} className="hover:bg-[#4FAEB2]/3 transition-colors">
                    <td className="px-5 py-3 font-bold text-slate-800 font-mono text-xs whitespace-nowrap">
                      <Link href={`/pedidos/${p.id}`} className="hover:text-[#3F8E91] hover:underline" title="Ver detalle del pedido">
                        {p.numero ?? p.titulo}
                      </Link>
                    </td>
                    <td className="px-3 py-3 text-slate-600">
                      {p.cliente_nombre ?? <span className="text-slate-300">— Sin cliente</span>}
                    </td>
                    <td className="px-3 py-3 text-slate-500 text-xs">
                      {p.armado_por_email ?? <span className="text-slate-300">—</span>}
                    </td>
                    <td className="px-3 py-3 text-right tabular-nums text-slate-700">{p.items_count}</td>
                    <td className="px-3 py-3 text-right tabular-nums font-bold text-slate-900">{fmtGs(p.total_estimado)}</td>
                    <td className="px-3 py-3">
                      {p.estado === "en_caja" ? (
                        <span
                          className="inline-flex items-center gap-1 rounded-md bg-sky-50 border border-sky-200 px-2 py-0.5 text-[11px] font-semibold text-sky-700"
                          title={p.abierto_por_email ? `Tomado por ${p.abierto_por_email}` : undefined}
                        >
                          <Lock className="h-3 w-3" />
                          En caja
                          {p.abierto_por_email && (
                            <span className="text-sky-500 font-normal hidden sm:inline">· {p.abierto_por_email.split("@")[0]}</span>
                          )}
                        </span>
                      ) : (
                        <span className="inline-flex items-center gap-1 rounded-md bg-amber-50 border border-amber-200 px-2 py-0.5 text-[11px] font-semibold text-amber-700">
                          <Clock className="h-3 w-3" />
                          Pendiente
                        </span>
                      )}
                    </td>
                    <td className="px-3 py-3 text-xs text-slate-500 tabular-nums whitespace-nowrap">{fmtFecha(p.created_at)}</td>
                    <td className="px-3 py-3">
                      <div className="flex items-center justify-end gap-1.5">
                        <Link
                          href={`/pedidos/${p.id}`}
                          className="inline-flex items-center gap-1 rounded-md border border-slate-200 bg-white px-2 py-1 text-xs font-semibold text-slate-700 hover:border-[#4FAEB2] hover:text-[#3F8E91]"
                          title="Ver detalle"
                        >
                          <Eye className="h-3 w-3" />
                        </Link>
                        {p.estado === "en_caja" && (
                          <button
                            type="button"
                            onClick={() => handleLiberar(p)}
                            disabled={busyId === p.id}
                            className="inline-flex items-center gap-1 rounded-md border border-slate-200 bg-white px-2 py-1 text-xs font-semibold text-slate-700 hover:border-sky-400 hover:text-sky-700 disabled:opacity-50"
                            title="Liberar pedido (volver a pendiente)"
                          >
                            <Unlock className="h-3 w-3" />
                          </button>
                        )}
                        <button
                          type="button"
                          onClick={() => handleCobrar(p)}
                          disabled={busyId === p.id}
                          className="inline-flex items-center gap-1 rounded-lg bg-[#4FAEB2] hover:bg-[#3F8E91] text-white text-xs font-bold px-3 py-1.5 transition-colors shadow-sm shadow-[#4FAEB2]/30 disabled:opacity-50"
                        >
                          {busyId === p.id ? (
                            <Loader2 className="h-3 w-3 animate-spin" />
                          ) : (
                            <>
                              Cobrar
                              <ArrowRight className="h-3 w-3" />
                            </>
                          )}
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>

        {/* Footer */}
        {!loading && items.length > 0 && (
          <div className="px-5 py-3 border-t border-slate-100 bg-slate-50/40 flex items-center justify-between text-xs text-slate-500">
            <span>
              <span className="font-semibold text-slate-700">{items.length}</span>{" "}
              {items.length === 1 ? "pedido por cobrar" : "pedidos por cobrar"}
            </span>
            <span>
              Total estimado:{" "}
              <span className="font-bold text-slate-800 tabular-nums">{fmtGs(totalAcobrar)}</span>
            </span>
          </div>
        )}
      </section>
    </div>
  );
}
