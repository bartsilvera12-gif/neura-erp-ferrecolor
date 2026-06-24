import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

/**
 * Hostnames que sirven el sitio público estático.
 * Configurable vía SITIO_HOST_REGEX (mismo valor que en next.config.ts).
 */
const SITIO_HOST_REGEX = new RegExp(
  `^${process.env.SITIO_HOST_REGEX ?? "(www\\.)?ferreteriarepublica\\.com"}$`
);

function isSitioHost(host: string | null): boolean {
  if (!host) return false;
  const hostname = host.split(":")[0];
  return SITIO_HOST_REGEX.test(hostname);
}

/**
 * Refresca la sesión Supabase en cookies antes de Route Handlers / RSC.
 * Solo NEXT_PUBLIC_SUPABASE_URL + NEXT_PUBLIC_SUPABASE_ANON_KEY (sin db.schema en getUser).
 *
 * Si el request entra por el host del sitio público, se devuelve next() sin tocar Supabase:
 * los rewrites de next.config.ts mandan a public/sitio/.
 */
export async function middleware(request: NextRequest) {
  if (isSitioHost(request.headers.get("host"))) {
    return NextResponse.next({ request });
  }

  let supabaseResponse = NextResponse.next({ request });

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    return supabaseResponse;
  }

  const supabase = createServerClient(url, anonKey, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
        supabaseResponse = NextResponse.next({ request });
        cookiesToSet.forEach(({ name, value, options }) =>
          supabaseResponse.cookies.set(name, value, options)
        );
      },
    },
  });

  await supabase.auth.getUser();

  return supabaseResponse;
}

/**
 * Excluir `/api/webhooks/*`: Meta hace GET sin cookies para verificar el webhook;
 * no debe pasar por refresh de sesión Supabase (y queda listo para proxies estrictos).
 */
export const config = {
  matcher: [
    "/((?!api/webhooks|_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
