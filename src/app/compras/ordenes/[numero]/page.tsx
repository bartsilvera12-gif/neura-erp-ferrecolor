"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { Loader2 } from "lucide-react";
import { getOrdenCompra, cancelarOrdenCompra, recibirOrdenCompra } from "@/lib/ordenes-compra/storage";
import { uploadComprobante } from "@/lib/compras/storage";
import type { OrdenCompra, EstadoOrdenCompra } from "@/lib/ordenes-compra/types";

function fmtGs(v: number) {
  return `Gs. ${Math.round(v).toLocaleString("es-PY")}`;
}
function fmtFecha(iso: string | null | undefined) {
  if (!iso) return "—";
  try {
    const d = new Date(iso);
    return `${String(d.getDate()).padStart(2, "0")}/${String(d.getMonth() + 1).padStart(2, "0")}/${d.getFullYear()} ${String(d.getHours()).padStart(2, "0")}:${String(d.getMinutes()).padStart(2, "0")}`;
  } catch {
    return iso;
  }
}
const IVA_LBL: Record<string, string> = { exenta: "Exenta", "5": "5%", "10": "10%" };
const ESTADO_BADGE: Record<EstadoOrdenCompra, string> = {
  abierta: "bg-[var(--badge-warning-bg)] text-[var(--badge-warning-text)]",
  recibida: "bg-[var(--badge-success-bg)] text-[var(--badge-success-text)]",
  cancelada: "bg-slate-100 text-slate-500",
};
const ESTADO_LBL: Record<EstadoOrdenCompra, string> = { abierta: "Abierta", recibida: "Recibida", cancelada: "Cancelada" };

export default function OrdenCompraDetallePage() {
  const params = useParams<{ numero: string }>();
  const numeroOc = decodeURIComponent(String(params.numero));

  const [lineas, setLineas] = useState<OrdenCompra[]>([]);
  const [cargando, setCargando] = useState(true);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);

  // Modal recibir
  const [showRecibir, setShowRecibir] = useState(false);
  const [numeroFactura, setNumeroFactura] = useState("");
  const [nroTimbrado, setNroTimbrado] = useState("");
  const [tipoPago, setTipoPago] = useState<"contado" | "credito">("contado");
  const [plazoDias, setPlazoDias] = useState("");
  const [comprobanteFile, setComprobanteFile] = useState<File | null>(null);
  const [procesando, setProcesando] = useState(false);

  const cargar = useCallback(async () => {
    setCargando(true);
    const l = await getOrdenCompra(numeroOc);
    setLineas(l);
    setCargando(false);
  }, [numeroOc]);
  useEffect(() => { cargar(); }, [cargar]);

  const cab = lineas[0];
  const total = useMemo(() => lineas.reduce((s, l) => s + l.total, 0), [lineas]);
  const subtotal = useMemo(() => lineas.reduce((s, l) => s + l.subtotal, 0), [lineas]);
  const totalIva = useMemo(() => lineas.reduce((s, l) => s + l.monto_iva, 0), [lineas]);

  async function onCancelar() {
    if (!confirm("¿Cancelar esta orden de compra? No se podrá recibir después.")) return;
    const motivo = prompt("Motivo (opcional):") ?? null;
    setProcesando(true);
    setErr(null);
    const r = await cancelarOrdenCompra(numeroOc, motivo);
    setProcesando(false);
    if (!r.success) { setErr(r.error); return; }
    setMsg("Orden cancelada.");
    cargar();
  }

  async function onRecibir(e: React.FormEvent) {
    e.preventDefault();
    setErr(null);
    if (!numeroFactura.trim()) { setErr("Ingresá el N° de factura."); return; }
    if (!nroTimbrado.trim()) { setErr("Ingresá el N° de timbrado."); return; }
    setProcesando(true);
    try {
      let comp: { comprobante_storage_path: string; comprobante_nombre: string; comprobante_mime_type: string } | null = null;
      if (comprobanteFile) {
        const up = await uploadComprobante(comprobanteFile);
        if (!up.ok) { setErr(`Comprobante: ${up.error}`); return; }
        comp = up.data;
      }
      const r = await recibirOrdenCompra(numeroOc, {
        numero_factura: numeroFactura,
        nro_timbrado: nroTimbrado,
        tipo_pago: tipoPago,
        plazo_dias: tipoPago === "credito" && plazoDias ? parseInt(plazoDias) : undefined,
        comprobante_storage_path: comp?.comprobante_storage_path ?? null,
        comprobante_nombre: comp?.comprobante_nombre ?? null,
        comprobante_mime_type: comp?.comprobante_mime_type ?? null,
      });
      if (!r.success) { setErr(r.error); return; }
      if (r.warning) alert(r.warning);
      setShowRecibir(false);
      setMsg(`Compra ${r.numero_control} registrada e ingresada al stock.`);
      cargar();
    } finally {
      setProcesando(false);
    }
  }

  if (cargando) return <p className="py-10 text-center text-slate-500 animate-pulse">Cargando…</p>;
  if (!cab) {
    return (
      <div className="space-y-4">
        <Link href="/compras/ordenes" className="text-sm text-slate-500 hover:text-[#3F8E91]">← Órdenes de compra</Link>
        <p className="text-slate-500">Orden de compra no encontrada.</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <Link href="/compras/ordenes" className="inline-flex items-center gap-1 text-sm font-medium text-slate-500 hover:text-[#3F8E91]">
        ← Órdenes de compra
      </Link>

      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <div className="flex items-center gap-3">
            <h1 className="font-mono text-2xl font-bold text-slate-900">{cab.numero_oc}</h1>
            <span className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold ${ESTADO_BADGE[cab.estado]}`}>
              {ESTADO_LBL[cab.estado]}
            </span>
          </div>
          <p className="mt-1 text-sm text-slate-500">
            {cab.proveedor_nombre || "—"} · {fmtFecha(cab.fecha)}
          </p>
        </div>
        {cab.estado === "abierta" && (
          <div className="flex items-center gap-2">
            <button onClick={onCancelar} disabled={procesando}
              className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm font-semibold text-red-700 hover:bg-red-100 disabled:opacity-50">
              Cancelar OC
            </button>
            <button onClick={() => { setShowRecibir(true); setErr(null); }} disabled={procesando}
              className="rounded-lg bg-[#4FAEB2] px-4 py-2 text-sm font-bold text-white shadow-sm shadow-[#4FAEB2]/30 hover:bg-[#3F8E91] disabled:opacity-50">
              Registrar compra (recibir)
            </button>
          </div>
        )}
      </div>

      {msg && <p className="rounded-lg border border-emerald-200 bg-emerald-50 px-3 py-2 text-sm text-emerald-800">{msg}</p>}
      {err && !showRecibir && <p className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">{err}</p>}

      {cab.estado === "recibida" && cab.compra_numero_control && (
        <p className="rounded-lg border border-[#4FAEB2]/30 bg-[#E5F4F4] px-3 py-2 text-sm text-[#3F8E91]">
          Recibida el {fmtFecha(cab.recibida_at)} → compra <span className="font-mono font-bold">{cab.compra_numero_control}</span>.{" "}
          <Link href="/compras" className="font-semibold underline">Ver en Compras</Link>
        </p>
      )}
      {cab.estado === "cancelada" && (
        <p className="rounded-lg border border-slate-200 bg-slate-50 px-3 py-2 text-sm text-slate-600">
          Cancelada el {fmtFecha(cab.cancelada_at)}{cab.cancelada_motivo ? ` · ${cab.cancelada_motivo}` : ""}.
        </p>
      )}

      {/* Ítems */}
      <div className="overflow-x-auto rounded-2xl border border-slate-200 bg-white shadow-sm">
        <table className="w-full min-w-[720px] text-sm">
          <thead className="border-b-2 border-[#4FAEB2]/40 bg-[#E5F4F4]">
            <tr>
              {["Producto", "Cant.", "Costo unit.", "IVA", "Subtotal", "Total"].map((h, i) => (
                <th key={h} className={`px-4 py-3 text-xs font-bold uppercase tracking-wide text-[#3F8E91] ${i === 0 ? "text-left" : i === 3 ? "text-center" : "text-right"}`}>{h}</th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100">
            {lineas.map((l) => (
              <tr key={l.id}>
                <td className="px-4 py-3 font-medium text-slate-900">{l.producto_nombre}</td>
                <td className="px-4 py-3 text-right tabular-nums text-slate-700">{l.cantidad}</td>
                <td className="px-4 py-3 text-right tabular-nums text-slate-600">{fmtGs(l.costo_unitario)}</td>
                <td className="px-4 py-3 text-center text-slate-600">{IVA_LBL[l.iva_tipo] ?? l.iva_tipo}</td>
                <td className="px-4 py-3 text-right tabular-nums text-slate-600">{fmtGs(l.subtotal)}</td>
                <td className="px-4 py-3 text-right tabular-nums font-semibold text-slate-900">{fmtGs(l.total)}</td>
              </tr>
            ))}
          </tbody>
          <tfoot>
            <tr className="border-t-2 border-slate-200 bg-slate-50">
              <td colSpan={4} className="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wide text-slate-500">Totales</td>
              <td className="px-4 py-3 text-right tabular-nums text-slate-600">{fmtGs(subtotal)}</td>
              <td className="px-4 py-3 text-right tabular-nums font-bold text-slate-900">{fmtGs(total)}</td>
            </tr>
            <tr>
              <td colSpan={6} className="px-4 py-2 text-right text-xs text-slate-500">IVA incluido: {fmtGs(totalIva)}</td>
            </tr>
          </tfoot>
        </table>
      </div>

      {/* Modal Recibir */}
      {showRecibir && (
        <div className="fixed inset-0 z-40 flex items-center justify-center bg-slate-900/40 p-4">
          <form onSubmit={onRecibir} className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl">
            <h3 className="text-lg font-bold text-slate-900">Registrar compra</h3>
            <p className="mt-1 text-xs text-slate-500">
              Se toma la OC tal cual e impacta el stock. Cargá los datos de la factura del proveedor.
            </p>

            <div className="mt-4 space-y-3">
              <div>
                <label className="mb-1 block text-xs font-semibold text-slate-600">N° de factura <span className="text-red-500">*</span></label>
                <input value={numeroFactura} onChange={(e) => setNumeroFactura(e.target.value)} placeholder="001-001-0000123"
                  className="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30" />
              </div>
              <div>
                <label className="mb-1 block text-xs font-semibold text-slate-600">N° de timbrado <span className="text-red-500">*</span></label>
                <input value={nroTimbrado} onChange={(e) => setNroTimbrado(e.target.value)} placeholder="Ej: 12345678"
                  className="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30" />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="mb-1 block text-xs font-semibold text-slate-600">Tipo de pago</label>
                  <select value={tipoPago} onChange={(e) => setTipoPago(e.target.value as "contado" | "credito")}
                    className="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30">
                    <option value="contado">Contado</option>
                    <option value="credito">Crédito</option>
                  </select>
                </div>
                {tipoPago === "credito" && (
                  <div>
                    <label className="mb-1 block text-xs font-semibold text-slate-600">Plazo (días)</label>
                    <input type="number" min={1} value={plazoDias} onChange={(e) => setPlazoDias(e.target.value)}
                      className="w-full rounded-lg border border-slate-200 px-3 py-2 text-sm outline-none focus:ring-2 focus:ring-[#4FAEB2]/30" />
                  </div>
                )}
              </div>
              <div>
                <label className="mb-1 block text-xs font-semibold text-slate-600">Comprobante / factura <span className="font-normal text-slate-400">(opcional)</span></label>
                <input type="file" accept="image/jpeg,image/png,image/webp,application/pdf"
                  onChange={(e) => setComprobanteFile(e.target.files?.[0] ?? null)}
                  className="block w-full text-xs text-slate-600 file:mr-3 file:rounded-lg file:border-0 file:bg-[#4FAEB2] file:px-3 file:py-1.5 file:text-xs file:font-semibold file:text-white hover:file:bg-[#3F8E91]" />
              </div>
              {err && <p className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-xs text-red-700">{err}</p>}
            </div>

            <div className="mt-5 flex items-center justify-end gap-2">
              <button type="button" onClick={() => setShowRecibir(false)} disabled={procesando}
                className="rounded-lg border border-slate-200 px-3 py-2 text-sm font-medium text-slate-600 hover:bg-slate-50 disabled:opacity-50">
                Cancelar
              </button>
              <button type="submit" disabled={procesando}
                className="inline-flex items-center gap-2 rounded-lg bg-[#4FAEB2] px-4 py-2 text-sm font-bold text-white hover:bg-[#3F8E91] disabled:opacity-50">
                {procesando && <Loader2 className="h-4 w-4 animate-spin" />}
                Confirmar e ingresar stock
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
}
