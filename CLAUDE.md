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

`files/` holds all downloadable assets: `CV.pdf` is a **copy** of `C:\Users\L03534594\Dropbox\Apps\Overleaf\CV\CV.pdf` (it was documented as a symlink, but native symlinks aren't permitted on this machine and the file had gone stale — discovered 2026-07-16). After recompiling the CV, re-copy the PDF here, then `quarto render` and push. Syllabuses live in `files/syllabuses/`. `files/Labs/` is a local clone of the **separate** `causal-inference-labs` GitHub repo — it is gitignored in this repo (the teaching page's R Labs button links to that repo on GitHub, not to local files).

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

Each course: bold title, semesters offered on the next line (with `\` line break), then buttons. The R Labs button for **Experiments and Causal Inference** links to https://github.com/brettbessen/causal-inference-labs.

## Labs (`files/Labs/`)

A local clone of the separate `causal-inference-labs` GitHub repo; gitignored in this repo. Folders contain `.Rmd`/`.R` source files, rendered `.html`/`.pdf` output, and supporting data. **LAPOP data files (`.dta` with "LAPOP" in the name) are proprietary and must never be committed** (in either repo). Each lab folder that uses LAPOP data has a `README.md` instructing students to download the dataset from https://www.vanderbilt.edu/lapop/raw-data.php, with the specific dataset named.

## CV Update Workflow

The CV does not auto-update (see `files/` note above). To publish a new CV (run in bash):
```bash
cp "C:/Users/L03534594/Dropbox/Apps/Overleaf/CV/CV.pdf" \
  "C:/Users/L03534594/OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey/brettbessen-website/files/CV.pdf"
```
Then `quarto render`, commit, and push.

## CPRI Research Group Page

`cpri.qmd` — biweekly CPRI workshop page, hosted by Radha Sarkar and Brett Bessen.
**Built but not yet pushed** (as of 2026-08-22): it exists locally and renders, but
is deliberately unpublished until the dates and links are settled.

Bilingual via the exact EN/ES toggle copied from `power.qmd` (`.lang-en` /
`.lang-es` divs, `body.show-es`, preference stored under the shared `bb-lang`
localStorage key, so the choice carries between the two pages). Brett chose the
toggle over two separate URLs. Page styles are scoped to `#cpri-page` in
`styles.css`.

The Tec torch (`files/tec-logo.png`) is appended to the page title by an
`h1.title::after` rule declared **inside `cpri.qmd`'s own `<style>` block**, not
in `styles.css`. This is deliberate: Quarto renders the title outside
`#cpri-page`, so a rule in the global stylesheet would stamp the torch onto every
page title on the site. Sized `1.45em`, `vertical-align: middle`.

Papers, the sign-up sheet (Excel), and the meeting link all live in a shared
**Tec OneDrive** folder — never in `files/`. Everything in this repo is public and
indexable, so pre-circulated drafts must stay in OneDrive. The page holds only the
schedule table and three outbound links, each appearing twice (English and Spanish)
and marked with a numbered HTML comment.

Editing notes: content is duplicated across the two language blocks, so a schedule
change means editing **two** tables. The English block is authoritative — Brett
edits there, and the Spanish is mirrored from it. The contact line carries both
`radha.sarkar@tec.mx` and `brettbessen@tec.mx`, and exists in English only (Brett:
"basically everyone is bilingual").

## Google Scholar Landing Pages

Google Scholar indexes **one article per page**, so `citation_*` meta tags cannot go
on `research.qmd` (Scholar would ignore them or pick one paper arbitrarily). Each
paper that needs Scholar indexing gets its own landing page at the site root:

- `social-retrospection.qmd` + `_citation-social-retrospection.html`
- `rejecting-representation.qmd` + `_citation-rejecting-representation.html`

The `_citation-*.html` files hold the meta tags; the `.qmd` pulls them in via a
**two-item** `include-in-header` list:

```yaml
include-in-header:
  - meta.html                            # global SEO/OG tags — must stay first
  - _citation-<paper>.html               # this paper's Scholar tags
```

Listing `meta.html` explicitly matters: a document-level `include-in-header`
replaces the project-level one, so omitting it would silently drop the site-wide
description and Open Graph tags from that page.

`citation_pdf_url` must be an **absolute, URL-encoded** URL. Two of the PDFs have
spaces (and the social-retrospection filename has *double* spaces, which encode as
`%20%20`) — generate the encoding, don't hand-type it.

Each landing page is linked from `research.qmd` with a `bi-info-circle` "Details"
button so crawlers can reach it; they are also in `sitemap.xml` automatically.

**To add the judicial-elections working paper:** copy either pair, swap the
metadata, drop `citation_journal_title`/`citation_doi` (unpublished), keep
`citation_pdf_url` pointing at the working-paper PDF once it is in `files/`, and add
the Details button to its entry under Working Papers.

## Remaining Tasks

### CPRI page (blocking publication)
- [ ] Confirm the meeting dates — Brett is still coordinating with other profs.
      Current rows are placeholder biweekly Fridays, Sep 4 – Dec 11 2026. Note for
      whoever picks: Mondays collide with Nov 2 (Día de Muertos) and Nov 16
      (Revolución, observed); Wednesdays collide with Sep 16 (Independencia);
      Fridays/Tuesdays/Thursdays clear all three.
- [ ] Set up the OneDrive folder + Excel sign-up sheet, then paste the three links
      into `cpri.qmd` — 6 `href="#"` placeholders (meeting link, papers folder,
      sign-up sheet × EN and ES). **Brett wants a walkthrough of this, not a
      silent fix.**
- [ ] Stretch goal Brett asked for: have the schedule table **autopopulate from the
      sign-up sheet** instead of being hand-maintained. Needs investigating — the
      workable path is publishing the sheet to the web as CSV and fetching it with
      JS on page load, but that loosens sharing on the sheet, which cuts against
      keeping things behind Tec access. Worth pricing out both ways before building.
- [ ] Then: `quarto render`, commit, push.

### Deferred sidequests
- [ ] Quarto's live reload is broken on this machine — `quarto preview` logs
      `cannot find ... share\preview\quarto-preview.js` and the page never
      auto-refreshes (must Ctrl+F5). `quarto render` is unaffected. Likely a
      partial Quarto install; ~15–20 min to reinstall and verify. Found 2026-08-21.

### Site-wide
- [ ] Submit site to Google Search Console — `sitemap.xml` and `robots.txt` now
      exist (added `site-url` to `_quarto.yml` on 2026-08-22), so the sitemap is
      ready to submit at https://www.brettbessen.com/sitemap.xml
- [ ] Add a Scholar landing page for the judicial-elections working paper once the
      PDF is in `files/` (see "Google Scholar Landing Pages" above)
- [ ] `rejecting-representation`: add `citation_doi`, `citation_volume`,
      `citation_firstpage` — not currently known
- [ ] Add course evaluations/reviews PDF to teaching page
- [ ] Final review and turn off Google Sites
