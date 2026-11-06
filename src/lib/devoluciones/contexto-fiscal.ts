/**
 * Clasificación del contexto fiscal de una venta para una devolución.
 *
 * Función PURA (sin BD). A partir del estado de la factura ERP, del documento
 * electrónico SIFEN y del autoimpresor, decide:
 *   - si la venta tiene un documento fiscal,
 *   - qué aviso corresponde mostrar al operador, y
 *   - si la devolución debería requerir una nota de crédito.
 *
 * Reglas (ver reporte Ferrecolor):
 *  - Factura electrónica APROBADA por la SET: no se edita ni se anula sola; según
 *    la ventana de cancelación corresponde cancelar el DE o emitir nota de crédito.
 *  - Documento electrónico NO aprobado (borrador/firmado/enviado/rechazado): se
 *    puede anular/corregir al devolver, sin poder enviarse luego por el original.
 *  - Autoimpresor (impreso, no electrónico): requiere gestión manual de NC/anulación.
 */

export type AvisoFiscal =
  | "ninguno"
  | "autoimpresor"
  | "cancelar_de"
  | "nota_credito"
  | "anular_no_enviada";

export interface ContextoFiscalInput {
  /** La venta tiene una factura ERP vinculada (ventas.factura_id). */
  tieneFactura: boolean;
  /** Estado de la factura ERP ('Pagado'|'Pendiente'|'Vencido'|'Anulado') o null. */
  facturaEstado: string | null;
  /** Hay fila en factura_autoimpresor para la venta. */
  tieneAutoimpresor: boolean;
  /** estado_sifen del documento electrónico, o null si no hay DE. */
  sifenEstado: string | null;
  /** Resultado de buildSifenCancelacionPreview().puede_cancelar (ventana vigente). */
  puedeCancelarDE: boolean;
}

export interface ContextoFiscal {
  /** La venta tiene un documento fiscal relevante (electrónico aprobado o autoimpresor). */
  tiene_factura_fiscal: boolean;
  /** La devolución debería disparar/avisar una nota de crédito. */
  requiere_nota_credito: boolean;
  aviso: AvisoFiscal;
  aviso_texto: string;
  /** La factura ERP se puede anular/ajustar automáticamente al devolver (no aprobada por SET). */
  factura_editable: boolean;
}

export function clasificarContextoFiscal(input: ContextoFiscalInput): ContextoFiscal {
  const estadoFactura = String(input.facturaEstado ?? "");
  const sifen = String(input.sifenEstado ?? "");

  // Factura ERP ya anulada o sin factura: nada fiscal que resolver.
  if (!input.tieneFactura || estadoFactura === "Anulado") {
    // Puede haber autoimpresor sin factura ERP (camino no electrónico).
    if (input.tieneAutoimpresor) {
      return {
        tiene_factura_fiscal: true,
        requiere_nota_credito: true,
        aviso: "autoimpresor",
        aviso_texto:
          "La venta tiene factura de autoimpresor (impresa). Gestioná la nota de crédito o anulación del comprobante impreso según corresponda; este módulo no la emite.",
        factura_editable: false,
      };
    }
    return {
      tiene_factura_fiscal: false,
      requiere_nota_credito: false,
      aviso: "ninguno",
      aviso_texto: "",
      factura_editable: false,
    };
  }

  // Documento electrónico APROBADO por la SET: no se toca la factura automáticamente.
  if (sifen === "aprobado") {
    if (input.puedeCancelarDE) {
      return {
        tiene_factura_fiscal: true,
        requiere_nota_credito: true,
        aviso: "cancelar_de",
        aviso_texto:
          "La factura electrónica está aprobada por la SET pero todavía estás dentro del plazo de cancelación. Corresponde CANCELAR el documento electrónico (no emitir nota de crédito).",
        factura_editable: false,
      };
    }
    return {
      tiene_factura_fiscal: true,
      requiere_nota_credito: true,
      aviso: "nota_credito",
      aviso_texto:
        "La factura electrónica está aprobada por la SET. Corresponde emitir una NOTA DE CRÉDITO; este módulo no la emite automáticamente.",
      factura_editable: false,
    };
  }

  // Hay documento electrónico pero NO aprobado (borrador/generado/firmado/enviado/
  // rechazado/error_envio): se puede anular la factura, y no debe enviarse luego.
  if (sifen && sifen !== "cancelado") {
    return {
      tiene_factura_fiscal: false,
      requiere_nota_credito: false,
      aviso: "anular_no_enviada",
      aviso_texto:
        "La factura aún no fue aprobada por la SET. Al devolver se anulará para que no se envíe después por el monto original.",
      factura_editable: true,
    };
  }

  // Factura ERP sin documento electrónico (modo sin factura fiscal) o DE ya cancelado,
  // pero con autoimpresor: gestión manual del impreso.
  if (input.tieneAutoimpresor) {
    return {
      tiene_factura_fiscal: true,
      requiere_nota_credito: true,
      aviso: "autoimpresor",
      aviso_texto:
        "La venta tiene factura de autoimpresor (impresa). Gestioná la nota de crédito o anulación del comprobante impreso según corresponda; este módulo no la emite.",
      factura_editable: false,
    };
  }

  // Factura ERP no fiscal (sin DE ni autoimpresor): se puede anular/ajustar al devolver.
  return {
    tiene_factura_fiscal: false,
    requiere_nota_credito: false,
    aviso: "anular_no_enviada",
    aviso_texto: "La factura interna se anulará o ajustará al registrar la devolución.",
    factura_editable: true,
  };
}
