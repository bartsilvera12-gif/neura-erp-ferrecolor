import { NextRequest, NextResponse } from "next/server";
import { errorResponse, successResponse } from "@/lib/api/response";
import { repoLoadQueueEditorBootstrap } from "@/lib/chat/queue-admin-repo";
import { resolveQueueAdminTenantContext } from "../../_tenant-ctx";

export async function GET(request: NextRequest, ctx: { params: Promise<{ queueId: string }> }) {
  const resolved = await resolveQueueAdminTenantContext(request);
  if (!resolved) {
    return NextResponse.json(errorResponse("No autorizado"), { status: 401 });
  }
  const { queueId } = await ctx.params;
  try {
    const data = await repoLoadQueueEditorBootstrap(resolved.ctx, queueId);
    return NextResponse.json(successResponse(data));
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Error al cargar cola";
    return NextResponse.json(errorResponse(msg), { status: 500 });
  }
}
