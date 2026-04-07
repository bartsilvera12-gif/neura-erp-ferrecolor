import { NextRequest } from "next/server";
import {
  handleWhatsAppWebhookGet,
  handleWhatsAppWebhookPost,
} from "@/lib/chat/webhooks/meta-whatsapp-webhook-handlers";

/** Evita caché en Vercel/App Router: Meta debe recibir siempre el challenge en vivo. */
export const dynamic = "force-dynamic";

export async function GET(request: NextRequest) {
  return handleWhatsAppWebhookGet(request);
}

export async function POST(request: NextRequest) {
  return handleWhatsAppWebhookPost(request);
}
