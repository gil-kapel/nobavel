# ASM — Agent Skill Manager (installed CLI)

> Project: **NoBavel** v0.1.0

`asm` is installed and is the **only** skill CLI for this project.
Do NOT use `npx skills`, `npx playbooks`, or any other skill tool.

## Finding & Installing Skills

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

# Step 2: install using the source: value
asm add skill github:https://github.com/jezweb/claude-skills/tree/main/skills/tanstack-table
```

NEVER use: `npx skills add`, `npx skills find`, `npx playbooks add skill`, or manual git clone.

## Expertise Routing (for task execution)

1. Select one expertise group using the routing rubric below.
2. Open the group index and relationships docs before loading any skill.
3. Prefer advanced, non-trivial skills when available.
4. Load only the selected skills with the right dependency order.

## Expertise Group Router

| Group | Purpose | Task signals | Advanced-first | Navigation |
| --- | --- | --- | --- | --- |
| `nobavel-next-js-frontend-with-nestjs-api-postgresq` | NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS | NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS | yes | `.asm/expertises/nobavel-next-js-frontend-with-nestjs-api-postgresq/index.md` |

## Selection Rubric

1. Match task intent to expertise intent tags and task signals.
2. If multiple groups match, choose the one with stronger advanced skill coverage.
3. Respect each group's `relationships.md` before skill loading.
4. Do not route directly to a skill before selecting a group.

## Active Expertises

### nobavel-next-js-frontend-with-nestjs-api-postgresq

NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS

- Intent tags: nobavel next js frontend with nestjs api postgresq, expertise routing
- Task signals: NoBavel: Next.js frontend with NestJS API, PostgreSQL, Redis, BullMQ workers, WebSockets, Autodesk APS viewer, strict TypeScript, Docker on AWS
- Confidence hint: Use when task signals strongly match this domain vocabulary.
- Navigation: `.asm/expertises/nobavel-next-js-frontend-with-nestjs-api-postgresq/index.md`
- Relationships: `.asm/expertises/nobavel-next-js-frontend-with-nestjs-api-postgresq/relationships.md`
- Required skills: nextjs-app-router-fundamentals, bullmq-specialist, nestjs-api

## Installed Skills

- **nextjs-app-router-fundamentals**: `.asm/skills/nextjs-app-router-fundamentals/SKILL.md`
  Source: `skills.sh:https://skills.sh/wsimmonds/claude-nextjs-skills/nextjs-app-router-fundamentals`
- **bullmq-specialist**: `.asm/skills/bullmq-specialist/SKILL.md`
  Source: `github:https://github.com/davila7/claude-code-templates/tree/main/cli-tool/components/skills/development/bullmq-specialist`
- **nestjs-api**: `.asm/skills/nestjs-api/SKILL.md`
  Source: `github:https://github.com/Survikrowa/Game-Critique/tree/main/.github/skills/nestjs-api`
- **product-prd-agent**: `.asm/skills/product-prd-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.2-product-agent-prd/product-prd-agent`
- **cursor-skill-foundation**: `.asm/skills/cursor-skill-foundation/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.1-skills-agents-asm/cursor-skill-foundation`
- **tech-lead-architecture-agent**: `.asm/skills/tech-lead-architecture-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.3-tech-lead-architecture/tech-lead-architecture-agent`
- **ux-user-flow-agent**: `.asm/skills/ux-user-flow-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.4-ux-user-flow/ux-user-flow-agent`
- **ui-design-systems-agent**: `.asm/skills/ui-design-systems-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.5-ui-design-systems/ui-design-systems-agent`
- **security-review-agent**: `.asm/skills/security-review-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.6-security-agent/security-review-agent`
- **dev-composer-agent**: `.asm/skills/dev-composer-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.7-dev-agent-composer/dev-composer-agent`
- **quality-gate-agent**: `.asm/skills/quality-gate-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.8-quality-gate-agent/quality-gate-agent`
- **debug-fix-agent**: `.asm/skills/debug-fix-agent/SKILL.md`
  Source: `github:https://github.com/gil-kapel/cursor-course-skills/tree/main/module-02-skills-and-agents/lesson-2.9-debug-agent/debug-fix-agent`
- **zustand-state-management**: `.asm/skills/zustand-state-management/SKILL.md`
  Source: `skills.sh:https://skills.sh/mindrally/skills/zustand-state-management`
- **database-migrations-sql-migrations**: `.asm/skills/database-migrations-sql-migrations/SKILL.md`
  Source: `github:https://github.com/sickn33/antigravity-awesome-skills/tree/main/skills/database-migrations-sql-migrations`
- **redis-patterns**: `.asm/skills/redis-patterns/SKILL.md`
  Source: `github:https://github.com/patricio0312rev/skills/tree/main/performance/redis-patterns`
- **vitest**: `.asm/skills/vitest/SKILL.md`
  Source: `github:https://github.com/sanity-io/next-sanity/tree/main/.agents/skills/vitest`
- **terraform-aws**: `.asm/skills/terraform-aws/SKILL.md`
  Source: `github:https://github.com/pluginagentmarketplace/custom-plugin-terraform/tree/main/skills/terraform-aws`
- **shadcn-ui**: `.asm/skills/shadcn-ui/SKILL.md`
  Source: `github:https://github.com/google-labs-code/stitch-skills/tree/main/skills/shadcn-ui`
- **playwright-testing**: `.asm/skills/playwright-testing/SKILL.md`
  Source: `github:https://github.com/laurigates/claude-plugins/tree/main/testing-plugin/skills/playwright-testing`
- **docker-deployment**: `.asm/skills/docker-deployment/SKILL.md`
  Source: `github:https://github.com/pluginagentmarketplace/custom-plugin-nodejs/tree/main/skills/docker-deployment`
- **websockets-realtime**: `.asm/skills/websockets-realtime/SKILL.md`
  Source: `github:https://github.com/travisjneuman/.claude/tree/main/skills/websockets-realtime`
- **aws-s3-management**: `.asm/skills/aws-s3-management/SKILL.md`
  Source: `github:https://github.com/aj-geddes/useful-ai-prompts/tree/main/skills/aws-s3-management`
- **typescript-strict**: `.asm/skills/typescript-strict/SKILL.md`
  Source: `github:https://github.com/citypaul/.dotfiles/tree/main/claude/.claude/skills/typescript-strict`
