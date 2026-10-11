"use client";

import { useEffect, useState } from "react";
import { FileText, Info } from "lucide-react";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import ExportExcelButton from "@/components/ui/ExportExcelButton";
import MesSelector from "@/components/reportes/MesSelector";
import { getRg90Reporte } from "@/lib/reportes/storage";
import { mesActualAsuncion } from "@/lib/fechas/asuncion-bounds";
import type { Rg90Reporte } from "@/lib/reportes/rg90/types";

function formatGs(v: number) {
  return `Gs. ${Math.round(v).toLocaleString("es-PY")}`;
}
function formatFecha(ymd: string) {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(ymd);
  return m ? `${m[3]}/${m[2]}/${m[1]}` : ymd;
}

const ID_LABEL: Record<number, string> = { 11: "RUC", 12: "CI", 15: "S/N" };

export default function Rg90ReportePage() {
  const [mes, setMes] = useState(mesActualAsuncion());
  const [data, setData] = useState<Rg90Reporte | null>(null);
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    let cancel = false;
    setCargando(true);
    getRg90Reporte(mes).then((d) => { if (!cancel) { setData(d); setCargando(false); } });
    return () => { cancel = true; };
  }, [mes]);

  const soloImpresos = data ? data.totalesImpresos.comprobantes : 0;

  return (
    <div className="space-y-8">
      <PageHeader
        eyebrow="Zentra · Reportes"
        title="RG90 · Libro de Ventas"
        description="Registro de comprobantes de ventas para la SET (Resolución General 90/2021)"
        backHref="/reportes"
        backLabel="Reportes"
        actions={
          <div className="flex flex-wrap items-center gap-3">
            <MesSelector mes={mes} onChange={setMes} />
            <ExportExcelButton url={`/api/reportes/rg90/export?mes=${mes}`} label="Excel (Libro)" />
            <ExportExcelButton url={`/api/reportes/rg90/txt?mes=${mes}&formato=csv`} label="CSV SET" />
            <ExportExcelButton url={`/api/reportes/rg90/txt?mes=${mes}&formato=txt`} label="TXT SET" />
          </div>
        }
      />

      {cargando ? (
        <p className="text-slate-500 animate-pulse">Cargando…</p>
      ) : !data ? (
        <div className="bg-white border border-slate-200 rounded-xl shadow-sm p-6 text-slate-500">
          No se pudo generar el Libro de Ventas RG90.
        </div>
      ) : (
        <>
          <div className="grid grid-cols-2 gap-3 lg:grid-cols-5">
            <StatCard compact label="Total del período" value={formatGs(data.totales.total)} accent />
            <StatCard compact label="Comprobantes" value={String(data.totales.comprobantes)} hint={`${data.totales.facturas} fact. / ${data.totales.notasCredito} NC`} />
            <StatCard compact label="Gravado 10%" value={formatGs(data.totales.gravado10)} hint="IVA incluido" />
            <StatCard compact label="Gravado 5%" value={formatGs(data.totales.gravado5)} hint="IVA incluido" />
            <StatCard compact label="Exentas" value={formatGs(data.totales.exento)} />
          </div>

          {/* Aviso: el TXT de Marangatu excluye electrónicos */}
          <div className="flex gap-3 rounded-xl border border-sky-200 bg-sky-50 p-4 text-sm text-sky-900">
            <Info className="mt-0.5 h-5 w-5 flex-shrink-0 text-sky-500" />
            <div className="space-y-1">
              <p>
                El <strong>Excel</strong> incluye <strong>todos</strong> los comprobantes del mes (electrónicos e impresos) para
                revisión contable y cuadre con el Libro de Ventas.
              </p>
              <p>
                El archivo <strong>CSV/TXT para el Marangatu</strong> incluye solo los{" "}
                <strong>{soloImpresos} comprobante(s) impreso(s)</strong> en guaraníes: la SET ya posee los electrónicos
                (e-Kuatia) y no deben reimportarse.
                {data.modoFacturacion === "sifen" && soloImpresos === 0 && (
                  <> Esta empresa factura en modo electrónico (SIFEN), por eso el archivo de importación sale vacío — es lo correcto.</>
                )}
                {data.excluidosMonedaExtranjera > 0 && (
                  <> Se excluyeron {data.excluidosMonedaExtranjera} comprobante(s) en moneda extranjera del archivo.</>
                )}
              </p>
            </div>
          </div>

          {/* Detalle de comprobantes */}
          <div className="bg-white border border-slate-200 rounded-xl shadow-sm p-6">
            <div className="mb-4 flex items-center gap-2">
              <FileText className="h-5 w-5 text-slate-400" />
              <h2 className="text-base font-semibold text-slate-800">Comprobantes del período</h2>
            </div>
            {data.rows.length === 0 ? (
              <p className="text-sm text-slate-400">No hay comprobantes en el período.</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full min-w-[920px] text-left text-sm">
                  <thead>
                    <tr className="border-b text-slate-500">
                      <th className="py-2.5 pr-4 font-medium">Fecha</th>
                      <th className="py-2.5 pr-4 font-medium">Tipo</th>
                      <th className="py-2.5 pr-4 font-medium">N° comprobante</th>
                      <th className="py-2.5 pr-4 font-medium">Timbrado</th>
                      <th className="py-2.5 pr-4 font-medium">Comprador</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Gravado 10%</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Gravado 5%</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Exentas</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Total</th>
                      <th className="py-2.5 font-medium text-center">Tipo DE</th>
                    </tr>
                  </thead>
                  <tbody>
                    {data.rows.map((r) => (
                      <tr key={`${r.tipo}-${r.id}`} className="border-b border-slate-100 last:border-0">
                        <td className="py-3 pr-4 text-slate-600 text-xs tabular-nums">{formatFecha(r.fecha)}</td>
                        <td className="py-3 pr-4">
                          <span className={`inline-block rounded-full px-2 py-0.5 text-[11px] font-semibold ${r.tipo === "nota_credito" ? "bg-amber-100 text-amber-700" : "bg-slate-100 text-slate-600"}`}>
                            {r.tipo === "nota_credito" ? "Nota créd." : "Factura"}
                          </span>
                        </td>
                        <td className="py-3 pr-4 font-mono text-xs text-slate-500">{r.numeroComprobante || "—"}</td>
                        <td className="py-3 pr-4 font-mono text-xs text-slate-500">{r.timbrado || "—"}</td>
                        <td className="py-3 pr-4 text-slate-700">
                          <span className="text-slate-400 mr-1 text-xs">{ID_LABEL[r.codigoTipoIdentificacion] ?? ""}</span>
                          {r.nombre || r.numeroIdentificacion || "—"}
                        </td>
                        <td className="py-3 pr-4 text-right tabular-nums text-slate-600">{r.gravado10 ? formatGs(r.gravado10) : "—"}</td>
                        <td className="py-3 pr-4 text-right tabular-nums text-slate-600">{r.gravado5 ? formatGs(r.gravado5) : "—"}</td>
                        <td className="py-3 pr-4 text-right tabular-nums text-slate-600">{r.exento ? formatGs(r.exento) : "—"}</td>
                        <td className="py-3 pr-4 text-right tabular-nums font-semibold text-slate-800">{formatGs(r.total)}</td>
                        <td className="py-3 text-center">
                          <span className={`inline-block rounded-full px-2 py-0.5 text-[11px] font-semibold ${r.electronico ? "bg-emerald-100 text-emerald-700" : "bg-slate-100 text-slate-500"}`}>
                            {r.electronico ? "Electrónico" : "Impreso"}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                  <tfoot>
                    <tr className="border-t-2 border-slate-200 font-semibold text-slate-800">
                      <td className="py-3 pr-4" colSpan={5}>Totales</td>
                      <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.totales.gravado10)}</td>
                      <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.totales.gravado5)}</td>
                      <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.totales.exento)}</td>
                      <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.totales.total)}</td>
                      <td />
                    </tr>
                  </tfoot>
                </table>
              </div>
            )}
          </div>
        </>
      )}
    </div>
  );
}
