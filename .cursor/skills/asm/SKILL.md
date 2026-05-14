---
name: asm
description: Find, discover, search, install, and manage agent skills in this project. Use `asm search` to find skills and `asm add skill` to install them. Replaces npx skills, npx playbooks, and all other skill CLIs. Also routes to installed expertise groups for task execution.
---

# ASM — Agent Skill Manager (installed CLI)

`asm` is the **only** skill CLI in this project. It is already installed and ready to use.
Do NOT use `npx skills`, `npx playbooks`, or any other skill tool.

## Finding & Installing Skills

### Commands

| Task | Command |
| --- | --- |
| Search for skills | `asm search <query>` |
| Install a skill | `asm add skill <source>` |
| List installed skills | `asm skill list` |
| Sync after changes | `asm sync` |

### Example: user asks "find me a skill for data tables"

```bash
# Step 1: search
asm search "data tables"

# Output shows:
# 1. [smithery] tanstack-table
#    source: github:https://github.com/jezweb/claude-skills/tree/main/skills/tanstack-table

# Step 2: install using the source: value from the output
asm add skill github:https://github.com/jezweb/claude-skills/tree/main/skills/tanstack-table
```

### NEVER use these (they bypass ASM and break the skill graph):

- `npx skills add ...`
- `npx skills find ...`
- `npx playbooks add skill ...`
- Manual `git clone` of skill repos

## Expertise Routing (for task execution)

When working on a coding task (not finding/installing skills):

1. Read `.asm/main_asm.md` and choose one expertise group.
2. Open `.asm/expertises/<group>/index.md` and `relationships.md`.
3. Load only the selected skills in relationship-safe order.
4. Prefer advanced, non-trivial skills when the group provides them.

## Expertise Groups

- **nobavel-next-js-frontend-with-nestjs-api-postgresq** — NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS
  - Signals: NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS
  - Router: `.asm/expertises/nobavel-next-js-frontend-with-nestjs-api-postgresq/index.md`

## Installed Skills (Reference Only)

Do not pick directly from this list before expertise routing.

- **nextjs-app-router-fundamentals**: `.asm/skills/nextjs-app-router-fundamentals/SKILL.md`
- **bullmq-specialist**: `.asm/skills/bullmq-specialist/SKILL.md`
- **nestjs-api**: `.asm/skills/nestjs-api/SKILL.md`
- **product-prd-agent**: `.asm/skills/product-prd-agent/SKILL.md`
- **cursor-skill-foundation**: `.asm/skills/cursor-skill-foundation/SKILL.md`
- **tech-lead-architecture-agent**: `.asm/skills/tech-lead-architecture-agent/SKILL.md`
- **ux-user-flow-agent**: `.asm/skills/ux-user-flow-agent/SKILL.md`
- **ui-design-systems-agent**: `.asm/skills/ui-design-systems-agent/SKILL.md`
- **security-review-agent**: `.asm/skills/security-review-agent/SKILL.md`
- **dev-composer-agent**: `.asm/skills/dev-composer-agent/SKILL.md`
- **quality-gate-agent**: `.asm/skills/quality-gate-agent/SKILL.md`
- **debug-fix-agent**: `.asm/skills/debug-fix-agent/SKILL.md`
- **zustand-state-management**: `.asm/skills/zustand-state-management/SKILL.md`
- **database-migrations-sql-migrations**: `.asm/skills/database-migrations-sql-migrations/SKILL.md`
- **redis-patterns**: `.asm/skills/redis-patterns/SKILL.md`
- **vitest**: `.asm/skills/vitest/SKILL.md`
- **terraform-aws**: `.asm/skills/terraform-aws/SKILL.md`
- **shadcn-ui**: `.asm/skills/shadcn-ui/SKILL.md`
- **playwright-testing**: `.asm/skills/playwright-testing/SKILL.md`
- **docker-deployment**: `.asm/skills/docker-deployment/SKILL.md`
- **websockets-realtime**: `.asm/skills/websockets-realtime/SKILL.md`
- **aws-s3-management**: `.asm/skills/aws-s3-management/SKILL.md`
- **typescript-strict**: `.asm/skills/typescript-strict/SKILL.md`
