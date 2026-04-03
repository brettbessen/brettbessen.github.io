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

## Status (as of 2026-04-03)
- [x] Basic 4-page site created and previewing locally
- [x] All publications added with links to papers, supplementals, replication files
- [x] Social links added (Google Scholar, Twitter/X, LinkedIn, email)
- [x] `files/` folder created for CV and other downloads
- [x] CV symlinked from Dropbox/Overleaf — auto-updates when CV is recompiled
- [x] Profile photo added to home page (two-column layout)

## Remaining Tasks
- [ ] Add working papers section to research page
- [ ] Add syllabus/course files to teaching page
- [ ] Add course evaluations/reviews PDF to teaching page
- [ ] Initialize git repo and push to GitHub as `brettbessen.github.io`
- [ ] Enable GitHub Pages on the repo
- [ ] Point GoDaddy domain (brettbessen.com) to GitHub Pages
- [ ] Final review before going live and turning off Google Sites

## Preview
```bash
cd "C:\Users\L03534594\OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey\brettbessen-website"
quarto preview
```
