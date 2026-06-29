"use client";

/**
 * /reportes/cajas/[id] — Detalle de un turno de caja (página completa).
 *
 * Reemplaza al modal: muestra el resumen del arqueo + la línea de tiempo
 * cronológica del turno (apertura, ventas y movimientos manuales).
 */

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { ArrowDownCircle, ArrowUpCircle, ShoppingCart, DoorOpen } from "lucide-react";
import PageHeader from "@/components/ui/PageHeader";
import { getCajaDetalle } from "@/lib/reportes/storage";
import type { CajaDetalle, MedioPagoCaja } from "@/lib/caja/types";

function formatGs(v: number) {
  return `Gs. ${Math.round(v).toLocaleString("es-PY")}`;
}
function formatHora(iso: string) {
  try {
    const d = new Date(iso);
    return `${String(d.getHours()).padStart(2, "0")}:${String(d.getMinutes()).padStart(2, "0")}`;
  } catch {
    return "—";
  }
}
function formatFechaHora(iso: string | null) {
  if (!iso) return "—";
  try {
    const d = new Date(iso);
    const fch = `${String(d.getDate()).padStart(2, "0")}/${String(d.getMonth() + 1).padStart(2, "0")}/${d.getFullYear()}`;
    return `${fch} ${formatHora(iso)}`;
  } catch {
    return iso;
  }
}

const MEDIO_LABEL: Record<MedioPagoCaja, string> = {
  efectivo: "Efectivo",
  tarjeta: "Tarjeta",
  transferencia: "Transferencia",
  otro: "Otro",
};

type TimelineRow = {
  key: string;
  ts: string;
  icon: React.ReactNode;
  tipo: string;
  tipoClass: string;
  detalle: string;
  medio: MedioPagoCaja | null;
  monto: number;
  signo: 1 | -1;
  tachado?: boolean;
};

export default function CajaDetalledPage() {
  const params = useParams<{ id: string }>();
  const cajaId = params?.id ?? "";
  const [data, setData] = useState<CajaDetalle | null>(null);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!cajaId) return;
    let cancel = false;
    setCargando(true);
    setError(null);
    getCajaDetalle(cajaId)
      .then((d) => {
        if (cancel) return;
        if (!d) setError("No se pudo cargar el detalle del turno.");
        setData(d);
      })
      .finally(() => {
        if (!cancel) setCargando(false);
      });
    return () => {
      cancel = true;
    };
  }, [cajaId]);

  const c = data?.caja;

  // Línea de tiempo unificada: apertura + ventas + movimientos manuales.
  const timeline: TimelineRow[] = [];
  if (c && data) {
    timeline.push({
      key: "apertura",
      ts: c.fecha_apertura,
      icon: <DoorOpen className="h-3.5 w-3.5" />,
      tipo: "Apertura",
      tipoClass: "bg-[#E5F4F4] text-[#3F8E91]",
      detalle: c.abierta_por_nombre ? `Abrió ${c.abierta_por_nombre}` : "Apertura de caja",
      medio: "efectivo",
      monto: c.monto_apertura,
      signo: 1,
    });
    for (const v of data.ventas) {
      const tv = v.tipo_venta ? ` · ${v.tipo_venta}` : "";
      timeline.push({
        key: `v-${v.id}`,
        ts: v.fecha,
        icon: <ShoppingCart className="h-3.5 w-3.5" />,
        tipo: "Venta",
        tipoClass: "bg-emerald-50 text-emerald-700",
        detalle: `${v.numero_control ?? "Venta"}${tv}`,
        medio: v.metodo_pago,
        monto: v.total,
        signo: 1,
        tachado: v.estado === "anulada",
      });
    }
    for (const m of data.movimientos) {
      const esEntrada = m.tipo === "ingreso" || (m.tipo === "ajuste" && m.monto >= 0);
      const tipoLabel =
        m.tipo === "ingreso"
          ? "Ingreso"
          : m.tipo === "egreso"
          ? "Egreso"
          : m.tipo === "retiro"
          ? "Retiro"
          : "Ajuste";
      const autor = m.usuario_nombre || m.usuario_email;
      timeline.push({
        key: `m-${m.id}`,
        ts: m.created_at,
        icon: esEntrada ? <ArrowDownCircle className="h-3.5 w-3.5" /> : <ArrowUpCircle className="h-3.5 w-3.5" />,
        tipo: tipoLabel,
        tipoClass: esEntrada ? "bg-sky-50 text-sky-700" : "bg-amber-50 text-amber-700",
        detalle: autor ? `${m.concepto} · ${autor}` : m.concepto,
        medio: m.medio_pago,
        monto: Math.abs(m.monto),
        signo: esEntrada ? 1 : -1,
      });
    }
    timeline.sort((a, b) => (a.ts < b.ts ? -1 : a.ts > b.ts ? 1 : 0));
  }

  const dif = c?.diferencia ?? null;
  const difClass =
    dif == null ? "text-slate-400" : dif === 0 ? "text-emerald-600" : dif < 0 ? "text-red-600" : "text-amber-600";

  const descripcion = c
    ? `${formatFechaHora(c.fecha_apertura)}${c.fecha_cierre ? ` → ${formatFechaHora(c.fecha_cierre)}` : " · en curso"}`
    : "Arqueo del turno: ventas y movimientos.";

  return (
    <div className="space-y-8">
      <PageHeader
        eyebrow="Zentra · Reportes"
        title="Detalle del turno"
        description={descripcion}
        backHref="/reportes/cajas"
        backLabel="Cierres de caja"
      />

      {cargando ? (
        <p className="text-slate-500 animate-pulse">Cargando…</p>
      ) : error || !c ? (
        <div className="rounded-xl border border-slate-200 bg-white p-6 text-slate-500 shadow-sm">
          {error ?? "Sin datos."}
        </div>
      ) : (
        <>
          {/* Resumen del arqueo */}
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-6">
            <Resumen label="Vendido" value={formatGs(c.total_vendido)} hint={`${c.cantidad_ventas} venta(s)`} accent />
            <Resumen label="Efectivo" value={formatGs(c.total_efectivo)} />
            <Resumen label="Tarjeta" value={formatGs(c.total_tarjeta)} />
            <Resumen label="Transferencia" value={formatGs(c.total_transferencia)} />
            <Resumen label="Efectivo esperado" value={formatGs(c.efectivo_esperado)} hint="apertura + efectivo ± movs" />
            <Resumen
              label="Contado / Diferencia"
              value={c.monto_cierre_contado == null ? "—" : formatGs(c.monto_cierre_contado)}
              hint={dif == null ? "turno abierto" : `${dif > 0 ? "+" : ""}${formatGs(dif)}`}
              hintClass={difClass}
            />
          </div>

          {/* Línea de tiempo */}
          <div className="rounded-2xl border border-[#4FAEB2]/30 bg-white p-6 shadow-sm ring-1 ring-[#4FAEB2]/10">
            <h2 className="mb-4 flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-slate-700">
              <span className="inline-block h-3.5 w-1 rounded-full bg-[#4FAEB2]" />
              Movimientos del turno
            </h2>
            {timeline.length === 0 ? (
              <p className="py-6 text-center text-sm text-slate-400">Sin movimientos en este turno.</p>
            ) : (
              <div className="overflow-x-auto rounded-xl border border-slate-200">
                <table className="w-full min-w-[560px] text-sm">
                  <thead className="border-b border-slate-200 bg-slate-50">
                    <tr>
                      <th className="px-3 py-2 text-left text-[11px] font-bold uppercase tracking-wide text-slate-500">Hora</th>
                      <th className="px-3 py-2 text-left text-[11px] font-bold uppercase tracking-wide text-slate-500">Movimiento</th>
                      <th className="px-3 py-2 text-left text-[11px] font-bold uppercase tracking-wide text-slate-500">Detalle</th>
                      <th className="px-3 py-2 text-left text-[11px] font-bold uppercase tracking-wide text-slate-500">Método</th>
                      <th className="px-3 py-2 text-right text-[11px] font-bold uppercase tracking-wide text-slate-500">Monto</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {timeline.map((r) => (
                      <tr key={r.key} className="hover:bg-slate-50/70">
                        <td className="whitespace-nowrap px-3 py-2 text-xs tabular-nums text-slate-500">{formatHora(r.ts)}</td>
                        <td className="px-3 py-2">
                          <span className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[11px] font-semibold ${r.tipoClass}`}>
                            {r.icon}
                            {r.tipo}
                          </span>
                        </td>
                        <td className={`px-3 py-2 text-xs ${r.tachado ? "text-slate-400 line-through" : "text-slate-700"}`}>
                          {r.detalle}
                          {r.tachado && <span className="ml-1 text-[10px] font-semibold text-red-500">(anulada)</span>}
                        </td>
                        <td className="px-3 py-2 text-xs text-slate-500">{r.medio ? MEDIO_LABEL[r.medio] : "—"}</td>
                        <td
                          className={`px-3 py-2 text-right text-xs font-semibold tabular-nums ${
                            r.tachado ? "text-slate-400 line-through" : r.signo < 0 ? "text-red-600" : "text-emerald-600"
                          }`}
                        >
                          {r.signo < 0 ? "−" : "+"}
                          {formatGs(r.monto)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}

            {c.observacion_cierre && (
              <p className="mt-4 rounded-lg border border-slate-200 bg-slate-50 px-3 py-2 text-xs text-slate-600">
                <span className="font-semibold text-slate-700">Observación de cierre:</span> {c.observacion_cierre}
              </p>
            )}
          </div>
        </>
      )}
    </div>
  );
}

function Resumen({
  label,
  value,
  hint,
  hintClass,
  accent,
}: {
  label: string;
  value: string;
  hint?: string;
  hintClass?: string;
  accent?: boolean;
}) {
  return (
    <div className={`rounded-xl border p-3 ${accent ? "border-[#4FAEB2]/40 bg-[#4FAEB2]/[0.07]" : "border-slate-200 bg-white"}`}>
      <p className="text-[10.5px] font-semibold uppercase tracking-wide text-slate-400">{label}</p>
      <p className={`mt-0.5 text-sm font-bold tabular-nums ${accent ? "text-[#3F8E91]" : "text-slate-800"}`}>{value}</p>
      {hint && <p className={`mt-0.5 text-[11px] tabular-nums ${hintClass ?? "text-slate-400"}`}>{hint}</p>}
    </div>
  );
}
