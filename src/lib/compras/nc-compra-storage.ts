import type {
  CompraElegible,
  NotaCreditoCompra,
  NuevaNotaCreditoCompraInput,
} from "./types";

export async function getNotasCreditoCompra(): Promise<NotaCreditoCompra[]> {
  try {
    const r = await fetch("/api/compras/notas-credito", { credentials: "include", cache: "no-store" });
    const j = await r.json().catch(() => ({}));
    if (!r.ok || !j?.success) {
      console.error("[nc-compra] getNotas:", (j as { error?: string })?.error ?? r.status);
      return [];
    }
    return ((j.data as { notas?: NotaCreditoCompra[] }).notas ?? []) as NotaCreditoCompra[];
  } catch (e) {
    console.error("[nc-compra] getNotas:", e);
    return [];
  }
}

export async function getComprasElegibles(proveedorId: string): Promise<CompraElegible[]> {
  try {
    const r = await fetch(
      `/api/compras/notas-credito/elegibles?proveedor_id=${encodeURIComponent(proveedorId)}`,
      { credentials: "include", cache: "no-store" }
    );
    const j = await r.json().catch(() => ({}));
    if (!r.ok || !j?.success) {
      console.error("[nc-compra] getElegibles:", (j as { error?: string })?.error ?? r.status);
      return [];
    }
    return ((j.data as { compras?: CompraElegible[] }).compras ?? []) as CompraElegible[];
  } catch (e) {
    console.error("[nc-compra] getElegibles:", e);
    return [];
  }
}

export interface NcResult<T> { success: true; data: T }
export interface NcError { success: false; error: string }

export async function crearNotaCreditoCompra(
  input: NuevaNotaCreditoCompraInput
): Promise<NcResult<NotaCreditoCompra> | NcError> {
  try {
    const r = await fetch("/api/compras/notas-credito", {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(input),
    });
    const j = await r.json().catch(() => ({}));
    if (!r.ok || !j?.success) {
      return { success: false, error: (j as { error?: string })?.error ?? `Error ${r.status}` };
    }
    return { success: true, data: (j.data as { nota: NotaCreditoCompra }).nota };
  } catch (e) {
    return { success: false, error: e instanceof Error ? e.message : "Error de red" };
  }
}

export async function confirmarNotaCreditoCompra(
  id: string
): Promise<NcResult<{ nota: NotaCreditoCompra; ya_confirmada: boolean; movimientos_creados: number }> | NcError> {
  try {
    const r = await fetch(`/api/compras/notas-credito/${encodeURIComponent(id)}/confirmar`, {
      method: "POST",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
    });
    const j = await r.json().catch(() => ({}));
    if (!r.ok || !j?.success) {
      return { success: false, error: (j as { error?: string })?.error ?? `Error ${r.status}` };
    }
    const d = j.data as { nota: NotaCreditoCompra; ya_confirmada: boolean; movimientos_creados: number };
    return { success: true, data: d };
  } catch (e) {
    return { success: false, error: e instanceof Error ? e.message : "Error de red" };
  }
}
