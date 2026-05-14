# Course Defaults

Use these defaults when building course-native skills for Module 2.

## Cursor defaults

- Prefer `.cursor/rules/*.mdc` for project rules.
- Treat `.cursorrules` as legacy; only keep it if the project already uses it.
- Keep rules split by concern: `stack.mdc`, `api.mdc`, `tests.mdc`, etc.

## ASM defaults

- Search: `asm search "..."`
- Install: `asm add skill <source>`
- Bundle: `asm create expertise <name> <skill>... --desc "..."`
- Materialize: `asm sync`

## Naming defaults

- Skill names: lowercase hyphen-case
- One lesson = one strong course-native skill
- Avoid vendor names in the final skill unless they are part of the stack choice

## What “good” looks like

- Trigger-rich frontmatter description
- One clear workflow
- One clear output shape
- Minimal assumptions about the student repo
