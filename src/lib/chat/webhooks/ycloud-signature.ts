import { createHmac, timingSafeEqual } from "crypto";

/**
 * YCloud: header `YCloud-Signature: t={unixSeconds},s={signature}`
 * signed_payload = `{t}.{rawBody}.`
 * signature = HMAC-SHA256(signed_payload, webhook_secret) en hexadecimal (minúsculas).
 * @see https://helpdocs.ycloud.com/help-center/integrations/webhook
 */
export function verifyYCloudWebhookSignature(
  rawBody: string,
  signatureHeader: string | null | undefined,
  webhookSecret: string
): boolean {
  const secret = webhookSecret.trim();
  if (!secret || !signatureHeader?.trim()) return false;

  let t = "";
  let s = "";
  for (const part of signatureHeader.split(",")) {
    const p = part.trim();
    if (p.startsWith("t=")) t = p.slice(2).trim();
    else if (p.startsWith("s=")) s = p.slice(2).trim();
  }
  if (!t || !s) return false;

  const signedPayload = `${t}.${rawBody}.`;
  const expectedHex = createHmac("sha256", secret).update(signedPayload, "utf8").digest("hex");
  const got = s.trim().toLowerCase();
  const exp = expectedHex.toLowerCase();
  if (got.length !== exp.length || got.length % 2 !== 0) return false;
  try {
    return timingSafeEqual(Buffer.from(got, "hex"), Buffer.from(exp, "hex"));
  } catch {
    return false;
  }
}
