import type { NextConfig } from "next";

/**
 * Dominio del sitio público estático (HTML servido desde public/sitio/).
 * El ERP responde en cualquier otro hostname (típicamente erp.<dominio>).
 *
 * Para producción, setear `SITIO_HOST_REGEX` en Coolify. Acepta regex.
 * Default: matchea ferreteriarepublica.com y www.ferreteriarepublica.com.
 */
const SITIO_HOST_REGEX =
  process.env.SITIO_HOST_REGEX ?? "(www\\.)?ferreteriarepublica\\.com";

const nextConfig: NextConfig = {
  async rewrites() {
    return {
      beforeFiles: [
        {
          source: "/",
          has: [{ type: "host", value: SITIO_HOST_REGEX }],
          destination: "/sitio/index.html",
        },
        {
          source: "/catalogo",
          has: [{ type: "host", value: SITIO_HOST_REGEX }],
          destination: "/sitio/catalogo.html",
        },
        {
          source: "/:path*",
          has: [{ type: "host", value: SITIO_HOST_REGEX }],
          destination: "/sitio/:path*",
        },
      ],
      afterFiles: [],
      fallback: [],
    };
  },
};

export default nextConfig;
