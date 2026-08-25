"""Strip leaked/duplicate social-card meta tags from docs/cpri.html.

Quarto's include-in-header at the document level does NOT reliably replace
project-level meta.html, and open-graph:false / twitter-card:false do not
suppress Quarto's own auto-generated og:*/twitter:* tags (confirmed
2026-08-25, Quarto 1.4.554). Every `quarto render` of cpri.qmd re-leaks the
site-wide Brett Bessen branding into the page's social-card tags ahead of
the correct ones from _og-cpri.html. Run this after any render that touches
cpri.qmd, before publishing:

    python scripts/fix_cpri_meta.py
"""

import re
from pathlib import Path

PATH = Path(__file__).resolve().parent.parent / "docs" / "cpri.html"

TARGETS = {
    "description", "keywords", "og:type", "og:url", "og:title",
    "og:description", "og:image", "twitter:card", "twitter:site",
    "twitter:title", "twitter:description", "twitter:image",
}


def key_of(line: str) -> str | None:
    m = re.match(r'<meta (?:name|property)="([^"]+)"', line)
    return m.group(1) if m else None


def main() -> None:
    lines = PATH.read_text(encoding="utf-8").splitlines(keepends=True)

    last_idx = {}
    for i, line in enumerate(lines):
        k = key_of(line)
        if k in TARGETS:
            last_idx[k] = i
    keep = set(last_idx.values())

    out = []
    removed = 0
    for i, line in enumerate(lines):
        k = key_of(line)
        if k in TARGETS and i not in keep:
            removed += 1
            continue
        out.append(line)

    PATH.write_text("".join(out), encoding="utf-8")
    print(f"removed {removed} duplicate/leaked meta line(s) from {PATH}")


if __name__ == "__main__":
    main()
