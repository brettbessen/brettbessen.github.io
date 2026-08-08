# Central vs. noncentral t figure for power.qmd -------------------------------
#
# Draws the two t distributions behind a two-sample test: the central t that the
# t-statistic follows under the null, and the noncentral t it follows when the
# treatment really has an effect. The area of the shifted curve past the critical
# value is power. Writes one standalone SVG per language into files/.
#
# Run from the repo root:
#   & "C:\Program Files\R\R-4.3.0\bin\Rscript.exe" scripts/make_ncp_figure.R

## Design being illustrated -----------------------------------------------------
# df = 2n - 2 for n = 150 per group, which is the calculator's default design.
# With ncp = 2.8 this lands at 79.7% power, i.e. the "about 80%" in the text.
df    <- 298
ncp   <- 2.8
alpha <- 0.05

tcrit <- qt(1 - alpha / 2, df)
pow   <- 1 - pt(tcrit, df, ncp)
cat(sprintf("df = %d, ncp = %.2f, t* = %.4f, power = %.4f\n", df, ncp, tcrit, pow))

## Geometry ---------------------------------------------------------------------
W <- 640; H <- 300
L <- 46;  R <- 624; TOP <- 26; BOT <- 246      # plot box, in SVG user units
xlo <- -4; xhi <- 8
ymax <- 0.42

sx <- function(x) L + (x - xlo) / (xhi - xlo) * (R - L)
sy <- function(y) BOT - (y / ymax) * (BOT - TOP)

fmt      <- function(v) formatC(v, digits = 1, format = "f")
polyline <- function(x, y) paste(paste0(fmt(sx(x)), ",", fmt(sy(y))), collapse = " ")

## Curves -----------------------------------------------------------------------
xs <- seq(xlo, xhi, length.out = 400)
y0 <- dt(xs, df)             # under the null
y1 <- dt(xs, df, ncp)        # under a real effect

## Shaded regions ---------------------------------------------------------------
shade <- function(dens_args, n = 200) {
  x <- seq(tcrit, xhi, length.out = n)
  y <- do.call(dt, c(list(x = x), dens_args))
  paste0("M", fmt(sx(tcrit)), ",", fmt(sy(0)), " L", polyline(x, y),
         " L", fmt(sx(xhi)), ",", fmt(sy(0)), " Z")
}
pow_path   <- shade(list(df = df, ncp = ncp))        # power
alpha_path <- shade(list(df = df), n = 120)          # alpha/2, the null's own tail

## x-axis ------------------------------------------------------------------------
ticks <- seq(-4, 8, by = 2)
tick_svg <- paste0(
  '<line x1="', fmt(sx(ticks)), '" y1="', fmt(BOT), '" x2="', fmt(sx(ticks)),
  '" y2="', fmt(BOT + 5), '" stroke="#adb5bd" stroke-width="1"/>',
  '<text x="', fmt(sx(ticks)), '" y="', fmt(BOT + 18),
  '" text-anchor="middle" font-size="11" fill="#868e96">', ticks, '</text>',
  collapse = "\n  ")

## Assemble ----------------------------------------------------------------------
svg_for <- function(lab) paste0(
'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ', W, ' ', H, '" width="', W, '" height="', H, '"
     role="img" aria-label="', lab$alt, '"
     font-family="system-ui, -apple-system, Segoe UI, Helvetica, Arial, sans-serif">
  <title>', lab$alt, '</title>
  <path d="', pow_path, '" fill="#2780e3" fill-opacity="0.18"/>
  <path d="', alpha_path, '" fill="#ff0039" fill-opacity="0.35"/>
  <polyline points="', polyline(xs, y0), '" fill="none" stroke="#868e96" stroke-width="1.6" stroke-dasharray="5 3"/>
  <polyline points="', polyline(xs, y1), '" fill="none" stroke="#2780e3" stroke-width="2"/>
  <line x1="', fmt(sx(tcrit)), '" y1="', fmt(TOP - 4), '" x2="', fmt(sx(tcrit)), '" y2="', fmt(BOT), '"
        stroke="#343a40" stroke-width="1.2" stroke-dasharray="3 3"/>
  <text x="', fmt(sx(tcrit) - 6), '" y="', fmt(BOT - 7), '" text-anchor="end" font-size="11" fill="#343a40">', lab$crit, '</text>
  <line x1="', L, '" y1="', BOT, '" x2="', R, '" y2="', BOT, '" stroke="#adb5bd" stroke-width="1"/>
  ', tick_svg, '
  <text x="', fmt((L + R) / 2), '" y="', H - 6, '" text-anchor="middle" font-size="11" fill="#868e96">', lab$xlab, '</text>
  <text x="', fmt(sx(-0.15)), '" y="', fmt(sy(dt(0, df)) - 8), '" text-anchor="middle" font-size="11.5" fill="#6c757d">', lab$null, '</text>
  <text x="', fmt(sx(ncp + 1.1)), '" y="', fmt(sy(dt(0, df)) - 8), '" text-anchor="middle" font-size="11.5" fill="#2780e3">', lab$alt2, '</text>
  <text x="', fmt(sx(3.4)), '" y="', fmt(sy(0.10)), '" text-anchor="middle" font-size="11.5" fill="#1b5fa8">', lab$pow, '</text>
</svg>')

en <- list(
  alt  = "Central t distribution under the null and noncentral t under a real effect, with the power region shaded",
  crit = paste0("t* = ", formatC(tcrit, digits = 2, format = "f")),
  xlab = "t-statistic",
  null = "null (central t)",
  alt2 = "real effect (ncp = 2.8)",
  pow  = paste0("power = ", formatC(100 * pow, digits = 0, format = "f"), "%")
)

es <- list(
  alt  = "Distribuci\u00f3n t central bajo la nula y t no central bajo un efecto real, con la regi\u00f3n de potencia sombreada",
  crit = paste0("t* = ", formatC(tcrit, digits = 2, format = "f")),
  xlab = "estad\u00edstico t",
  null = "nula (t central)",
  alt2 = "efecto real (pnc = 2.8)",   # Spanish uses pnc: parametro de no centralidad
  pow  = paste0("potencia = ", formatC(100 * pow, digits = 0, format = "f"), "%")
)

write_svg <- function(txt, path) {
  con <- file(path, open = "wt", encoding = "UTF-8")
  on.exit(close(con))
  writeLines(txt, con, useBytes = FALSE)
}

# Each language's file is named for the abbreviation it uses in the text:
# ncp (noncentrality parameter) in English, pnc (parametro de no centralidad)
# in Spanish.
dir.create("files", showWarnings = FALSE)
write_svg(svg_for(en), "files/ncp-en.svg")
write_svg(svg_for(es), "files/pnc-es.svg")
cat("wrote files/ncp-en.svg and files/pnc-es.svg\n")
