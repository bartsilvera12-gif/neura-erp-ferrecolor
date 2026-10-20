"use client";

/**
 * Modal para emitir la factura de una venta cerrada como TICKET, eligiendo el
 * cliente (receptor) que irá en la factura.
 *
 * Caso de uso: el ticket se cerró sin datos fiscales y el comprador vuelve
 * después con su RUC/CI. Acá se elige un cliente existente o se crea uno nuevo,
 * y la factura se emite con ESE cliente.
 *
 * IMPORTANTE: NO modifica la venta, el cobro ni el stock. El cliente elegido se
 * guarda SOLO en la factura (el endpoint usa `cliente_id` como receptor y deja
 * `ventas.cliente_id` intacto; solo linkea `ventas.factura_id`).
 */
import { useEffect, useMemo, useState } from "react";
import { Loader2, UserPlus, X } from "lucide-react";
import ClienteBuscador, { type ClienteBuscadorItem } from "@/components/clientes/ClienteBuscador";
import CrearClienteModal, { type ClienteCreado } from "@/components/clientes/CrearClienteModal";
import { fetchWithSupabaseSession } from "@/lib/api/fetch-with-supabase-session";

type Props = {
  venta: { id: string; numero_control: string; cliente_id: string | null; cliente_nombre: string | null };
  onClose: () => void;
  onEmitida: (facturaId: string) => void;
};

export default function EmitirFacturaModal({ venta, onClose, onEmitida }: Props) {
  const [clientes, setClientes] = useState<ClienteBuscadorItem[]>([]);
  const [clienteId, setClienteId] = useState<string>(venta.cliente_id ?? "");
  const [cargando, setCargando] = useState(true);
  const [crearOpen, setCrearOpen] = useState(false);
  const [emitiendo, setEmitiendo] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancel = false;
    fetch("/api/clientes", { credentials: "include", cache: "no-store" })
      .then((r) => r.json())
      .then((j) => {
        if (cancel || !j?.success || !Array.isArray(j.data)) return;
        const s = (v: unknown) => (typeof v === "string" ? v.trim() : "");
        const lite: ClienteBuscadorItem[] = (j.data as Record<string, unknown>[]).map((r) => ({
          id: String(r.id),
          nombre: s(r.empresa) || s(r.nombre_contacto) || s(r.nombre) || "Cliente",
          ruc: s(r.ruc) || null,
          telefono: s(r.telefono) || null,
          direccion: s(r.direccion) || null,
        }));
        setClientes(lite);
      })
      .catch(() => { /* el listado es best-effort; igual se puede crear uno nuevo */ })
      .finally(() => { if (!cancel) setCargando(false); });
    return () => { cancel = true; };
  }, []);

  const seleccionado = useMemo(() => clientes.find((c) => c.id === clienteId) ?? null, [clientes, clienteId]);

  async function emitir() {
    if (!clienteId) { setError("Elegí o creá un cliente para la factura."); return; }
    setEmitiendo(true);
    setError(null);
    try {
      const res = await fetchWithSupabaseSession(`/api/ventas/${venta.id}/emitir-factura`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ cliente_id: clienteId }),
      });
      const data = (await res.json().catch(() => ({}))) as { facturaId?: string; error?: string; sinRuc?: boolean };
      if (!res.ok || !data.facturaId) { setError(data.error || "No se pudo generar la factura."); return; }
      if (data.sinRuc) {
        alert("Atención: el cliente no tiene RUC/CI cargado. Cargá los datos fiscales del cliente antes de enviar la factura a la SET.");
      }
      onEmitida(data.facturaId);
    } catch {
      setError("Error al generar la factura. Reintentá.");
    } finally {
      setEmitiendo(false);
    }
  }

  return (
    <>
      <div
        className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/50 p-4 backdrop-blur-sm"
        onClick={emitiendo ? undefined : onClose}
      >
        <div
          className="w-full max-w-md overflow-visible rounded-2xl border-2 border-emerald-200/50 bg-white shadow-2xl"
          onClick={(e) => e.stopPropagation()}
        >
          <div className="flex items-start justify-between gap-3 border-b border-slate-100 bg-gradient-to-r from-emerald-50 to-transparent px-5 py-4">
            <div>
              <h3 className="text-base font-bold text-slate-800">Emitir factura</h3>
              <p className="mt-0.5 text-xs text-slate-500">
                Venta {venta.numero_control}. Elegí el cliente que irá en la factura.
                No se modifica la venta, el cobro ni el stock.
              </p>
            </div>
            <button
              onClick={onClose}
              disabled={emitiendo}
              className="flex h-8 w-8 items-center justify-center rounded-lg text-slate-400 hover:bg-slate-100 hover:text-slate-700 disabled:opacity-50"
              aria-label="Cerrar"
            >
              <X className="h-4 w-4" />
            </button>
          </div>

          <div className="space-y-3 p-5">
            <ClienteBuscador
              clientes={clientes}
              value={clienteId}
              onSelect={(c) => { setClienteId(c.id); setError(null); }}
              onClear={() => setClienteId("")}
              label="Cliente de la factura"
              placeholder={cargando ? "Cargando clientes…" : "Buscar por nombre, RUC o teléfono…"}
            />

            <button
              type="button"
              onClick={() => setCrearOpen(true)}
              className="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:border-[#4FAEB2]/40 hover:bg-[#4FAEB2]/5"
            >
              <UserPlus className="h-3.5 w-3.5" /> Crear cliente nuevo
            </button>

            {seleccionado && !seleccionado.ruc && (
              <p className="rounded-lg border border-amber-200 bg-amber-50 px-3 py-2 text-[11px] text-amber-800">
                Este cliente no tiene RUC/CI cargado. Podés emitir igual, pero cargá los datos fiscales antes de enviar la factura a la SET.
              </p>
            )}

            {error && (
              <p className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-xs text-red-700">{error}</p>
            )}
          </div>

          <div className="flex justify-end gap-2 border-t border-slate-100 bg-slate-50/50 px-5 py-3">
            <button
              onClick={onClose}
              disabled={emitiendo}
              className="rounded-lg px-4 py-2 text-sm font-semibold text-slate-600 hover:text-slate-900 disabled:opacity-50"
            >
              Cancelar
            </button>
            <button
              onClick={emitir}
              disabled={emitiendo || !clienteId}
              className="inline-flex items-center gap-2 rounded-lg bg-emerald-600 px-5 py-2 text-sm font-bold text-white transition-colors hover:bg-emerald-700 disabled:opacity-50"
            >
              {emitiendo && <Loader2 className="h-3.5 w-3.5 animate-spin" />}
              Emitir factura
            </button>
          </div>
        </div>
      </div>

      {crearOpen && (
        <CrearClienteModal
          onClose={() => setCrearOpen(false)}
          onCreated={(c: ClienteCreado) => {
            const nuevo: ClienteBuscadorItem = {
              id: c.id,
              nombre: c.label,
              ruc: c.ruc,
              telefono: null,
              direccion: null,
            };
            setClientes((prev) => [nuevo, ...prev.filter((x) => x.id !== c.id)]);
            setClienteId(c.id);
            setCrearOpen(false);
            setError(null);
          }}
        />
      )}
    </>
  );
}
