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
- [x] Custom domain `brettbessen.com` configured in GitHub Pages settings
- [x] Old Google Sites DNS records removed from GoDaddy (locked A records — may need GoDaddy support to confirm removal)
- [ ] Add remaining 3 GitHub Pages A records in GoDaddy (185.199.109.153, 185.199.110.153, 185.199.111.153) — first one (185.199.108.153) may already be added
- [ ] Add CNAME record in GoDaddy: `www` → `brettbessen.github.io`

## GoDaddy DNS Records to Add
Four A records (Name = `@`) and one CNAME:
| Type | Name | Data |
|------|------|------|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | brettbessen.github.io |

## Remaining Tasks
- [ ] Finish adding DNS records in GoDaddy (see above)
- [ ] Verify domain is active and HTTPS is working (check GitHub repo Settings → Pages)
- [ ] Add syllabus/course files to teaching page
- [ ] Add course evaluations/reviews PDF to teaching page
- [ ] Final review before going live and turning off Google Sites

## Deploy Workflow
Edit `.qmd` files → `quarto render` → `git add . && git commit -m "message" && git push`

## Preview
```bash
cd "C:\Users\L03534594\OneDrive - Instituto Tecnologico y de Estudios Superiores de Monterrey\brettbessen-website"
quarto preview
```
