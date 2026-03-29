/** Helpers para mostrar adjuntos en el ERP (sin depender del cliente Supabase). */

export type RawPayload = Record<string, unknown> | null | undefined;

export function getErpAttachmentPublicUrl(raw: RawPayload): string | null {
  const erp = raw?.erp;
  if (!erp || typeof erp !== "object" || Array.isArray(erp)) return null;
  const url = (erp as { public_url?: string }).public_url;
  return typeof url === "string" && /^https?:\/\//i.test(url.trim()) ? url.trim() : null;
}

export function getErpAttachmentFilename(raw: RawPayload): string | null {
  const erp = raw?.erp;
  if (!erp || typeof erp !== "object" || Array.isArray(erp)) return null;
  const fn = (erp as { filename?: string }).filename;
  return typeof fn === "string" && fn.trim() ? fn.trim() : null;
}

export function getErpAttachmentCaption(raw: RawPayload): string | null {
  const erp = raw?.erp;
  if (!erp || typeof erp !== "object" || Array.isArray(erp)) return null;
  const c = (erp as { caption?: string }).caption;
  return typeof c === "string" && c.trim() ? c.trim() : null;
}

export function getMetaInboundDocumentFilename(raw: RawPayload): string | null {
  const doc = raw?.document;
  if (!doc || typeof doc !== "object" || Array.isArray(doc)) return null;
  const fn = (doc as { filename?: string }).filename;
  return typeof fn === "string" && fn.trim() ? fn.trim() : null;
}

export function isImageMimeHint(raw: RawPayload, messageType: string): boolean {
  if (messageType === "image" || messageType === "sticker") return true;
  const erp = raw?.erp;
  if (erp && typeof erp === "object" && !Array.isArray(erp)) {
    const mt = (erp as { mime_type?: string }).mime_type;
    if (typeof mt === "string" && mt.toLowerCase().startsWith("image/")) return true;
  }
  const doc = raw?.document;
  if (doc && typeof doc === "object" && !Array.isArray(doc)) {
    const mt = (doc as { mime_type?: string }).mime_type;
    if (typeof mt === "string" && mt.toLowerCase().startsWith("image/")) return true;
  }
  return false;
}
