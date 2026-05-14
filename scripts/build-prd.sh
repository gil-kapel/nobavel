#!/usr/bin/env bash
# Render docs/prd.md to docs/prd.html (local preview) and site/index.html (GitHub Pages).
# Both targets receive identical output. Re-run after editing docs/prd.md.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/docs/prd.md"
TARGETS=("$ROOT/docs/prd.html" "$ROOT/site/index.html")

if [[ ! -f "$SRC" ]]; then
  echo "error: source markdown not found at $SRC" >&2
  exit 1
fi

if grep -q '</script>' "$SRC"; then
  echo "error: $SRC contains '</script>' which would break inline embed" >&2
  exit 1
fi

TMP="$(mktemp -t prd-build.XXXXXX)"
trap 'rm -f "$TMP"' EXIT

cat > "$TMP" << 'HTMLHEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PRD · NoBavel MVP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --fg: #0f172a;
    --fg-soft: #334155;
    --muted: #64748b;
    --bg: #ffffff;
    --bg-soft: #f8fafc;
    --accent: #2563eb;
    --accent-soft: #dbeafe;
    --border: #e2e8f0;
    --border-strong: #cbd5e1;
    --code-bg: #f1f5f9;
    --code-fg: #0f172a;
    --critical-bg: #fee2e2;
    --critical-fg: #991b1b;
    --critical-bd: #fca5a5;
    --high-bg: #ffedd5;
    --high-fg: #9a3412;
    --high-bd: #fdba74;
    --medium-bg: #fef9c3;
    --medium-fg: #854d0e;
    --medium-bd: #fde047;
    --good-bg: #dcfce7;
    --good-fg: #166534;
    --header-h: 60px;
    --sidebar-w: 280px;
  }
  @media (prefers-color-scheme: dark) {
    :root {
      --fg: #e2e8f0;
      --fg-soft: #cbd5e1;
      --muted: #94a3b8;
      --bg: #0b1220;
      --bg-soft: #111a2e;
      --accent: #60a5fa;
      --accent-soft: #1e3a8a;
      --border: #1e293b;
      --border-strong: #334155;
      --code-bg: #111a2e;
      --code-fg: #e2e8f0;
      --critical-bg: #450a0a;
      --critical-fg: #fecaca;
      --critical-bd: #7f1d1d;
      --high-bg: #431407;
      --high-fg: #fed7aa;
      --high-bd: #7c2d12;
      --medium-bg: #422006;
      --medium-fg: #fde68a;
      --medium-bd: #713f12;
      --good-bg: #052e16;
      --good-fg: #bbf7d0;
    }
  }
  * { box-sizing: border-box; }
  html { scroll-behavior: smooth; }
  body {
    margin: 0;
    background: var(--bg);
    color: var(--fg);
    font-family: "Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", system-ui, sans-serif;
    font-size: 16px;
    line-height: 1.7;
    -webkit-font-smoothing: antialiased;
    text-rendering: optimizeLegibility;
  }
  .topbar {
    position: sticky; top: 0; z-index: 50;
    height: var(--header-h);
    display: flex; align-items: center; gap: 16px;
    padding: 0 24px;
    background: rgba(255,255,255,0.85);
    backdrop-filter: saturate(180%) blur(10px);
    -webkit-backdrop-filter: saturate(180%) blur(10px);
    border-bottom: 1px solid var(--border);
  }
  @media (prefers-color-scheme: dark) { .topbar { background: rgba(11,18,32,0.85); } }
  .topbar .brand { font-weight: 700; font-size: 15px; letter-spacing: -0.01em; color: var(--fg); }
  .topbar .brand::before { content: "■"; color: var(--accent); margin-right: 8px; }
  .topbar .doc-title { font-size: 14px; color: var(--muted); font-weight: 500; }
  .topbar .spacer { flex: 1; }
  .pill {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 3px 10px; border-radius: 999px;
    font-size: 12px; font-weight: 600; letter-spacing: 0.01em;
    border: 1px solid var(--border-strong);
    background: var(--bg-soft); color: var(--fg-soft);
  }
  .pill.status-draft { background: var(--medium-bg); color: var(--medium-fg); border-color: var(--medium-bd); }
  .pill.version { background: var(--accent-soft); color: var(--accent); border-color: var(--accent); }
  .topbar button {
    font: inherit; font-size: 13px; font-weight: 500;
    padding: 6px 12px;
    border: 1px solid var(--border-strong);
    background: var(--bg-soft); color: var(--fg-soft);
    border-radius: 6px; cursor: pointer;
    transition: background 0.15s, color 0.15s;
  }
  .topbar button:hover { background: var(--accent); color: white; border-color: var(--accent); }
  .layout {
    display: grid;
    grid-template-columns: var(--sidebar-w) 1fr;
    max-width: 1320px; margin: 0 auto;
  }
  aside.sidebar {
    position: sticky; top: var(--header-h); align-self: start;
    height: calc(100vh - var(--header-h));
    overflow-y: auto;
    border-right: 1px solid var(--border);
    padding: 32px 12px 32px 24px;
    font-size: 13.5px;
  }
  aside.sidebar h4 {
    margin: 0 0 12px; font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: 0.08em; color: var(--muted);
  }
  aside.sidebar nav { display: flex; flex-direction: column; gap: 1px; }
  aside.sidebar a {
    display: block; padding: 5px 10px;
    border-left: 2px solid transparent;
    color: var(--fg-soft); text-decoration: none;
    border-radius: 0 4px 4px 0; line-height: 1.4;
    transition: color 0.1s, background 0.1s, border-color 0.1s;
  }
  aside.sidebar a:hover { color: var(--accent); background: var(--bg-soft); }
  aside.sidebar a.h3 { padding-left: 22px; font-size: 13px; color: var(--muted); }
  aside.sidebar a.active {
    color: var(--accent); border-left-color: var(--accent);
    font-weight: 600; background: var(--accent-soft);
  }
  aside.sidebar a.h3.active { font-weight: 500; }
  main { padding: 48px 56px 120px; min-width: 0; }
  article { max-width: 760px; margin: 0 auto; }
  .doc-meta-block {
    display: flex; flex-wrap: wrap; gap: 8px 16px; align-items: center;
    margin: 0 0 32px; padding: 12px 16px;
    background: var(--bg-soft); border: 1px solid var(--border); border-radius: 10px;
    font-size: 13px; color: var(--muted);
  }
  .doc-meta-block strong { color: var(--fg-soft); font-weight: 600; }
  .doc-meta-block .sep { color: var(--border-strong); }
  article h1, article h2, article h3, article h4 {
    font-family: "Inter", system-ui, sans-serif;
    color: var(--fg); letter-spacing: -0.015em;
    font-weight: 700; line-height: 1.25;
    scroll-margin-top: calc(var(--header-h) + 16px);
  }
  article h1 { font-size: 36px; margin: 0 0 16px; letter-spacing: -0.025em; }
  article h2 {
    font-size: 24px; margin: 56px 0 16px;
    padding-top: 12px; border-top: 1px solid var(--border);
  }
  article h2:first-of-type { border-top: none; padding-top: 0; }
  article h3 { font-size: 18px; margin: 32px 0 12px; }
  article h4 { font-size: 15px; margin: 24px 0 8px; color: var(--fg-soft); }
  article p { margin: 0 0 16px; color: var(--fg-soft); }
  article ul, article ol { margin: 0 0 16px; padding-left: 24px; color: var(--fg-soft); }
  article li { margin: 4px 0; }
  article li > p { margin: 4px 0; }
  article a { color: var(--accent); text-decoration: none; }
  article a:hover { text-decoration: underline; }
  article strong { color: var(--fg); font-weight: 600; }
  .anchor-link {
    opacity: 0; margin-left: 8px;
    font-size: 0.75em; font-weight: 400;
    color: var(--muted); text-decoration: none;
    transition: opacity 0.15s;
  }
  h2:hover .anchor-link, h3:hover .anchor-link { opacity: 1; }
  code {
    font-family: "JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, monospace;
    font-size: 0.88em;
    background: var(--code-bg); color: var(--code-fg);
    padding: 1px 6px; border-radius: 4px;
    border: 1px solid var(--border);
  }
  pre {
    background: var(--code-bg); border: 1px solid var(--border);
    padding: 14px 16px; border-radius: 8px;
    overflow-x: auto; margin: 16px 0;
  }
  pre code { background: transparent; padding: 0; border: none; }
  .table-wrap {
    overflow-x: auto; margin: 16px 0 24px;
    border: 1px solid var(--border); border-radius: 10px;
  }
  article table { border-collapse: collapse; width: 100%; font-size: 14px; line-height: 1.5; }
  article th, article td {
    padding: 10px 14px; text-align: left; vertical-align: top;
    border-bottom: 1px solid var(--border);
  }
  article tr:last-child td { border-bottom: none; }
  article th {
    background: var(--bg-soft); font-weight: 600;
    font-size: 12px; text-transform: uppercase; letter-spacing: 0.04em;
    color: var(--muted); border-bottom: 1px solid var(--border-strong);
  }
  article td { color: var(--fg-soft); }
  article td strong { color: var(--fg); }
  article tr:hover td { background: var(--bg-soft); }
  article td.tick { color: var(--good-fg); font-weight: 600; }
  article td.tick-named { color: var(--accent); font-weight: 500; }
  article td.dash { color: var(--muted); text-align: center; }
  .severity {
    display: inline-flex; align-items: center; gap: 5px;
    padding: 2px 9px; font-size: 11.5px; font-weight: 700;
    border-radius: 999px; border: 1px solid;
    text-transform: uppercase; letter-spacing: 0.04em;
    white-space: nowrap;
  }
  .severity::before {
    content: ""; width: 6px; height: 6px;
    border-radius: 50%; background: currentColor;
  }
  .severity-critical { background: var(--critical-bg); color: var(--critical-fg); border-color: var(--critical-bd); }
  .severity-high { background: var(--high-bg); color: var(--high-fg); border-color: var(--high-bd); }
  .severity-medium { background: var(--medium-bg); color: var(--medium-fg); border-color: var(--medium-bd); }
  ul.ac-list { list-style: none; padding: 0; }
  ul.ac-list li {
    position: relative;
    padding: 14px 16px 14px 18px; margin: 8px 0;
    background: var(--bg-soft); border: 1px solid var(--border);
    border-left: 3px solid var(--accent); border-radius: 8px;
  }
  article ol > li::marker { color: var(--accent); font-weight: 700; }
  blockquote {
    border-left: 4px solid var(--accent);
    margin: 16px 0; padding: 4px 16px;
    background: var(--bg-soft); border-radius: 0 8px 8px 0;
    color: var(--fg-soft);
  }
  blockquote p { margin: 8px 0; }
  .back-to-top {
    position: fixed; right: 24px; bottom: 24px;
    width: 40px; height: 40px; border-radius: 50%;
    background: var(--accent); color: white; border: none;
    cursor: pointer; box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    font-size: 18px;
    opacity: 0; pointer-events: none; transition: opacity 0.2s;
    z-index: 40;
  }
  .back-to-top.visible { opacity: 1; pointer-events: auto; }
  @media (max-width: 980px) {
    .layout { grid-template-columns: 1fr; }
    aside.sidebar {
      position: static; height: auto;
      border-right: none; border-bottom: 1px solid var(--border);
      padding: 16px 24px;
    }
    main { padding: 24px 24px 80px; }
    article h1 { font-size: 28px; }
    article h2 { font-size: 21px; }
  }
  @media print {
    :root { --bg: white; --fg: black; --fg-soft: #222; }
    .topbar, aside.sidebar, .back-to-top { display: none; }
    .layout { display: block; max-width: none; }
    main { padding: 0; }
    article { max-width: none; }
    article h2 { page-break-before: auto; break-before: auto; border-top: 2px solid #ddd; }
    article h2:first-of-type { border-top: none; }
    article table, .table-wrap { page-break-inside: avoid; break-inside: avoid; }
    .severity { border: 1px solid #999; background: white !important; color: black !important; }
    .severity::before { display: none; }
    a { color: black; text-decoration: underline; }
    a[href]::after { content: ""; }
  }
</style>
</head>
<body>
<div class="topbar">
  <div class="brand">NoBavel</div>
  <div class="doc-title">Product PRD</div>
  <span class="pill version">v0.1</span>
  <span class="pill status-draft">● Draft — for review</span>
  <div class="spacer"></div>
  <button onclick="window.print()" title="Print or save as PDF">Print / PDF</button>
</div>
<div class="layout">
  <aside class="sidebar">
    <h4>Contents</h4>
    <nav id="toc"></nav>
  </aside>
  <main>
    <article id="content"><p style="color: var(--muted);">Rendering…</p></article>
  </main>
</div>
<button class="back-to-top" id="backToTop" title="Back to top" onclick="window.scrollTo({top:0, behavior:'smooth'})">↑</button>
<script id="md" type="text/markdown">
HTMLHEAD

cat "$SRC" >> "$TMP"

cat >> "$TMP" << 'HTMLTAIL'
</script>
<script src="https://cdn.jsdelivr.net/npm/marked@12/marked.min.js"></script>
<script>
(function() {
  const article = document.getElementById('content');
  const src = document.getElementById('md').textContent;
  const wordCount = src.trim().split(/\s+/).length;
  const readingMin = Math.max(1, Math.round(wordCount / 220));
  const today = new Date().toISOString().slice(0, 10);
  marked.setOptions({ gfm: true, breaks: false });
  article.innerHTML = marked.parse(src);
  const h1 = article.querySelector('h1');
  if (h1) {
    const meta = document.createElement('div');
    meta.className = 'doc-meta-block';
    meta.innerHTML =
      '<span><strong>Owner</strong> · Product</span>' +
      '<span class="sep">·</span>' +
      '<span><strong>Status</strong> · Draft, interview-informed</span>' +
      '<span class="sep">·</span>' +
      '<span><strong>Last updated</strong> · ' + today + '</span>' +
      '<span class="sep">·</span>' +
      '<span><strong>~' + readingMin + ' min read</strong> · ' + wordCount.toLocaleString() + ' words</span>';
    h1.insertAdjacentElement('afterend', meta);
  }
  function slug(s) {
    return s.toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .replace(/^-|-$/g, '');
  }
  const usedIds = new Set();
  article.querySelectorAll('h2, h3').forEach(h => {
    let id = slug(h.textContent);
    let base = id, i = 1;
    while (usedIds.has(id)) { id = base + '-' + (++i); }
    usedIds.add(id);
    h.id = id;
    const a = document.createElement('a');
    a.href = '#' + id;
    a.className = 'anchor-link';
    a.textContent = '#';
    a.setAttribute('aria-label', 'Anchor to ' + h.textContent);
    h.appendChild(a);
  });
  article.querySelectorAll('table').forEach(t => {
    const wrap = document.createElement('div');
    wrap.className = 'table-wrap';
    t.parentNode.insertBefore(wrap, t);
    wrap.appendChild(t);
  });
  const SEVERITIES = { 'Critical': 'critical', 'High': 'high', 'Medium': 'medium' };
  article.querySelectorAll('td').forEach(td => {
    const t = td.textContent.trim();
    if (Object.prototype.hasOwnProperty.call(SEVERITIES, t)) {
      td.innerHTML = '<span class="severity severity-' + SEVERITIES[t] + '">' + t + '</span>';
    }
  });
  article.querySelectorAll('td').forEach(td => {
    const t = td.textContent.trim();
    if (t === '✓') td.classList.add('tick');
    else if (t.startsWith('✓') && t.toLowerCase().includes('if named')) td.classList.add('tick-named');
    else if (t === '—' || t === '-') td.classList.add('dash');
  });
  const acHeading = article.querySelector('h2#acceptance-criteria');
  if (acHeading) {
    let node = acHeading.nextElementSibling;
    while (node && node.tagName !== 'H2') {
      if (node.tagName === 'UL') node.classList.add('ac-list');
      node = node.nextElementSibling;
    }
  }
  const toc = document.getElementById('toc');
  article.querySelectorAll('h2, h3').forEach(h => {
    const a = document.createElement('a');
    a.href = '#' + h.id;
    a.className = h.tagName.toLowerCase();
    const clone = h.cloneNode(true);
    clone.querySelectorAll('.anchor-link').forEach(x => x.remove());
    a.textContent = clone.textContent.trim();
    a.dataset.target = h.id;
    toc.appendChild(a);
  });
  const tocLinks = Array.from(toc.querySelectorAll('a'));
  const linkById = new Map(tocLinks.map(a => [a.dataset.target, a]));
  const headings = Array.from(article.querySelectorAll('h2, h3'));
  function setActive(id) {
    tocLinks.forEach(a => a.classList.toggle('active', a.dataset.target === id));
    const active = linkById.get(id);
    if (active && toc.parentElement) {
      const r = active.getBoundingClientRect();
      const pr = toc.parentElement.getBoundingClientRect();
      if (r.top < pr.top + 40 || r.bottom > pr.bottom - 40) {
        active.scrollIntoView({ block: 'nearest' });
      }
    }
  }
  const headerOffset = 80;
  function onScroll() {
    let current = headings[0]?.id;
    for (const h of headings) {
      if (h.getBoundingClientRect().top - headerOffset <= 0) current = h.id;
      else break;
    }
    if (current) setActive(current);
    document.getElementById('backToTop').classList.toggle('visible', window.scrollY > 600);
  }
  document.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
  document.title = (h1 ? h1.firstChild.textContent.trim() : 'PRD') + ' · NoBavel';
})();
</script>
</body>
</html>
HTMLTAIL

for t in "${TARGETS[@]}"; do
  mkdir -p "$(dirname "$t")"
  cp "$TMP" "$t"
  echo "wrote $t ($(wc -l < "$t") lines)"
done
