---
name: cursor-skill-foundation
description: Create or improve Cursor-ready skills, rules, and expertises for a project. Use when a user wants to author a new SKILL.md, merge several overlapping skills into one stronger workflow, migrate lesson guidance into a reusable agent skill, or decide whether something should be a skill, a Cursor rule, or an ASM expertise.
---

# Cursor Skill Foundation

## Overview

Build course-quality skills that are easy to trigger, concise in context, and practical in real projects. This is the meta-agent for turning knowledge into reusable agent behavior.

## Decide the right artifact

Choose the smallest artifact that solves the problem:

| Need | Use | Example |
|------|-----|---------|
| Always-on project conventions | Cursor rule in `.cursor/rules/*.mdc` | Lint config, import order, naming |
| Reusable multi-step workflow | Skill folder with `SKILL.md` | PRD agent, debug agent, test agent |
| Bundle of several installed skills | ASM expertise | "Full-stack dev" combining 4 skills |
| One-off instruction for a single chat | Plain prompt in chat | "Refactor this function" |

If the workflow needs examples, checklists, or repeated steps across projects, prefer a **skill**.

## Course defaults

- Cursor project rules live in `.cursor/rules/*.mdc`
- `.cursorrules` is legacy; keep only for compatibility
- Skill bundles are grouped with ASM via `asm create expertise ...`
- Read [references/course-defaults.md](references/course-defaults.md) for the short decision list

## Workflow

### 1. Define the job precisely

Before writing anything, answer:

- What job does the agent perform?
- What input does it expect (file, diff, idea, error)?
- What output must it produce (doc, code, report)?
- What phrases should trigger it?
- What is explicitly out of scope?

Write one sentence in this pattern:

`This skill helps the agent [do X] when the user asks for [Y/Z] and should not be used for [A].`

### 2. Design for triggers, not prose

The frontmatter `description` is the trigger surface. Pack it with:

- What the skill does (verb-first)
- When to use it (contexts)
- Common user phrases and synonyms
- Key artifacts or file types involved

Strong trigger terms:

- Domain: `PRD`, `architecture`, `test cases`, `debug`, `SQLite`, `design system`, `security`, `code review`
- Actions: `create`, `improve`, `review`, `plan`, `refactor`, `implement`, `ship`

Do not hide trigger terms only in the body.

### 3. Structure the body for execution

Put only the reusable workflow in `SKILL.md`. Use this skeleton:

1. **Gather first** — what the agent must confirm before acting
2. **Workflow** — numbered steps with decision points
3. **Output** — exact deliverable shape (template or format)
4. **Quality checks** — pass/fail criteria
5. **Common mistakes** — top 3-5 failure modes

Rules for the body:

- Decision rules over background explanations
- Checklists over paragraphs
- Concrete output templates over vague guidance
- Failure modes the model actually hits, not theoretical warnings
- Max ~120 lines for the whole file; if longer, move reference material to `references/`

### 4. Merge overlapping skills into one stronger skill

When several source skills cover the same domain:

1. Keep the best workflow (fewest steps, clearest decisions)
2. Keep the strongest checklist (most actionable gates)
3. Keep the clearest output template (most concrete shape)
4. Add unique techniques from each source (specific tools, patterns, frameworks)
5. Remove tool-, repo-, or vendor-specific noise
6. Rewrite for the learner's level, not the original repo

Result: one course-native skill stronger than three fragmented upstream ones.

### 5. Package for real student use

Every finished skill must answer:

- What should the agent ask first?
- What does it produce?
- What does "done" look like?
- What mistakes does it guard against?
- What specific tools or frameworks does it default to?
- **What language should the agent use?** Every skill must include a `## Language` section instructing the agent to detect the user's language from the first message and use it for all questions and output. If the language is unclear, ask once before proceeding.

If a student can drop the skill into any project and immediately use it, the skill is ready.

## Recommended structure

```text
skill-name/
  SKILL.md              # Main workflow (≤120 lines)
  references/           # Deep detail, checklists, examples
  assets/               # Templates, starter files
  scripts/              # Scaffolding helpers
```

## Quality checklist

Before finishing a skill, verify:

- [ ] `name` is short, hyphenated, and specific
- [ ] `description` says both **what** and **when**, includes trigger phrases
- [ ] Body is concise and procedural (no essays)
- [ ] One clear output shape with a concrete template
- [ ] Specific framework/tool defaults are stated (not "pick any")
- [ ] Usable without reading sibling files
- [ ] Repo-specific assumptions removed or labeled
- [ ] Gather-first section prevents premature action
- [ ] Common mistakes list reflects real agent failure modes
- [ ] `## Language` section present — agent detects user language and asks once if unclear

## Common mistakes

- Writing a mini-essay instead of a workflow
- Listing many optional paths without a default
- Hiding trigger terms outside frontmatter
- Copying upstream repo paths that don't exist in the student's project
- Turning a one-time prompt into a full skill
- Leaving framework choices vague ("use a testing library") instead of specific ("use Vitest for unit, Playwright for E2E")

## Output

When creating or improving a skill, produce:

1. A final `name` (hyphenated, specific)
2. A final trigger-rich `description` (what + when + user phrases)
3. A short workflow with numbered steps and decision points
4. A concrete output shape with markdown template
5. Framework/tool defaults stated explicitly
6. A short list of mistakes to avoid
