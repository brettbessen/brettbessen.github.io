# Brett Bessen — Academic Website

## Project Overview
Quarto website to replace current Google Sites page at https://www.brettbessen.com/.
Will be hosted on GitHub Pages with the custom domain pointed from GoDaddy.

## Structure
- `index.qmd` — Home page (bio, two-column layout with headshot)
- `research.qmd` — Publications with paper/supplemental/replication links
- `teaching.qmd` — Course listing
- `cv.qmd` — CV download link (points to `files/CV.pdf`)
- `files/` — PDFs and other downloads
  - `head_shot.jpeg` — Profile photo
  - `CV.pdf` — Symlink to `C:\Users\L03534594\Dropbox\Apps\Overleaf\CV\CV.pdf`
- `styles.css` — Custom styling

## CV Sync
`files/CV.pdf` is a symbolic link to the Dropbox/Overleaf CV. When Overleaf recompiles and Dropbox syncs, the site automatically serves the new PDF on the next `quarto render`/`quarto preview`. No manual copying needed.

To recreate the symlink if ever needed (run in bash):
```bash
ln -s "C:/Users/L03534594/Dropbox/Apps/Overleaf/CV/CV.pdf" \
  "C:/Users/L03534594/OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey/brettbessen-website/files/CV.pdf"
```

## Status (as of 2026-04-05)
- [x] Basic 4-page site created and previewing locally
- [x] All publications added with links to papers, supplementals, replication files
- [x] Social links added (Google Scholar, Twitter/X, LinkedIn, email)
- [x] `files/` folder created for CV and other downloads
- [x] CV symlinked from Dropbox/Overleaf — auto-updates when CV is recompiled
- [x] Profile photo added to home page (two-column layout)
- [x] Git repo initialized and pushed to GitHub as `brettbessen.github.io`
- [x] GitHub Pages enabled (source: `master` branch, `/docs` folder)
- [x] Site live at https://brettbessen.github.io/
- [x] Custom domain `brettbessen.com` configured in GitHub Pages settings; DNS check successful
- [x] GoDaddy DNS updated: 4 GitHub A records and www CNAME added; old Google records removed
- [x] HTTPS enforced via GitHub Pages
- [x] Rejecting Representation paper and supplemental PDFs added to `files/` and linked on research page
- [x] Bio updated and proofread on home page
- [x] SEO: hidden meta description and keywords added via `meta.html` included in page `<head>`

## Remaining Tasks
- [ ] Submit site to Google Search Console
- [ ] Add syllabus/course files to teaching page
- [ ] Add course evaluations/reviews PDF to teaching page
- [ ] Final review and turn off Google Sites

## Deploy Workflow
Edit `.qmd` files → `quarto render` → `git add . && git commit -m "message" && git push`

## Preview
```bash
cd "C:\Users\L03534594\OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey\brettbessen-website"
quarto preview
```
