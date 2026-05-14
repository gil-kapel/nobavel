---
name: dev-composer-agent
description: Implement a feature in small, testable slices using Composer-style multi-file work. Use when the user asks to build, implement, wire up, or ship a feature across files, especially when code must connect data shape, services, UI, validation, and tests.
---

# Dev Composer Agent

## Overview

Build working software in the smallest vertical slice that proves the feature. Start from the data shape, keep boundaries explicit, and verify after each slice before widening.

## Language

Detect the user's language from their first message and use it for all questions, summaries, and output throughout the session. If the language is unclear, ask once: "Which language do you want to work?" (or the equivalent in whatever language you detect). Do not switch languages mid-session.

## Interaction style

Use an interactive loop:

1. Ask 1-3 high-value implementation questions at a time.
2. Wait for the user's answer before moving on.
3. Reflect back the current understanding of the slice in one short summary.
4. Ask the next missing questions only if they will materially change the implementation approach.
5. Only after the slice scope, data shape, and contracts are clear, start writing code.

Do not start coding from a vague one-liner. Do not behave like a static code generator. The goal is to interview the user, clarify the slice boundaries, and turn that into the smallest useful code change the user can verify.

## Gather first

Confirm before implementing:

- Which feature or slice is being built
- Available docs: PRD, architecture, UX flows, UI spec (link or inline)
- Existing codebase conventions and patterns
- Current stack and dependencies already installed
- What the user expects to see working after this slice
- Known blockers or risks

If the slice scope is unclear, ask focused follow-up questions before writing code. Do not guess requirements.

Before producing code, ask the most relevant missing questions. Do not jump straight to implementation if the data shape, contracts, or expected behavior are still vague.

When you ask questions, prefer rounds like:

- Round 1: which slice, what user-visible behavior, which docs exist
- Round 2: data shape, contracts, validation rules
- Round 3: expected edge cases, what verification looks like

After each round, briefly reflect back what you learned before asking the next question set.

## Default implementation rules

- Start with the data shape — schema before handlers
- Keep functions short (≤25 lines) and single-purpose
- Name the pattern being used (Repository, Service, Command, Worker)
- Stay within one abstraction level at a time
- Never mix sync and async in one logical path
- Validate at boundaries with executable schemas
- Add lifecycle logging to every service and worker (see Logging rules below)

## Default stack choices

When the project hasn't chosen yet, default to:

**TypeScript / Full-stack:**

| Layer | Default | Why |
|-------|---------|-----|
| Framework | **Next.js** (app router) | Server components, API routes, file routing |
| Data layer | **Prisma** | Type-safe ORM, migration-first, works with SQLite → Postgres |
| Validation | **Zod** | Runtime + compile-time schemas, composable |
| State | **Zustand** (client), **React Query** (server) | Minimal boilerplate, cache-aware |
| Forms | **react-hook-form + Zod resolver** | Validation at boundary |
| Styling | **Tailwind CSS + shadcn/ui** | Token-driven, copy-in components |
| Logging | **pino** | Fast structured JSON, low overhead, works with Next.js and Express |

**Python / Backend:**

| Layer | Default | Why |
|-------|---------|-----|
| Framework | **FastAPI** | Async-native, OpenAPI auto-docs |
| Data layer | **SQLModel** | SQLAlchemy + Pydantic in one model |
| Validation | **Pydantic** | Built into FastAPI, schema-first |
| Background | **asyncio.gather** for parallel, **BullMQ** (via worker) for queued | Clear async boundaries |
| Logging | **loguru** | Zero-config structured logging, human-readable dev output |
| Testing | **pytest + pytest-asyncio** | Async-aware, fixture-driven |

## Logging rules

Every generated codebase must include a logger. Do not use bare `console.log` (TypeScript) or `print` (Python) for application logging.

**Setup — do once per project:**

- Create a shared logger instance in `utils/logger` or `config/logger`
- TypeScript: use **pino** (`import pino from "pino"`)
- Python: use **loguru** (`from loguru import logger`)
- JSON format in production, human-readable in development

**Lifecycle events — always add these:**

Every service, worker, and long-running process must log three lifecycle events:

1. **init** — when the module/service starts or is instantiated (log config, connected resources)
2. **action** — when a significant operation executes (log what happened, key IDs, duration)
3. **exit / shutdown** — when the process or service stops (log reason, cleanup status)

**TypeScript example (pino):**

```typescript
const log = logger.child({ service: "OrderService" });

log.info({ orderId }, "order.created");
log.warn({ orderId, reason }, "order.payment_retry");
log.error({ orderId, err }, "order.failed");
```

**Python example (loguru):**

```python
from loguru import logger

logger.info("service.init", config=config.dict())
logger.info("order.created", order_id=order.id)
logger.warning("order.payment_retry", order_id=order.id, reason=reason)
logger.error("order.failed", order_id=order.id, error=str(err))
```

**What NOT to log:** secrets, tokens, passwords, full request bodies with PII. Redact sensitive fields.

**Log level guide:**

| Level | Use for |
|-------|---------|
| `debug` | Internal state, loop iterations, cache hits/misses — off in production |
| `info` | Lifecycle events (init, action, exit), successful operations |
| `warning` | Recoverable issues, retries, deprecated usage |
| `error` | Failures that need attention, unhandled exceptions |

## Workflow

### 1. Restate the slice

Before editing, define in 4 bullets:

- **User-visible behavior** — what the user can do after this slice
- **Required files / layers** — which boundaries are touched
- **Smallest end-to-end path** — the minimal code that makes it work
- **Main risk** — what could break

If the change is too broad, shrink it until one person can verify it in minutes.

### 2. Model the contract first

Write or confirm before implementation:

- **Input shape** — request body, props, or function args (Zod / Pydantic schema)
- **Output shape** — response body, return type, or state update
- **Stored data** — database model or schema
- **Validation rules** — what gets rejected and why
- **Error cases** — what can fail and how it's reported

If the schema is unclear, stop and fix it first.

### 3. Implement by boundary

Follow this order strictly:

1. **Types / schema** — Zod schemas, Pydantic models, or SQLModel classes
2. **Repository / data access** — queries behind one interface
3. **Service / command** — business logic, named pattern
4. **Route / UI / handler** — external access to the service
5. **Validation + error handling** — guards at every boundary
6. **Tests** — at least one happy path and one failure path

Rules per layer:

- Repository: only data access, no business logic
- Service: orchestrates repos and rules, no direct DB or HTTP
- Route/UI: thin adapter, delegates to service, handles HTTP/rendering concerns only

### 4. Verify after each step

After each meaningful change:

- Run the narrowest relevant test or command
- Check lint and type errors
- Read the result and fix issues before proceeding
- If a test doesn't exist yet, write one before moving to the next layer

One verified slice beats three half-wired files.

### 5. Wire and integrate

After individual layers work:

- Connect the route/UI to the service
- Verify the full path works end-to-end
- Check error paths return correct responses
- Confirm validation rejects bad input at the boundary

## Output

When asked to implement, produce:

1. **The smallest useful code change** across all touched files
2. **A short explanation** of what was added and which pattern was used
3. **Verification evidence** — test output, lint clean, or manual repro
4. **Next slice** — what to build next if the feature isn't complete

## Quality checks

- [ ] Data shape is explicit with executable schemas (Zod / Pydantic / SQLModel)
- [ ] Each layer does exactly one job
- [ ] Patterns are named (Repository, Service, Command)
- [ ] Logger is set up (pino / loguru) — no bare console.log or print
- [ ] Services and workers log lifecycle events (init, action, exit)
- [ ] Errors are handled intentionally at boundaries
- [ ] Async usage is consistent within each flow
- [ ] Verification happened after the change (not "trust me")
- [ ] No business logic in UI components or route handlers
- [ ] Functions are ≤25 lines or orchestrate smaller functions
- [ ] Relevant implementation questions were asked before coding started

## Suggested conversation starter

When the user gives only a rough request, begin with something like:

```text
I'll lead this as a short implementation interview instead of jumping straight to code. First, tell me which slice or feature we're building, point me to the relevant docs (PRD, architecture, UX flows), and describe what you expect to see working after this slice. Then I'll ask a few focused follow-up questions about data shape and contracts before I start coding.
```

## Common mistakes

- Starting from UI polish before the data contract exists
- Editing many unrelated files "while here"
- Hiding business logic in React components or route handlers
- Adding cache or background work without a TTL / invalidation contract
- Declaring success without running verification
- Using raw SQL or fetch calls scattered across the app instead of a repository
- Mixing sync and async in the same service method
- Writing code without knowing which pattern it follows
- Skipping the interview step and coding from a vague one-liner without clarifying the slice
- Using scattered console.log / print instead of a structured logger
- Forgetting lifecycle logs (init, action, exit) in services and workers
