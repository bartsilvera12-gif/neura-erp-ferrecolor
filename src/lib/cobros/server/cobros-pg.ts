import type { AppSupabaseClient } from "@/lib/supabase/schema";

export type MetodoPagoCobro = "efectivo" | "transferencia" | "tarjeta" | "otro";

export interface RegistrarCobroInput {
  cuenta_por_cobrar_id: string;
  monto: number;
  metodo_pago: MetodoPagoCobro;
  entidad_bancaria_id?: string | null;
  referencia?: string | null;
  titular?: string | null;
  observaciones?: string | null;
  fecha_pago?: string | null;
  usuario_id?: string | null;
  usuario_nombre?: string | null;
  entidad_nombre_snapshot?: string | null;
  /**
   * Id del usuario en la tabla `usuarios` del tenant (NO el de auth). Se usa
   * para el movimiento de caja: la caja resuelve los nombres contra `usuarios`,
   * asi que con el id de auth el movimiento saldria sin autor.
   */
  usuario_catalog_id?: string | null;
  usuario_email?: string | null;
}

export class CobroError extends Error {
  status: number;
  constructor(message: string, status = 400) {
    super(message);
    this.name = "CobroError";
    this.status = status;
  }
}

function round2(n: number): number {
  return Math.round((n + Number.EPSILON) * 100) / 100;
}

function metodoValido(m: unknown): MetodoPagoCobro {
  return m === "transferencia" || m === "tarjeta" || m === "otro" ? m : "efectivo";
}

/**
 * Registra un cobro contra una cuenta por cobrar: inserta en `cobros_clientes`,
 * descuenta el saldo y recalcula el estado (pendiente|parcial|pagado).
 * No permite cobrar más que el saldo. NO toca stock ni ventas.
 *
 * ADEMAS genera el movimiento de caja correspondiente. Una venta a credito no
 * mueve plata al facturarse —la caja la cuenta en total_vendido pero en ningun
 * medio de pago—, asi que la plata entra recien cuando se cobra. Sin este
 * puente, un cobro en efectivo no aparecia por ningun lado y al cajero no le
 * cerraba el arqueo: tenia el billete en la mano y el sistema no lo contaba.
 *
 * - En EFECTIVO exige caja abierta: si no hay ninguna, la plata quedaria sin
 *   registrar en ningun turno, que es justamente el problema que esto arregla.
 * - En transferencia/tarjeta/otro el movimiento se registra solo si hay una
 *   caja abierta, y es informativo: no afecta el efectivo esperado.
 */
export async function registrarCobro(
  sb: AppSupabaseClient,
  empresaId: string,
  input: RegistrarCobroInput
): Promise<{ cobro_id: string; saldo_nuevo: number; estado: string; caja_movimiento_id: string | null }> {
  const monto = round2(Number(input.monto) || 0);
  if (!(monto > 0)) throw new CobroError("El monto del cobro debe ser mayor a cero.");
  if (!input.cuenta_por_cobrar_id) throw new CobroError("Falta la cuenta por cobrar.");

  const cq = await sb
    .from("cuentas_por_cobrar")
    .select("id, cliente_id, venta_id, total, saldo, estado")
    .eq("empresa_id", empresaId)
    .eq("id", input.cuenta_por_cobrar_id)
    .maybeSingle();
  if (cq.error) throw new CobroError(cq.error.message, 500);
  if (!cq.data) throw new CobroError("Cuenta por cobrar no encontrada.", 404);
  const cxc = cq.data as {
    id: string;
    cliente_id: string;
    venta_id: string;
    total: number | string;
    saldo: number | string;
    estado: string;
  };

  if (cxc.estado === "anulado") throw new CobroError("La cuenta está anulada; no admite cobros.", 409);
  if (cxc.estado === "pagado") throw new CobroError("La cuenta ya está pagada.", 409);

  const saldoActual = round2(Number(cxc.saldo) || 0);
  const total = round2(Number(cxc.total) || 0);
  if (monto > saldoActual + 0.001) {
    throw new CobroError(`El monto (${monto}) supera el saldo pendiente (${saldoActual}).`);
  }

  const fechaPago =
    typeof input.fecha_pago === "string" && input.fecha_pago.trim() ? input.fecha_pago : new Date().toISOString();

  const metodo = metodoValido(input.metodo_pago);
  const esEfectivo = metodo === "efectivo";

  // Caja abierta donde imputar el cobro. Se busca ANTES de insertar nada: si un
  // cobro en efectivo no tiene donde caer, conviene frenar y no dejar el cobro
  // registrado y la plata fuera de toda caja.
  const cajaQ = await sb
    .from("cajas")
    .select("id, numero_caja")
    .eq("empresa_id", empresaId)
    .eq("estado", "abierta")
    .order("fecha_apertura", { ascending: false })
    .limit(1)
    .maybeSingle();
  if (cajaQ.error) throw new CobroError(cajaQ.error.message, 500);
  const cajaAbiertaId = cajaQ.data ? String((cajaQ.data as { id: string }).id) : null;
  if (esEfectivo && !cajaAbiertaId) {
    throw new CobroError(
      "No hay ninguna caja abierta para registrar un cobro en efectivo. Abrí la caja y volvé a cobrar, así el dinero queda en el arqueo del turno.",
      409
    );
  }

  // 1) Insertar el cobro.
  const ins = await sb
    .from("cobros_clientes")
    .insert({
      empresa_id: empresaId,
      cliente_id: cxc.cliente_id,
      cuenta_por_cobrar_id: cxc.id,
      venta_id: cxc.venta_id,
      fecha_pago: fechaPago,
      monto,
      metodo_pago: metodo,
      entidad_bancaria_id: input.entidad_bancaria_id || null,
      entidad_nombre_snapshot: input.entidad_nombre_snapshot?.trim() || null,
      referencia: input.referencia?.trim() || null,
      titular: input.titular?.trim() || null,
      observaciones: input.observaciones?.trim() || null,
      usuario_id: input.usuario_id || null,
      usuario_nombre: input.usuario_nombre?.trim() || null,
    })
    .select("id")
    .single();
  if (ins.error) throw new CobroError(ins.error.message, 500);
  const cobroId = String((ins.data as { id: string }).id);

  // 2) Recalcular saldo + estado.
  const saldoNuevo = round2(saldoActual - monto);
  const estadoNuevo = saldoNuevo <= 0.001 ? "pagado" : saldoNuevo < total ? "parcial" : "pendiente";
  const upd = await sb
    .from("cuentas_por_cobrar")
    .update({ saldo: saldoNuevo < 0 ? 0 : saldoNuevo, estado: estadoNuevo, updated_at: new Date().toISOString() })
    .eq("empresa_id", empresaId)
    .eq("id", cxc.id);
  if (upd.error) {
    // Rollback best-effort del cobro para no descuadrar el saldo.
    try {
      await sb.from("cobros_clientes").delete().eq("id", cobroId).eq("empresa_id", empresaId);
    } catch {}
    throw new CobroError(upd.error.message, 500);
  }

  // 3) Movimiento de caja: es lo que hace que el cobro aparezca en el arqueo.
  let cajaMovimientoId: string | null = null;
  if (cajaAbiertaId) {
    // El numero de la venta ayuda al cajero a identificar el cobro en el detalle.
    let refVenta = "";
    try {
      const vQ = await sb
        .from("ventas")
        .select("numero_control")
        .eq("empresa_id", empresaId)
        .eq("id", cxc.venta_id)
        .maybeSingle();
      const nc = (vQ.data as { numero_control?: string | null } | null)?.numero_control;
      if (nc) refVenta = ` ${nc}`;
    } catch {
      /* el concepto igual sirve sin el numero */
    }
    const concepto = `Cobro crédito${refVenta}`.slice(0, 200);

    const insMov = await sb
      .from("caja_movimientos")
      .insert({
        empresa_id: empresaId,
        caja_id: cajaAbiertaId,
        tipo: "ingreso",
        concepto,
        monto,
        medio_pago: metodo,
        usuario_id: input.usuario_catalog_id || null,
        usuario_email: input.usuario_email || null,
        // A proposito NO se setea venta_id: el reporte de cajas descarta los
        // movimientos cuya venta quedo devuelta_total, y eso borraria del arqueo
        // un cobro que si entro. La trazabilidad va en la observacion.
        observacion: `cobro:${cobroId}`,
      })
      .select("id")
      .single();

    if (insMov.error) {
      // Rollback best-effort: sin transacciones en PostgREST, se deshace a mano
      // para no dejar el saldo descontado sin la plata registrada.
      try {
        await sb
          .from("cuentas_por_cobrar")
          .update({ saldo: saldoActual, estado: cxc.estado, updated_at: new Date().toISOString() })
          .eq("empresa_id", empresaId)
          .eq("id", cxc.id);
      } catch {}
      try {
        await sb.from("cobros_clientes").delete().eq("id", cobroId).eq("empresa_id", empresaId);
      } catch {}
      throw new CobroError(
        `El cobro no se registró porque no se pudo imputar a la caja: ${insMov.error.message}`,
        500
      );
    }
    cajaMovimientoId = String((insMov.data as { id: string }).id);
  }

  return {
    cobro_id: cobroId,
    saldo_nuevo: saldoNuevo < 0 ? 0 : saldoNuevo,
    estado: estadoNuevo,
    caja_movimiento_id: cajaMovimientoId,
  };
}
