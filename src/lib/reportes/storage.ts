import type { EstadoCuentaReporte, ProveedoresReporte, ComprasReporte, VentasReporte, ConciliacionReporte } from "./types";
import type { CajasReporte, CajaDetalle } from "@/lib/caja/types";
import type { RangoABC } from "@/lib/reportes/abc";

export interface ProductoRotacion {
  producto_id: string;
  nombre: string;
  sku: string | null;
  stock_actual: number;
  stock_minimo: number;
  cantidad_vendida: number;
  importe_vendido: number;
  rango: RangoABC;
}
export interface RotacionAbc {
  desde: string;
  hasta: string;
  meses: number;
  totales: { total: number; a: number; b: number; c: number; sin_ventas: number };
  productos: ProductoRotacion[];
}

async function getReporte<T>(url: string): Promise<T | null> {
  try {
    const r = await fetch(url, { credentials: "include", cache: "no-store" });
    const j = await r.json().catch(() => ({}));
    if (!r.ok || !j?.success) return null;
    return j.data as T;
  } catch (e) {
    console.error("[reportes] getReporte:", e);
    return null;
  }
}

const mq = (mes: string) => encodeURIComponent(mes);

export const getEstadoCuentaReporte = (mes: string) =>
  getReporte<EstadoCuentaReporte>(`/api/reportes/estado-cuenta?mes=${mq(mes)}`);
export const getProveedoresReporte = (mes: string) =>
  getReporte<ProveedoresReporte>(`/api/reportes/proveedores?mes=${mq(mes)}`);
export const getComprasReporte = (mes: string) =>
  getReporte<ComprasReporte>(`/api/reportes/compras?mes=${mq(mes)}`);
export const getVentasReporte = (mes: string) =>
  getReporte<VentasReporte>(`/api/reportes/ventas?mes=${mq(mes)}`);
export const getConciliacionReporte = (mes: string) =>
  getReporte<ConciliacionReporte>(`/api/reportes/conciliacion?mes=${mq(mes)}`);
export const getCajasReporte = (desde: string, hasta: string) =>
  getReporte<CajasReporte>(`/api/reportes/cajas?desde=${mq(desde)}&hasta=${mq(hasta)}`);
export const getCajaDetalle = (id: string) =>
  getReporte<CajaDetalle>(`/api/reportes/cajas/${encodeURIComponent(id)}`);
export const getRotacionAbcReporte = (meses: number) =>
  getReporte<RotacionAbc>(`/api/reportes/rotacion-abc?meses=${meses}`);
