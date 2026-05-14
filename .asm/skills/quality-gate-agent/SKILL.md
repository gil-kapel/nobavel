---
name: quality-gate-agent
description: Run a merge-ready quality gate by combining code review and QA in one flow. Use when the user asks for code review, QA checks, release readiness, test planning, or "what must be fixed before merge". Produces severity-ranked findings, a targeted test plan, and one high-value automated test.
---

# Quality Gate Agent

## Overview

Run one focused quality pass that links review findings directly to test priorities. Optimize for real risk reduction, not long generic reports.

## Language

Detect the user's language from their first message and use it for all questions, summaries, and output throughout the session. If the language is unclear, ask once: "Which language do you want to work?" (or the equivalent in whatever language you detect). Do not switch languages mid-session.

## Gather first

Before writing findings:

- Read the latest diff and list changed files
- Read acceptance criteria (`@docs/prd.md` if available)
- Read implementation intent (`@docs/implementation-plan.md` if available)
- Identify behavior changes, data paths, auth/permissions, and async flows
- Identify what tests already exist for changed paths

Ask questions only when a missing detail blocks accurate review.

## Workflow

### 1. Build a risk map from the change

For each changed area, tag risks:

- correctness/regression
- security/permissions
- data integrity/validation
- async/background behavior
- maintainability hotspots

### 2. Produce review findings first

Review in this order:

1. correctness and regressions
2. security and data exposure
3. data integrity and validation
4. missing tests on critical paths
5. maintainability and cleanup

Rules:

- Max 5 findings (highest signal only)
- Every finding must include evidence (`file:line`)
- No style-only nits unless they create real risk
- Do not suggest rewriting unchanged areas

### 3. Derive the QA plan from those findings

Translate findings + acceptance criteria into targeted tests:

- Critical/high findings -> must-have tests
- Medium findings -> should-have tests
- Low findings -> optional/manual checks

Each test case must reference either:

- a finding ID (`F-001`, `F-002`), or
- a requirement ID/criterion

### 4. Choose the cheapest effective test level

Use:

- unit for pure logic/rules
- integration for boundary wiring (service/repo/API)
- component for UI behavior and state changes
- e2e only for critical cross-page journeys

Do not push everything into e2e.

### 5. Write one automated test now

Pick the highest-risk unprotected behavior and implement one real test:

- Name it with the TC ID
- Assert observable behavior (not implementation detail)
- Keep scope narrow and runnable

### 6. End with merge gate

State clearly:

- what is blocking merge
- what can merge with follow-up
- what is verified by the added test

## Output

Use this structure:

```markdown
# Quality Gate Report: [Feature / PR]

## 1) Change summary
- What changed and why (2-3 bullets)

## 2) Findings (severity-ranked)
- F-001 [high] [title]
  - Evidence: path/to/file.ts:42
  - Why it matters: ...
  - Minimal fix: ...

## 3) Targeted test plan (derived from findings + requirements)
- TC-F-001 (maps: F-001) [level: integration]
  - Given / When / Then
- TC-REQ-002 (maps: AC-3) [level: component]
  - Given / When / Then

## 4) Automated test added now
- Test ID + file path
- What risk it covers
- Expected pass condition

## 5) Merge recommendation
- Blockers before merge
- Safe follow-ups after merge
- Most urgent next action
```

## Quality checks

- [ ] Findings are evidence-based (`file:line`)
- [ ] Most severe risks appear first
- [ ] Test cases map to findings or requirements
- [ ] Test level choice is justified by cost vs confidence
- [ ] At least one high-risk behavior is automated now
- [ ] Report ends with a clear merge decision

## Common mistakes

- Giving generic style feedback without risk evidence
- Writing a broad test plan disconnected from findings
- Suggesting large rewrites instead of minimal risk-reducing fixes
- Producing test names without runnable assertions
- Marking "looks good" without explicit merge blockers/follow-ups
