"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import EdgeScrollArea from "@/components/ui/EdgeScrollArea";
import {
  getNotasCreditoCompra,
  confirmarNotaCreditoCompra,
} from "@/lib/compras/nc-compra-storage";
import type { EstadoNotaCreditoCompra, NotaCreditoCompra } from "@/lib/compras/types";

function formatGs(valor: number) {
  return `Gs. ${Math.round(valor).toLocaleString("es-PY")}`;
}

function formatFecha(iso: string) {
  try {
    const d = new Date(iso);
    const dd = String(d.getDate()).padStart(2, "0");
    const mm = String(d.getMonth() + 1).padStart(2, "0");
    return `${dd}/${mm}/${d.getFullYear()}`;
  } catch {
    return iso;
  }
}

const estadoBadge: Record<EstadoNotaCreditoCompra, string> = {
  borrador: "bg-amber-50 text-amber-700",
  confirmada: "bg-green-50 text-green-700",
  anulada: "bg-gray-100 text-gray-500",
};
const estadoLabel: Record<EstadoNotaCreditoCompra, string> = {
  borrador: "Borrador",
  confirmada: "Confirmada",
  anulada: "Anulada",
};

export default function NotasCreditoCompraPage() {
  const [notas, setNotas] = useState<NotaCreditoCompra[]>([]);
  const [cargando, setCargando] = useState(true);
  const [confirmando, setConfirmando] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function recargar() {
    setCargando(true);
    const data = await getNotasCreditoCompra();
    setNotas(data);
    setCargando(false);
  }

  useEffect(() => { recargar(); }, []);

  async function handleConfirmar(nc: NotaCreditoCompra) {
    setError(null);
    const productos = nc.items.map((i) => `${i.cantidad}× ${i.producto_nombre}`).join(", ");
    const ok = window.confirm(
      `Confirmar ${nc.numero_control}?\n\nSe descontará del stock: ${productos}.\n\nEsta acción impacta el inventario y no se puede deshacer desde acá.`
    );
    if (!ok) return;
    setConfirmando(nc.id);
    try {
      const res = await confirmarNotaCreditoCompra(nc.id);
      if (!res.success) { setError(res.error); return; }
      if (res.data.ya_confirmada) {
        setError("Esta nota ya estaba confirmada; no se duplicó el descuento de stock.");
      }
      await recargar();
    } finally {
      setConfirmando(null);
    }
  }

  return (
    <div className="space-y-8">
      <div>
        <div className="flex items-center gap-2">
          <span
            aria-hidden="true"
            className="inline-block h-1.5 w-1.5 rounded-full bg-[#4FAEB2]"
            style={{ boxShadow: "0 0 0 3px rgba(79, 174, 178, 0.18)" }}
          />
          <p className="text-[11px] font-semibold uppercase tracking-[0.18em] text-[#4FAEB2]">
            Zentra · Adquisiciones
          </p>
        </div>
        <h1 className="mt-1 text-lg font-semibold tracking-tight text-slate-900">
          Notas de crédito de compra
        </h1>
        <p className="mt-0.5 text-xs text-slate-500">
          NC recibidas de proveedores. Al confirmar, la mercadería devuelta sale del stock.
        </p>
      </div>

      <div className="bg-white border border-slate-200 rounded-xl shadow-sm ring-1 ring-[#4FAEB2]/15 p-6">
        <div className="flex justify-between items-center mb-5">
          <h2 className="text-xl font-semibold">Notas de crédito recibidas</h2>
          <Link
            href="/compras/notas-credito/nueva"
            className="rounded-lg bg-[#4FAEB2] px-3 py-1.5 text-xs font-semibold text-white shadow-sm shadow-[#4FAEB2]/25 transition-colors hover:bg-[#3F8E91] active:scale-95"
          >
            + Nueva NC de compra
          </Link>
        </div>

        {error && (
          <div className="mb-4 bg-red-50 border border-red-200 rounded-lg p-3">
            <p className="text-sm text-red-700">{error}</p>
          </div>
        )}

        <EdgeScrollArea>
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b text-gray-500">
                <th className="py-3 pr-4 font-medium">N° Control</th>
                <th className="py-3 pr-4 font-medium">Proveedor</th>
                <th className="py-3 pr-4 font-medium">N° Comprobante</th>
                <th className="py-3 pr-4 font-medium">Productos</th>
                <th className="py-3 pr-4 font-medium text-right">Total</th>
                <th className="py-3 pr-4 font-medium">Estado</th>
                <th className="py-3 pr-4 font-medium">Fecha</th>
                <th className="py-3 font-medium text-right">Acción</th>
              </tr>
            </thead>
            <tbody>
              {cargando ? (
                <tr><td colSpan={8} className="py-12 text-center text-gray-400">Cargando…</td></tr>
              ) : notas.length === 0 ? (
                <tr><td colSpan={8} className="py-12 text-center text-gray-400">
                  No hay notas de crédito de compra registradas
                </td></tr>
              ) : (
                notas.map((nc) => (
                  <tr key={nc.id} className="border-b border-slate-200 last:border-0 hover:bg-[#4FAEB2]/[0.04] transition-colors align-top">
                    <td className="py-4 pr-4 font-mono text-xs text-gray-500">{nc.numero_control}</td>
                    <td className="py-4 pr-4 font-medium text-gray-800">{nc.proveedor_nombre}</td>
                    <td className="py-4 pr-4 text-gray-600">{nc.nro_comprobante ?? "—"}</td>
                    <td className="py-4 pr-4 text-gray-600 text-xs max-w-xs">
                      {nc.items.map((i) => (
                        <div key={i.id}>
                          {i.cantidad}× {i.producto_nombre}
                        </div>
                      ))}
                    </td>
                    <td className="py-4 pr-4 text-right tabular-nums font-semibold text-gray-800">
                      {formatGs(nc.total)}
                    </td>
                    <td className="py-4 pr-4">
                      <span className={`px-2 py-1 rounded-full text-xs font-semibold ${estadoBadge[nc.estado]}`}>
                        {estadoLabel[nc.estado]}
                      </span>
                    </td>
                    <td className="py-4 pr-4 text-gray-500 text-xs tabular-nums">{formatFecha(nc.fecha)}</td>
                    <td className="py-4 text-right">
                      {nc.estado === "borrador" ? (
                        <button
                          onClick={() => handleConfirmar(nc)}
                          disabled={confirmando === nc.id}
                          className="rounded-lg bg-green-600 px-3 py-1.5 text-xs font-semibold text-white transition-colors hover:bg-green-700 active:scale-95 disabled:opacity-40 disabled:cursor-not-allowed"
                        >
                          {confirmando === nc.id ? "Confirmando…" : "Confirmar"}
                        </button>
                      ) : (
                        <span className="text-xs text-gray-400">—</span>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </EdgeScrollArea>
      </div>
    </div>
  );
}
