/**
 * Carga las ventas de un periodo con su ganancia real.
 *
 * Ganancia = total de la venta - costo real de los items, tomando el costo
 * SNAPSHOT que quedo guardado en movimientos_inventario al momento de la SALIDA
 * (no el costo actual del producto, que pudo cambiar despues).
 *
 * Vive aca y no dentro del endpoint de comisiones porque lo consumen dos
 * pantallas —el reporte de comisiones y el cierre de caja del vendedor— y tienen
 * que dar exactamente el mismo numero.
 */

/** Cliente minimo; evita atar este modulo al tipo concreto del tenant. */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
type SupabaseLike = { from: (t: string) => any };

export type VentaConGanancia = {
  id: string;
  vendedor: string;
  caja_id: string | null;
  fecha: string;
  ingresos: number;
  costo: number;
  ganancia: number;
};

export const SIN_VENDEDOR = "Sin vendedor";

/**
 * Ventas ACTIVAS del periodo con su costo real. Excluye anuladas y devueltas
 * totales: no generan ingreso ni comision.
 */
export async function cargarVentasConGanancia(
  sb: SupabaseLike,
  empresaId: string,
  desde: string,
  hastaTs: string
): Promise<VentaConGanancia[]> {
  const { data: ventasRaw, error: eV } = await sb
    .from("ventas")
    .select("id, total, fecha, estado, usuario_nombre, caja_id")
    .eq("empresa_id", empresaId)
    .gte("fecha", desde)
    .lte("fecha", hastaTs);
  if (eV) throw new Error(eV.message);

  type VentaRow = {
    id: string;
    total: number | string | null;
    fecha: string;
    estado: string | null;
    usuario_nombre: string | null;
    caja_id: string | null;
  };
  const ventas = ((ventasRaw ?? []) as VentaRow[]).filter(
    (v) => v.estado !== "anulada" && v.estado !== "devuelta_total"
  );
  if (ventas.length === 0) return [];

  // Movimientos SALIDA (costo snapshot). Se consulta por lotes chicos de
  // venta_id: con cientos de ventas, un unico .in() arma una URL enorme y la
  // request falla. Ademas se pagina, porque PostgREST corta en 1000 filas y los
  // costos salian cortos.
  type MovRow = {
    venta_id: string | null;
    cantidad: number | string | null;
    costo_unitario: number | string | null;
    anulado_at: string | null;
  };
  const ventaIds = ventas.map((v) => String(v.id));
  const CHUNK = 25;
  const PAGE = 1000;
  const movs: MovRow[] = [];
  for (let i = 0; i < ventaIds.length; i += CHUNK) {
    const ids = ventaIds.slice(i, i + CHUNK);
    for (let desdeFila = 0; ; desdeFila += PAGE) {
      const { data, error: eM } = await sb
        .from("movimientos_inventario")
        .select("venta_id, cantidad, costo_unitario, tipo, anulado_at")
        .eq("empresa_id", empresaId)
        .eq("tipo", "SALIDA")
        .in("venta_id", ids)
        .range(desdeFila, desdeFila + PAGE - 1);
      if (eM) throw new Error(eM.message);
      const lote = (data ?? []) as MovRow[];
      movs.push(...lote);
      if (lote.length < PAGE) break;
    }
  }

  const costoPorVenta = new Map<string, number>();
  for (const m of movs) {
    if (m.anulado_at) continue;
    const vid = String(m.venta_id ?? "");
    if (!vid) continue;
    const c = (Number(m.cantidad) || 0) * (Number(m.costo_unitario) || 0);
    costoPorVenta.set(vid, (costoPorVenta.get(vid) ?? 0) + c);
  }

  return ventas.map((v) => {
    const ingresos = Number(v.total) || 0;
    const costo = costoPorVenta.get(String(v.id)) ?? 0;
    return {
      id: String(v.id),
      vendedor: v.usuario_nombre?.trim() || SIN_VENDEDOR,
      caja_id: v.caja_id ?? null,
      fecha: v.fecha,
      ingresos,
      costo,
      ganancia: ingresos - costo,
    };
  });
}

export type TotalesVendedor = {
  vendedor: string;
  ventas: number;
  ingresos: number;
  costo: number;
  ganancia: number;
};

/** Agrupa por vendedor (nombre tal como quedo en la venta). */
export function agruparPorVendedor(ventas: VentaConGanancia[]): TotalesVendedor[] {
  const map = new Map<string, TotalesVendedor>();
  for (const v of ventas) {
    let a = map.get(v.vendedor);
    if (!a) {
      a = { vendedor: v.vendedor, ventas: 0, ingresos: 0, costo: 0, ganancia: 0 };
      map.set(v.vendedor, a);
    }
    a.ventas += 1;
    a.ingresos += v.ingresos;
    a.costo += v.costo;
    a.ganancia += v.ganancia;
  }
  return [...map.values()];
}
