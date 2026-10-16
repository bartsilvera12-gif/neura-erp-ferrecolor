"use client";

import { useEffect, useState } from "react";
import { FileText, Info } from "lucide-react";
import PageHeader from "@/components/ui/PageHeader";
import StatCard from "@/components/ui/StatCard";
import ExportExcelButton from "@/components/ui/ExportExcelButton";
import MesSelector from "@/components/reportes/MesSelector";
import { getRg90ComprasReporte } from "@/lib/reportes/storage";
import { mesActualAsuncion } from "@/lib/fechas/asuncion-bounds";
import type { Rg90ComprasReporte, Rg90CompraRow } from "@/lib/reportes/rg90-compras/types";

function formatGs(v: number) {
  return `Gs. ${Math.round(v).toLocaleString("es-PY")}`;
}
function formatFecha(ymd: string) {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(ymd);
  return m ? `${m[3]}/${m[2]}/${m[1]}` : ymd;
}
const ID_LABEL: Record<number, string> = { 11: "RUC", 12: "CI", 15: "S/N" };

export default function Rg90ComprasPage() {
  const [mes, setMes] = useState(mesActualAsuncion());
  const [data, setData] = useState<Rg90ComprasReporte | null>(null);
  const [cargando, setCargando] = useState(true);
  const [vista, setVista] = useState<"incluidas" | "no-rg90">("incluidas");

  useEffect(() => {
    let cancel = false;
    setCargando(true);
    getRg90ComprasReporte(mes).then((d) => { if (!cancel) { setData(d); setCargando(false); } });
    return () => { cancel = true; };
  }, [mes]);

  const filas: Rg90CompraRow[] = data ? (vista === "incluidas" ? data.rows : data.rowsNoRg90) : [];

  return (
    <div className="space-y-8">
      <PageHeader
        eyebrow="Zentra · Reportes"
        title="RG90 · Libro de Compras"
        description="Registro de comprobantes de compras para la SET (Resolución General 90/2021)"
        backHref="/reportes"
        backLabel="Reportes"
        actions={
          <div className="flex flex-wrap items-center gap-3">
            <MesSelector mes={mes} onChange={setMes} />
            <ExportExcelButton url={`/api/reportes/rg90-compras/export?mes=${mes}`} label="Excel (Libro)" />
            <ExportExcelButton url={`/api/reportes/rg90-compras/txt?mes=${mes}&formato=csv`} label="CSV SET" />
            <ExportExcelButton url={`/api/reportes/rg90-compras/txt?mes=${mes}&formato=txt`} label="TXT SET" />
          </div>
        }
      />

      {cargando ? (
        <p className="text-slate-500 animate-pulse">Cargando…</p>
      ) : !data ? (
        <div className="bg-white border border-slate-200 rounded-xl shadow-sm p-6 text-slate-500">
          No se pudo generar el Libro de Compras RG90.
        </div>
      ) : (
        <>
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-3">
            <StatCard compact label="Total facturas" value={formatGs(data.totalesFacturas.total)} hint={`${data.totalesFacturas.comprobantes} comprobante(s)`} />
            <StatCard compact label="Notas de crédito (−)" value={formatGs(data.totalesNotasCredito.total)} hint={`${data.totalesNotasCredito.comprobantes} comprobante(s)`} />
            <StatCard compact label="Total neto (Fact. − NC)" value={formatGs(data.neto.total)} accent />
          </div>
          <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">
            <StatCard compact label="Comprobantes incluidos" value={String(data.totales.comprobantes)} hint={`${data.totalesFacturas.comprobantes} fact. / ${data.totalesNotasCredito.comprobantes} NC`} />
            <StatCard compact label="Gravado 10% neto" value={formatGs(data.neto.gravado10)} hint="IVA incluido" />
            <StatCard compact label="Gravado 5% neto" value={formatGs(data.neto.gravado5)} hint="IVA incluido" />
            <StatCard compact label="No RG90" value={String(data.totalesNoRg90.comprobantes)} hint={formatGs(data.totalesNoRg90.total)} />
          </div>

          <div className="flex gap-3 rounded-xl border border-sky-200 bg-sky-50 p-4 text-sm text-sky-900">
            <Info className="mt-0.5 h-5 w-5 flex-shrink-0 text-sky-500" />
            <div className="space-y-1">
              <p>
                El <strong>Excel</strong> trae el Libro de Compras incluido y, en una hoja aparte, las <strong>compras No RG90</strong>.
                El archivo <strong>CSV/TXT para el Marangatu</strong> incluye solo los comprobantes marcados <strong>Incluir en RG90</strong>, en guaraníes.
              </p>
              {!data.flagDisponible && (
                <p className="font-medium text-amber-700">
                  ⚠ El campo &quot;Incluir en RG90&quot; todavía no está en la base (migración pendiente): por ahora se consideran <strong>todas</strong> las compras como incluidas.
                </p>
              )}
              {data.excluidosMonedaExtranjera > 0 && (
                <p>Se excluyeron {data.excluidosMonedaExtranjera} comprobante(s) en moneda extranjera del archivo SET.</p>
              )}
            </div>
          </div>

          {/* Toggle de vista */}
          <div className="inline-flex rounded-lg border border-slate-200 bg-white p-1 text-sm">
            <button
              onClick={() => setVista("incluidas")}
              className={`rounded-md px-3 py-1.5 font-medium transition ${vista === "incluidas" ? "bg-[#4FAEB2] text-white" : "text-slate-600 hover:bg-slate-50"}`}
            >
              Incluidas en RG90 ({data.rows.length})
            </button>
            <button
              onClick={() => setVista("no-rg90")}
              className={`rounded-md px-3 py-1.5 font-medium transition ${vista === "no-rg90" ? "bg-amber-500 text-white" : "text-slate-600 hover:bg-slate-50"}`}
            >
              No RG90 ({data.rowsNoRg90.length})
            </button>
          </div>

          <div className="bg-white border border-slate-200 rounded-xl shadow-sm p-6">
            <div className="mb-4 flex items-center gap-2">
              <FileText className="h-5 w-5 text-slate-400" />
              <h2 className="text-base font-semibold text-slate-800">
                {vista === "incluidas" ? "Comprobantes incluidos en el RG90" : "Compras marcadas No RG90"}
              </h2>
            </div>
            {filas.length === 0 ? (
              <p className="text-sm text-slate-400">No hay comprobantes en esta vista para el período.</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full min-w-[920px] text-left text-sm">
                  <thead>
                    <tr className="border-b text-slate-500">
                      <th className="py-2.5 pr-4 font-medium">Fecha</th>
                      <th className="py-2.5 pr-4 font-medium">Tipo</th>
                      <th className="py-2.5 pr-4 font-medium">N° comprobante</th>
                      <th className="py-2.5 pr-4 font-medium">Timbrado</th>
                      <th className="py-2.5 pr-4 font-medium">Proveedor</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Gravado 10%</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Gravado 5%</th>
                      <th className="py-2.5 pr-4 font-medium text-right">Exentas</th>
                      <th className="py-2.5 font-medium text-right">Total</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filas.map((r) => (
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
                        <td className="py-3 text-right tabular-nums font-semibold text-slate-800">{formatGs(r.total)}</td>
                      </tr>
                    ))}
                  </tbody>
                  {vista === "incluidas" && (
                    <tfoot>
                      <tr className="border-t-2 border-slate-200 text-slate-600">
                        <td className="py-2 pr-4" colSpan={5}>Subtotal facturas ({data.totalesFacturas.comprobantes})</td>
                        <td className="py-2 pr-4 text-right tabular-nums">{formatGs(data.totalesFacturas.gravado10)}</td>
                        <td className="py-2 pr-4 text-right tabular-nums">{formatGs(data.totalesFacturas.gravado5)}</td>
                        <td className="py-2 pr-4 text-right tabular-nums">{formatGs(data.totalesFacturas.exento)}</td>
                        <td className="py-2 text-right tabular-nums">{formatGs(data.totalesFacturas.total)}</td>
                      </tr>
                      {data.totalesNotasCredito.comprobantes > 0 && (
                        <tr className="text-amber-700">
                          <td className="py-2 pr-4" colSpan={5}>Notas de crédito ({data.totalesNotasCredito.comprobantes}) (−)</td>
                          <td className="py-2 pr-4 text-right tabular-nums">{data.totalesNotasCredito.gravado10 ? `− ${formatGs(data.totalesNotasCredito.gravado10)}` : "—"}</td>
                          <td className="py-2 pr-4 text-right tabular-nums">{data.totalesNotasCredito.gravado5 ? `− ${formatGs(data.totalesNotasCredito.gravado5)}` : "—"}</td>
                          <td className="py-2 pr-4 text-right tabular-nums">{data.totalesNotasCredito.exento ? `− ${formatGs(data.totalesNotasCredito.exento)}` : "—"}</td>
                          <td className="py-2 text-right tabular-nums">{`− ${formatGs(data.totalesNotasCredito.total)}`}</td>
                        </tr>
                      )}
                      <tr className="border-t border-slate-200 font-semibold text-slate-800">
                        <td className="py-3 pr-4" colSpan={5}>Total neto (Facturas − NC)</td>
                        <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.neto.gravado10)}</td>
                        <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.neto.gravado5)}</td>
                        <td className="py-3 pr-4 text-right tabular-nums">{formatGs(data.neto.exento)}</td>
                        <td className="py-3 text-right tabular-nums">{formatGs(data.neto.total)}</td>
                      </tr>
                    </tfoot>
                  )}
                </table>
              </div>
            )}
          </div>
        </>
      )}
    </div>
  );
}
