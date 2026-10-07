"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { getProveedores } from "@/lib/proveedores/storage";
import {
  getComprasElegibles,
  crearNotaCreditoCompra,
} from "@/lib/compras/nc-compra-storage";
import type { Proveedor } from "@/lib/proveedores/types";
import type { CompraElegible } from "@/lib/compras/types";

const inputClass =
  "w-full border border-slate-200 rounded-lg px-3 py-2 outline-none focus:ring-2 focus:ring-[#0EA5E9] focus:outline-none bg-white text-sm";
const labelClass = "block text-sm font-medium text-slate-700 mb-2";

function formatGs(valor: number) {
  return `Gs. ${Math.round(valor).toLocaleString("es-PY")}`;
}

interface Seleccion {
  marcado: boolean;
  cantidad: string;
}

export default function NuevaNotaCreditoCompraPage() {
  const router = useRouter();

  const [proveedores, setProveedores] = useState<Proveedor[]>([]);
  const [proveedorId, setProveedorId] = useState("");
  const [elegibles, setElegibles] = useState<CompraElegible[]>([]);
  const [cargandoElegibles, setCargandoElegibles] = useState(false);
  const [sel, setSel] = useState<Record<string, Seleccion>>({});

  const [nroComprobante, setNroComprobante] = useState("");
  const [nroTimbrado, setNroTimbrado] = useState("");
  const [motivo, setMotivo] = useState("");

  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    getProveedores().then((data) => setProveedores(data.filter((p) => p.estado === "activo")));
  }, []);

  async function handleProveedorChange(id: string) {
    setProveedorId(id);
    setSel({});
    setElegibles([]);
    setError(null);
    if (!id) return;
    setCargandoElegibles(true);
    try {
      const data = await getComprasElegibles(id);
      setElegibles(data);
      if (data.length === 0) {
        setError("Este proveedor no tiene compras con cantidad disponible para acreditar.");
      }
    } finally {
      setCargandoElegibles(false);
    }
  }

  function toggle(compraId: string, disponible: number) {
    setSel((prev) => {
      const cur = prev[compraId];
      if (cur?.marcado) {
        const { [compraId]: _omit, ...rest } = prev;
        void _omit;
        return rest;
      }
      return { ...prev, [compraId]: { marcado: true, cantidad: String(disponible) } };
    });
  }

  function setCantidad(compraId: string, value: string) {
    setSel((prev) => ({ ...prev, [compraId]: { marcado: true, cantidad: value } }));
  }

  // Totales preview
  const itemsSeleccionados = elegibles
    .filter((c) => sel[c.compra_id]?.marcado)
    .map((c) => {
      const cant = parseFloat(sel[c.compra_id]?.cantidad ?? "0") || 0;
      return { compra: c, cantidad: cant, total: cant * c.costo_unitario };
    });
  const totalPreview = itemsSeleccionados.reduce((a, b) => a + b.total, 0);

  const haySeleccion = itemsSeleccionados.length > 0 && itemsSeleccionados.every((i) => i.cantidad > 0);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);

    if (!proveedorId) return setError("Seleccioná un proveedor.");
    if (!haySeleccion) return setError("Marcá al menos un producto y poné una cantidad mayor a 0.");

    // Validación de cantidad vs disponible (el server revalida).
    for (const i of itemsSeleccionados) {
      if (i.cantidad > i.compra.cantidad_disponible + 1e-9) {
        return setError(
          `La cantidad de ${i.compra.producto_nombre} (${i.cantidad}) supera lo disponible (${i.compra.cantidad_disponible}).`
        );
      }
    }

    setSubmitting(true);
    try {
      const res = await crearNotaCreditoCompra({
        proveedor_id: proveedorId,
        nro_comprobante: nroComprobante.trim() || undefined,
        nro_timbrado: nroTimbrado.trim() || undefined,
        motivo: motivo.trim() || undefined,
        items: itemsSeleccionados.map((i) => ({
          compra_id: i.compra.compra_id,
          cantidad: i.cantidad,
        })),
      });
      if (!res.success) { setError(res.error); return; }
      router.push("/compras/notas-credito");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold text-gray-800">Nueva nota de crédito de compra</h1>
        <p className="text-gray-600">
          Registrá una NC recibida del proveedor. Se guarda en borrador; al confirmarla se descuenta el stock.
        </p>
      </div>

      <div className="bg-white border border-slate-200 rounded-xl shadow-sm p-6 max-w-3xl">
        <form className="space-y-8" onSubmit={handleSubmit}>

          {/* Proveedor */}
          <section className="space-y-3">
            <SectionTitle>Proveedor</SectionTitle>
            <div>
              <label className={labelClass}>Proveedor <span className="text-red-500">*</span></label>
              <select
                value={proveedorId}
                onChange={(e) => handleProveedorChange(e.target.value)}
                className={inputClass}
                required
              >
                <option value="">Seleccionar proveedor…</option>
                {proveedores.map((p) => (
                  <option key={p.id} value={p.id}>{p.nombre} — RUC {p.ruc}</option>
                ))}
              </select>
            </div>
          </section>

          {/* Datos de la NC */}
          <section className="space-y-4">
            <SectionTitle>Datos de la nota de crédito</SectionTitle>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div>
                <label className={labelClass}>N° de comprobante (del proveedor)</label>
                <input
                  type="text"
                  value={nroComprobante}
                  onChange={(e) => setNroComprobante(e.target.value)}
                  placeholder="Ej: 001-001-0000123"
                  className={inputClass}
                />
              </div>
              <div>
                <label className={labelClass}>N° de timbrado</label>
                <input
                  type="text"
                  value={nroTimbrado}
                  onChange={(e) => setNroTimbrado(e.target.value)}
                  placeholder="Ej: 12345678"
                  className={`${inputClass} uppercase`}
                />
              </div>
            </div>
            <div>
              <label className={labelClass}>Motivo</label>
              <input
                type="text"
                value={motivo}
                onChange={(e) => setMotivo(e.target.value)}
                placeholder="Ej: Devolución de mercadería facturada por error"
                className={inputClass}
              />
            </div>
          </section>

          {/* Productos a acreditar */}
          <section className="space-y-3">
            <SectionTitle>Productos a acreditar</SectionTitle>

            {!proveedorId ? (
              <p className="text-sm text-gray-400">Seleccioná un proveedor para ver sus compras.</p>
            ) : cargandoElegibles ? (
              <p className="text-sm text-gray-400">Cargando compras…</p>
            ) : elegibles.length === 0 ? (
              <p className="text-sm text-gray-400">Sin compras disponibles para acreditar.</p>
            ) : (
              <div className="border border-slate-200 rounded-xl overflow-hidden">
                <table className="w-full text-left text-sm">
                  <thead className="bg-slate-50">
                    <tr className="text-gray-500">
                      <th className="py-2.5 px-3 font-medium w-8"></th>
                      <th className="py-2.5 px-3 font-medium">Compra</th>
                      <th className="py-2.5 px-3 font-medium">Producto</th>
                      <th className="py-2.5 px-3 font-medium text-right">Costo unit.</th>
                      <th className="py-2.5 px-3 font-medium text-right">Disp.</th>
                      <th className="py-2.5 px-3 font-medium text-right">Cantidad a acreditar</th>
                    </tr>
                  </thead>
                  <tbody>
                    {elegibles.map((c) => {
                      const s = sel[c.compra_id];
                      return (
                        <tr key={c.compra_id} className="border-t border-slate-100">
                          <td className="py-2.5 px-3">
                            <input
                              type="checkbox"
                              checked={!!s?.marcado}
                              onChange={() => toggle(c.compra_id, c.cantidad_disponible)}
                              className="h-4 w-4 accent-[#4FAEB2]"
                            />
                          </td>
                          <td className="py-2.5 px-3 font-mono text-xs text-gray-500">{c.numero_control}</td>
                          <td className="py-2.5 px-3 text-gray-700">{c.producto_nombre}</td>
                          <td className="py-2.5 px-3 text-right tabular-nums text-gray-600">{formatGs(c.costo_unitario)}</td>
                          <td className="py-2.5 px-3 text-right tabular-nums text-gray-600">{c.cantidad_disponible}</td>
                          <td className="py-2.5 px-3 text-right">
                            <input
                              type="number"
                              min={0}
                              max={c.cantidad_disponible}
                              step="any"
                              disabled={!s?.marcado}
                              value={s?.cantidad ?? ""}
                              onChange={(e) => setCantidad(c.compra_id, e.target.value)}
                              className="w-24 border border-slate-200 rounded-lg px-2 py-1 text-right text-sm outline-none focus:ring-2 focus:ring-[#0EA5E9] disabled:bg-slate-50 disabled:text-slate-400"
                            />
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </section>

          {/* Total */}
          {itemsSeleccionados.length > 0 && (
            <div className="rounded-lg bg-slate-50 border border-slate-200 px-4 py-3 flex justify-between items-center">
              <span className="text-sm text-gray-600">
                Total NC ({itemsSeleccionados.length} ítem{itemsSeleccionados.length > 1 ? "s" : ""})
              </span>
              <span className="text-lg font-bold tabular-nums text-gray-800">{formatGs(totalPreview)}</span>
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-3">
              <p className="text-sm text-red-700">{error}</p>
            </div>
          )}

          <div className="flex gap-4 pt-2">
            <button
              type="submit"
              disabled={!haySeleccion || submitting}
              className="bg-[#0EA5E9] hover:bg-[#0284C7] text-white px-5 py-3 rounded-lg text-sm font-medium transition-colors shadow-sm disabled:opacity-40 disabled:cursor-not-allowed active:scale-95"
            >
              {submitting ? "Guardando…" : "Guardar borrador"}
            </button>
            <button
              type="button"
              onClick={() => router.push("/compras/notas-credito")}
              className="border border-slate-200 px-5 py-3 rounded-lg text-sm hover:bg-slate-50 transition-colors"
            >
              Cancelar
            </button>
          </div>

          <p className="text-xs text-gray-400">
            El stock se descuenta recién al confirmar la nota desde el listado.
          </p>
        </form>
      </div>
    </div>
  );
}

function SectionTitle({ children }: { children: React.ReactNode }) {
  return (
    <h3 className="text-xs font-semibold text-gray-400 uppercase tracking-widest">{children}</h3>
  );
}
