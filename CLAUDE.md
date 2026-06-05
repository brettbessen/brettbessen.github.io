# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Brett Bessen — Academic Website

Quarto website for https://www.brettbessen.com/, hosted on GitHub Pages (`master` branch, `/docs` output dir). Custom domain via GoDaddy.

## Commands

```bash
# Local preview with live reload
quarto preview

# Build to docs/ (required before committing)
quarto render

# Full deploy
quarto render && git add . && git commit -m "message" && git push
```

All commands run from the repo root. Quarto outputs to `docs/` (set in `_quarto.yml`); GitHub Pages serves from there.

## Architecture

Four pages (`index.qmd`, `research.qmd`, `teaching.qmd`, `cv.qmd`) plus `about.qmd`. Site config in `_quarto.yml`: Bootstrap **Cosmo** theme, custom `styles.css`, Google Analytics, `meta.html` injected into every page `<head>` for SEO.

`files/` holds all downloadable assets: `CV.pdf` is a **symlink** to `C:\Users\L03534594\Dropbox\Apps\Overleaf\CV\CV.pdf` — it auto-updates when Overleaf recompiles and Dropbox syncs; never copy the PDF manually. Syllabuses live in `files/syllabuses/`. Lab files live in `files/Labs/` (one subfolder per lab).

## UI Patterns

**Buttons** — all links use Bootstrap outline buttons with `btn-xs` (defined in `styles.css`):
```html
<a href="files/foo.pdf" class="btn btn-outline-secondary btn-xs">
  <i class="bi bi-file-earmark-pdf"></i> Label
</a>
```
Common Bootstrap icons used: `bi-file-earmark-pdf` (PDF), `bi-file-earmark-text` (supplemental), `bi-database` (replication), `bi-unlock` (open access), `bi-code-slash` (R labs).

**Abstract toggles** — grey caret expand/collapse via native `<details>`:
```html
<details><summary>Abstract</summary><p>Text here.</p></details>
```

**Entry dividers** — `<hr>` between each publication or course block.

## Research Page Conventions

Each entry: bold title + authors, journal/year on same line with `·` separators, then buttons, then abstract toggle. Working papers under R&R show "Revise and Resubmit" without naming the journal.

## Teaching Page Conventions

Each course: bold title, semesters offered on the next line (with `\` line break), then buttons. The R Labs button for **Experiments and Causal Inference** links to `files/Labs/`.

## Labs (`files/Labs/`)

Folders contain `.Rmd`/`.R` source files, rendered `.html`/`.pdf` output, and supporting data. **LAPOP data files (`.dta` with "LAPOP" in the name) are proprietary and must never be committed.** Each lab folder that uses LAPOP data has a `README.md` instructing students to download the dataset from https://www.vanderbilt.edu/lapop/raw-data.php, with the specific dataset named.

## CV Symlink

To recreate if ever broken (run in bash):
```bash
ln -s "C:/Users/L03534594/Dropbox/Apps/Overleaf/CV/CV.pdf" \
  "C:/Users/L03534594/OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey/brettbessen-website/files/CV.pdf"
```

## Remaining Tasks

- [ ] Submit site to Google Search Console
- [ ] Add course evaluations/reviews PDF to teaching page
- [ ] Final review and turn off Google Sites
