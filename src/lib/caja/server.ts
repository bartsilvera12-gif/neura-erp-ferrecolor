/**
 * Helpers server-side para el modulo Caja (1 sola caja por empresa).
 */
import type { AppSupabaseClient } from "@/lib/supabase/schema";
import type {
  Caja,
  CajaMovimiento,
  CajaResumen,
  EstadoCaja,
  MedioPagoCaja,
  TipoMovimientoCaja,
} from "./types";

function num(v: unknown): number {
  const n = typeof v === "number" ? v : Number(v ?? 0);
  return Number.isFinite(n) ? n : 0;
}

const CAJA_COLS =
  "id, estado, abierta_por, cerrada_por, fecha_apertura, fecha_cierre, " +
  "monto_apertura, monto_cierre_contado, monto_esperado_efectivo, diferencia, " +
  "observacion_apertura, observacion_cierre";

interface CajaRow {
  id: string;
  estado: string;
  abierta_por: string | null;
  cerrada_por: string | null;
  fecha_apertura: string;
  fecha_cierre: string | null;
  monto_apertura: number | string;
  monto_cierre_contado: number | string | null;
  monto_esperado_efectivo: number | string | null;
  diferencia: number | string | null;
  observacion_apertura: string | null;
  observacion_cierre: string | null;
}

function mapCaja(r: CajaRow): Caja {
  return {
    id: r.id,
    estado: (r.estado === "cerrada" ? "cerrada" : "abierta") as EstadoCaja,
    abierta_por: r.abierta_por,
    cerrada_por: r.cerrada_por,
    fecha_apertura: r.fecha_apertura,
    fecha_cierre: r.fecha_cierre,
    monto_apertura: num(r.monto_apertura),
    monto_cierre_contado:
      r.monto_cierre_contado == null ? null : num(r.monto_cierre_contado),
    monto_esperado_efectivo:
      r.monto_esperado_efectivo == null ? null : num(r.monto_esperado_efectivo),
    diferencia: r.diferencia == null ? null : num(r.diferencia),
    observacion_apertura: r.observacion_apertura,
    observacion_cierre: r.observacion_cierre,
  };
}

/** Devuelve la caja abierta actual de la empresa (o null). */
export async function getCajaAbierta(
  sb: AppSupabaseClient,
  empresaId: string
): Promise<Caja | null> {
  const q = await sb
    .from("cajas")
    .select(CAJA_COLS)
    .eq("empresa_id", empresaId)
    .eq("estado", "abierta")
    .order("fecha_apertura", { ascending: false })
    .limit(1)
    .maybeSingle();
  if (q.error) throw new Error(q.error.message);
  return q.data ? mapCaja(q.data as unknown as CajaRow) : null;
}

/** Historial de cajas (mas reciente primero). */
export async function listarCajas(
  sb: AppSupabaseClient,
  empresaId: string,
  limit = 50
): Promise<Caja[]> {
  const q = await sb
    .from("cajas")
    .select(CAJA_COLS)
    .eq("empresa_id", empresaId)
    .order("fecha_apertura", { ascending: false })
    .limit(limit);
  if (q.error) throw new Error(q.error.message);
  return ((q.data ?? []) as unknown as CajaRow[]).map(mapCaja);
}

/** Resumen/arqueo de UNA caja (ventas + movs + efectivo esperado). */
export async function getResumenCaja(
  sb: AppSupabaseClient,
  empresaId: string,
  cajaId: string
): Promise<CajaResumen | null> {
  const q = await sb
    .from("cajas")
    .select(CAJA_COLS)
    .eq("empresa_id", empresaId)
    .eq("id", cajaId)
    .maybeSingle();
  if (q.error) throw new Error(q.error.message);
  if (!q.data) return null;
  return await computeResumen(sb, empresaId, mapCaja(q.data as unknown as CajaRow));
}

/**
 * Abre una nueva caja. El indice unique parcial en DB protege contra doble
 * apertura concurrente; ademas hacemos un check explicito para devolver un
 * error humano-leible.
 */
export async function abrirCaja(
  sb: AppSupabaseClient,
  params: {
    empresaId: string;
    montoApertura: number;
    observacion: string | null;
    usuarioId: string | null;
  }
): Promise<Caja> {
  const ya = await sb
    .from("cajas")
    .select("id")
    .eq("empresa_id", params.empresaId)
    .eq("estado", "abierta")
    .limit(1)
    .maybeSingle();
  if (ya.error) throw new Error(ya.error.message);
  if (ya.data) {
    throw new Error("Ya hay una caja abierta. Cerrala antes de abrir otra.");
  }
  const ins = await sb
    .from("cajas")
    .insert({
      empresa_id: params.empresaId,
      estado: "abierta",
      abierta_por: params.usuarioId,
      monto_apertura: Math.round(params.montoApertura),
      observacion_apertura: params.observacion,
    })
    .select(CAJA_COLS)
    .single();
  if (ins.error) {
    if (/duplicate|23505/i.test(ins.error.message)) {
      throw new Error("Ya hay una caja abierta. Cerrala antes de abrir otra.");
    }
    throw new Error(ins.error.message);
  }
  return mapCaja(ins.data as unknown as CajaRow);
}

/** Cierra la caja: calcula esperado + diferencia y persiste el arqueo. */
export async function cerrarCaja(
  sb: AppSupabaseClient,
  params: {
    empresaId: string;
    cajaId: string;
    montoCierreContado: number;
    observacion: string | null;
    usuarioId: string | null;
  }
): Promise<CajaResumen> {
  const resumen = await getResumenCaja(sb, params.empresaId, params.cajaId);
  if (!resumen) throw new Error("Caja no encontrada.");
  if (resumen.caja.estado !== "abierta") {
    throw new Error("La caja ya está cerrada.");
  }
  const contado = Math.round(params.montoCierreContado);
  const esperado = Math.round(resumen.efectivo_esperado);
  const diferencia = contado - esperado;

  const upd = await sb
    .from("cajas")
    .update({
      estado: "cerrada",
      cerrada_por: params.usuarioId,
      fecha_cierre: new Date().toISOString(),
      monto_cierre_contado: contado,
      monto_esperado_efectivo: esperado,
      diferencia,
      observacion_cierre: params.observacion,
    })
    .eq("empresa_id", params.empresaId)
    .eq("id", params.cajaId)
    .eq("estado", "abierta")
    .select(CAJA_COLS)
    .single();
  if (upd.error) throw new Error(upd.error.message);

  return {
    ...resumen,
    caja: mapCaja(upd.data as unknown as CajaRow),
    efectivo_esperado: esperado,
  };
}

/** Registra un movimiento manual en la caja abierta. */
export async function registrarMovimiento(
  sb: AppSupabaseClient,
  params: {
    empresaId: string;
    cajaId: string;
    tipo: TipoMovimientoCaja;
    concepto: string;
    monto: number;
    medioPago: MedioPagoCaja;
    observacion: string | null;
    usuarioId: string | null;
  }
): Promise<CajaMovimiento> {
  const cQ = await sb
    .from("cajas")
    .select("id, estado")
    .eq("empresa_id", params.empresaId)
    .eq("id", params.cajaId)
    .maybeSingle();
  if (cQ.error) throw new Error(cQ.error.message);
  if (!cQ.data) throw new Error("Caja no encontrada.");
  if ((cQ.data as { estado: string }).estado !== "abierta") {
    throw new Error("La caja está cerrada; no se pueden registrar movimientos.");
  }

  const ins = await sb
    .from("caja_movimientos")
    .insert({
      empresa_id: params.empresaId,
      caja_id: params.cajaId,
      tipo: params.tipo,
      concepto: params.concepto.trim(),
      monto: Math.round(params.monto),
      medio_pago: params.medioPago,
      usuario_id: params.usuarioId,
      observacion: params.observacion,
    })
    .select(
      "id, caja_id, tipo, concepto, monto, medio_pago, usuario_id, observacion, created_at"
    )
    .single();
  if (ins.error) throw new Error(ins.error.message);
  const m = ins.data as unknown as {
    id: string;
    caja_id: string;
    tipo: string;
    concepto: string;
    monto: number | string;
    medio_pago: string | null;
    usuario_id: string | null;
    observacion: string | null;
    created_at: string;
  };
  return {
    id: m.id,
    caja_id: m.caja_id,
    tipo: m.tipo as TipoMovimientoCaja,
    concepto: m.concepto,
    monto: num(m.monto),
    medio_pago: (m.medio_pago ?? "efectivo") as MedioPagoCaja,
    usuario_id: m.usuario_id,
    observacion: m.observacion,
    created_at: m.created_at,
  };
}

// ============================================================
// Internos
// ============================================================

async function computeResumen(
  sb: AppSupabaseClient,
  empresaId: string,
  caja: Caja
): Promise<CajaResumen> {
  // Ventas asociadas (excluye anuladas si la columna estado existe).
  const vQ = await sb
    .from("ventas")
    .select("total, metodo_pago, estado")
    .eq("empresa_id", empresaId)
    .eq("caja_id", caja.id);
  if (vQ.error) throw new Error(vQ.error.message);
  const ventas = (vQ.data ?? []) as unknown as Array<{
    total: number | string;
    metodo_pago: string | null;
    estado: string | null;
  }>;

  let totalVendido = 0;
  let totalEfectivo = 0;
  let totalTarjeta = 0;
  let totalTransferencia = 0;
  let count = 0;
  for (const v of ventas) {
    if (v.estado === "anulada") continue;
    count++;
    const t = num(v.total);
    totalVendido += t;
    if (v.metodo_pago === "tarjeta") totalTarjeta += t;
    else if (v.metodo_pago === "transferencia") totalTransferencia += t;
    else totalEfectivo += t; // efectivo o sin especificar
  }

  // Movimientos manuales.
  const mQ = await sb
    .from("caja_movimientos")
    .select(
      "id, caja_id, tipo, concepto, monto, medio_pago, usuario_id, observacion, created_at"
    )
    .eq("empresa_id", empresaId)
    .eq("caja_id", caja.id)
    .order("created_at", { ascending: true });
  if (mQ.error) throw new Error(mQ.error.message);
  const rows = (mQ.data ?? []) as unknown as Array<{
    id: string;
    caja_id: string;
    tipo: string;
    concepto: string;
    monto: number | string;
    medio_pago: string | null;
    usuario_id: string | null;
    observacion: string | null;
    created_at: string;
  }>;

  let ingresosEf = 0,
    egresosEf = 0,
    retirosEf = 0,
    ajustesEf = 0;
  const movimientos: CajaMovimiento[] = rows.map((m) => {
    const medio = (m.medio_pago ?? "efectivo") as MedioPagoCaja;
    const tipo = m.tipo as TipoMovimientoCaja;
    const monto = num(m.monto);
    if (medio === "efectivo") {
      if (tipo === "ingreso") ingresosEf += monto;
      else if (tipo === "egreso") egresosEf += monto;
      else if (tipo === "retiro") retirosEf += monto;
      else if (tipo === "ajuste") ajustesEf += monto;
    }
    return {
      id: m.id,
      caja_id: m.caja_id,
      tipo,
      concepto: m.concepto,
      monto,
      medio_pago: medio,
      usuario_id: m.usuario_id,
      observacion: m.observacion,
      created_at: m.created_at,
    };
  });

  const efectivoEsperado =
    caja.monto_apertura +
    totalEfectivo +
    ingresosEf -
    egresosEf -
    retirosEf +
    ajustesEf;

  return {
    caja,
    cantidad_ventas: count,
    total_vendido: totalVendido,
    total_efectivo: totalEfectivo,
    total_tarjeta: totalTarjeta,
    total_transferencia: totalTransferencia,
    ingresos_efectivo: ingresosEf,
    egresos_efectivo: egresosEf,
    retiros_efectivo: retirosEf,
    ajustes_efectivo: ajustesEf,
    efectivo_esperado: efectivoEsperado,
    movimientos,
  };
}
