// Tipos de los reportes operativos (server-side, schema reservacaacupe).
// Fase 1: Estado de cuenta + Proveedores. (Ventas/Compras/Conciliación: pendientes.)

export interface MovimientoEstadoCuenta {
  fecha: string;
  tipo: string; // Venta | Compra | Gasto
  referencia: string;
  descripcion: string;
  entrada: number;
  salida: number;
}

export interface EstadoCuentaReporte {
  mes: string;
  ingresosVentas: number;
  compras: number;
  gastos: number;
  resultado: number; // ventas - compras - gastos
  /** Ventas a crédito del período (sin aplicación de pagos parciales). */
  porCobrar: number;
  /** Compras a crédito del período (sin aplicación de pagos parciales). */
  porPagar: number;
  movimientos: MovimientoEstadoCuenta[];
}

export interface ProveedorReporteRow {
  id: string;
  nombre: string;
  ruc: string | null;
  telefono: string | null;
  cantidad: number;
  total: number;
  ultima_compra: string | null;
}

export interface ProveedoresReporte {
  mes: string;
  totalProveedores: number;
  conCompras: number;
  totalComprado: number;
  compraPromedio: number;
  ultimaCompra: { numero_control: string; proveedor_nombre: string; total: number; fecha: string } | null;
  proveedores: ProveedorReporteRow[];
}
