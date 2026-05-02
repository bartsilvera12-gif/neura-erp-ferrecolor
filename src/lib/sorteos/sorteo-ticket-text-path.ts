import "server-only";

import fs from "node:fs";
import path from "node:path";
import { Font, parse } from "opentype.js";

/**
 * Sharp usa librsvg: no aplica @font-face/CSS embebido; el texto sale como □.
 * Rasterizar glyphs como `<path d="..."/>` con Inter (WOFF) evita depender de fuentes del SO.
 *
 * No usar `require.resolve("@fontsource/inter/files/...")`: Turbopack enlazaría centenares de .woff.
 */
export type TicketPathWeight = 400 | 600 | 700 | 800;

const FILE_BY_WEIGHT: Record<TicketPathWeight, string> = {
  400: "inter-latin-400-normal.woff",
  600: "inter-latin-600-normal.woff",
  700: "inter-latin-700-normal.woff",
  800: "inter-latin-800-normal.woff",
};

const fontCache = new Map<TicketPathWeight, Font>();

function resolveInterWoff(weight: TicketPathWeight): string {
  const fp = path.join(process.cwd(), "node_modules/@fontsource/inter/files", FILE_BY_WEIGHT[weight]);
  if (!fs.existsSync(fp)) {
    throw new Error(`Inter WOFF no encontrado: ${fp}`);
  }
  return fp;
}

export function normalizeTicketFontWeight(w: number): TicketPathWeight {
  if (w <= 450) return 400;
  if (w <= 650) return 600;
  if (w <= 750) return 700;
  return 800;
}

export function getSorteoInterFont(weight: number): Font {
  const w = normalizeTicketFontWeight(weight);
  const cached = fontCache.get(w);
  if (cached) return cached;
  const fp = resolveInterWoff(w);
  const buf = fs.readFileSync(fp);
  const font = parse(new Uint8Array(buf));
  fontCache.set(w, font);
  return font;
}

function escAttr(s: string): string {
  return s.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;");
}

/**
 * Devuelve `<path .../>` o cadena vacía. `y` = línea base (igual que `<text y>`).
 */
export function svgTextAsPath(opts: {
  text: string;
  x: number;
  y: number;
  fontSize: number;
  weight: number;
  fill: string;
  textAnchor?: "start" | "middle";
}): string {
  const t = opts.text.replace(/\s+/g, " ").trim();
  if (!t) return "";
  try {
    const font = getSorteoInterFont(opts.weight);
    let x0 = opts.x;
    if (opts.textAnchor === "middle") {
      const adv = font.getAdvanceWidth(t, opts.fontSize);
      x0 = opts.x - adv / 2;
    }
    const p = font.getPath(t, x0, opts.y, opts.fontSize);
    const d = p.toPathData(2);
    if (!d) return "";
    const dEsc = d.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
    return `<path fill="${escAttr(opts.fill)}" d="${dEsc}"/>`;
  } catch (e) {
    console.warn("[sorteo-ticket] text_path_failed", {
      message: e instanceof Error ? e.message : String(e),
    });
    return "";
  }
}
