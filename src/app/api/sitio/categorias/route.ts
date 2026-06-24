import { NextResponse } from "next/server";
import { createServiceRoleClient } from "@/lib/supabase/service-admin";

export const dynamic = "force-dynamic";

export async function GET() {
  const supabase = createServiceRoleClient();

  const { data, error } = await supabase
    .from("categorias")
    .select("id, nombre, slug, imagen_url")
    .order("nombre", { ascending: true });

  if (error) {
    return NextResponse.json(
      { error: "No se pudieron obtener las categorias", details: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json(
    { categorias: data ?? [] },
    {
      headers: {
        "Cache-Control": "public, s-maxage=600, stale-while-revalidate=120",
      },
    }
  );
}
