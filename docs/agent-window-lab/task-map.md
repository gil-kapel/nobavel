# Standup Pulse — Agent Window multitask lab

**Project:** Standup Pulse — a static prototype for a tiny team standup tool (no backend, no build step).

**Lab goal:** Show why **multitask** saves time: three agents can each own one screen, ship in parallel, and merge without touching the same file.

**Rules for every build task:**

- Write **only** the assigned HTML file (no shared components file, no edits to this map mid-build).
- **Inline CSS only** (`<style>` in the same file or `style=""` on elements).
- **No external assets** (no images, fonts, CDNs, or `src`/`href` to third-party URLs).
- Optional: plain-text links between pages using **relative paths** (`board.html`, `home.html`, `report.html`) are fine because each agent only *creates* their file; if you add nav links, coordinate copy in chat or accept that links may be added in a follow-up pass—**default for parallel speed: skip cross-links** until a fourth “integration” pass, or add only links *from* your page *to* others without editing those other files.

---

## Why these three screens can be built in parallel

Each task maps to **one unique output path**. There is no shared stylesheet, no shared partial, and no single “app shell” that all three must edit. Agent A never writes `board.html` or `report.html`; B and C never write `home.html`. Git merges and Cursor multitask assignments stay conflict-free because **the write sets are disjoint**.

---

## Task 1 — Homepage

| Field | Detail |
|--------|--------|
| **Assigned output file** | `docs/agent-window-lab/standup-pulse/home.html` |
| **User story** | As a team member, I want a welcoming entry point so I understand what Standup Pulse is and where to go next (daily standup vs weekly reflection). |
| **Visual sections to include** | 1) App name + one-line value prop. 2) Two “cards” or panels describing *Daily board* and *Weekly report* (placeholder descriptions only—no need to match other files’ exact copy). 3) Simple primary/secondary actions styled as buttons (can be `<a>` styled as buttons to `board.html` / `report.html` if desired, without editing those files). 4) Footer note that this is a static prototype. |
| **Visible success signal** | Opening `home.html` in a browser shows a clear hero, two distinct feature areas, and visibly styled CTAs; everything renders with **no network requests** for assets (View Source confirms inline CSS only). |

---

## Task 2 — Daily board

| Field | Detail |
|--------|--------|
| **Assigned output file** | `docs/agent-window-lab/standup-pulse/board.html` |
| **User story** | As a team member, I want a daily standup board so I can see yesterday, today, and blockers for myself and teammates at a glance. |
| **Visual sections to include** | 1) Page title “Daily board” + date line (static fake date is fine). 2) Column or card layout for **Yesterday / Today / Blockers** per person—use **3–4 fake names** with short placeholder text. 3) A “quick add” row or textarea (non-functional, visual only). 4) Optional link back to `home.html` only if implemented without editing `home.html`. |
| **Visible success signal** | The page clearly reads as a standup grid or columns; fake teammate rows are visually scannable; **all styling is in-file**; no external resources load. |

---

## Task 3 — Weekly report

| Field | Detail |
|--------|--------|
| **Assigned output file** | `docs/agent-window-lab/standup-pulse/report.html` |
| **User story** | As a lead or teammate, I want a weekly summary view so I can scan completion trends and highlights without opening every daily card. |
| **Visual sections to include** | 1) Title “Weekly report” + week range (static). 2) Summary strip (e.g. fake metrics: “5/5 days logged”, “2 blockers cleared”—numbers can be invented). 3) List or table of **3–5 bullet highlights** (static text). 4) Simple bar or row visualization using **CSS only** (e.g. `div` widths as percentages—no charts library). 5) Optional link to `home.html` without editing other tasks’ files. |
| **Visible success signal** | A reader immediately sees “week in review” with at least one CSS-only chart/mock chart; **no external scripts or images**; inline CSS only. |

---

## File conflict matrix (multitask safety)

| Output path | Agent / task |
|-------------|----------------|
| `docs/agent-window-lab/standup-pulse/home.html` | Task 1 only |
| `docs/agent-window-lab/standup-pulse/board.html` | Task 2 only |
| `docs/agent-window-lab/standup-pulse/report.html` | Task 3 only |

No path appears in more than one row — **safe to assign three separate agents with zero file overlap**.
