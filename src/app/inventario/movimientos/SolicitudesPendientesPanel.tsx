"use client";

/**
 * Panel de SOLICITUDES de cambio de stock pendientes de aprobación.
 * Solo visible para administradores y solo cuando hay solicitudes pendientes.
 * El admin ve el producto, el vendedor que la pidió y decide Aprobar / Rechazar.
 */
import { useCallback, useEffect, useState } from "react";
import { Loader2, Check, X, ShieldQuestion } from "lucide-react";
import { useIsAdmin } from "@/lib/auth/use-is-admin";
import { getSolicitudesPendientes, decidirMovimiento } from "@/lib/inventario/storage";
import type { MovimientoInventario } from "@/lib/inventario/types";

function fmtCant(m: MovimientoInventario): string {
  const signo = m.tipo === "SALIDA" ? "−" : m.tipo === "AJUSTE" && m.cantidad < 0 ? "−" : "+";
  return `${signo}${Math.abs(m.cantidad).toLocaleString("es-PY")}`;
}

export default function SolicitudesPendientesPanel({ onResuelta }: { onResuelta?: () => void }) {
  const { isAdmin, loaded } = useIsAdmin();
  const [pendientes, setPendientes] = useState<MovimientoInventario[]>([]);
  const [cargando, setCargando] = useState(true);
  const [procesando, setProcesando] = useState<string | null>(null);

  const cargar = useCallback(async () => {
    setCargando(true);
    const list = await getSolicitudesPendientes();
    setPendientes(list);
    setCargando(false);
  }, []);

  useEffect(() => {
    if (loaded && isAdmin) void cargar();
    else setCargando(false);
  }, [loaded, isAdmin, cargar]);

  async function decidir(id: string, accion: "aprobar" | "rechazar") {
    if (procesando) return;
    let motivo: string | undefined;
    if (accion === "rechazar") {
      motivo = window.prompt("Motivo del rechazo (opcional):") ?? undefined;
    }
    setProcesando(id);
    const r = await decidirMovimiento(id, accion, motivo);
    setProcesando(null);
    if (!r.ok) {
      alert(r.error ?? "No se pudo procesar la solicitud.");
      return;
    }
    await cargar();
    onResuelta?.();
  }

  // No mostrar nada si no es admin, está cargando el rol, o no hay pendientes.
  if (!loaded || !isAdmin) return null;
  if (cargando) return null;
  if (pendientes.length === 0) return null;

  return (
    <section className="mb-6 rounded-2xl border-2 border-amber-300/60 bg-amber-50/60 p-4 shadow-sm">
      <div className="mb-3 flex items-center gap-2">
        <ShieldQuestion className="h-5 w-5 text-amber-600" />
        <h2 className="text-sm font-bold text-amber-900">
          Solicitudes de cambio de stock pendientes ({pendientes.length})
        </h2>
      </div>
      <div className="space-y-2">
        {pendientes.map((m) => (
          <div
            key={m.id}
            className="flex flex-wrap items-center justify-between gap-3 rounded-xl border border-amber-200 bg-white px-3 py-2.5"
          >
            <div className="min-w-0">
              <p className="truncate text-sm font-semibold text-slate-800">
                {m.producto_nombre}
                {m.producto_sku ? <span className="ml-1.5 text-xs font-normal text-slate-400">{m.producto_sku}</span> : null}
              </p>
              <p className="text-[11px] text-slate-500">
                {m.tipo} · <span className="font-semibold tabular-nums">{fmtCant(m)}</span>
                {" · "}pedido por {m.solicitado_por_nombre ?? m.usuario_nombre ?? "—"}
              </p>
            </div>
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => void decidir(m.id, "rechazar")}
                disabled={procesando === m.id}
                className="inline-flex items-center gap-1 rounded-lg border border-red-200 bg-white px-3 py-1.5 text-xs font-semibold text-red-700 hover:bg-red-50 disabled:opacity-50"
              >
                <X className="h-3.5 w-3.5" /> Rechazar
              </button>
              <button
                type="button"
                onClick={() => void decidir(m.id, "aprobar")}
                disabled={procesando === m.id}
                className="inline-flex items-center gap-1 rounded-lg bg-emerald-600 px-3 py-1.5 text-xs font-semibold text-white hover:bg-emerald-700 disabled:opacity-50"
              >
                {procesando === m.id ? <Loader2 className="h-3.5 w-3.5 animate-spin" /> : <Check className="h-3.5 w-3.5" />}
                Aprobar
              </button>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
