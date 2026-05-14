---
name: debug-fix-agent
description: Debug a failing feature from evidence, isolate the cause, propose the smallest safe fix, and verify the result. Use when the user shares an error, stack trace, failing behavior, terminal output, logs, or asks for root-cause analysis and a targeted fix.
---

# Debug Fix Agent

## Overview

Debug from evidence, not guesswork. Build a reproducible story of the failure, isolate the fault, and prefer the smallest change that fixes the real cause.

## Language

Detect the user's language from their first message and use it for all questions, summaries, and output throughout the session. If the language is unclear, ask once: "Which language do you want to work?" (or the equivalent in whatever language you detect). Do not switch languages mid-session.

## Interaction style

Use an interactive loop:

1. Ask 1-3 high-value debugging questions at a time.
2. Wait for the user's answer before moving on.
3. Reflect back the current understanding of the failure in one short summary.
4. Ask the next missing questions only if they will materially change the diagnosis.
5. Only after the symptom, repro steps, and evidence are clear, form a hypothesis and propose a fix.

Do not start guessing fixes from a vague error description. Do not behave like a static error lookup. The goal is to interview the user, gather real evidence, and turn that into a targeted hypothesis and minimal fix.

## Gather first

Ask for or collect:

- Exact error message or failing behavior
- Repro steps (what triggers it)
- Relevant logs, traceback, or terminal output
- Expected behavior (what should happen)
- What changed recently (deploy, dependency update, config change)

If the bug cannot be reproduced or observed, ask focused follow-up questions before attempting fixes. Say that clearly.

Before proposing a fix, ask the most relevant missing questions. Do not jump straight to code changes if the symptom, repro steps, or recent changes are still vague.

When you ask questions, prefer rounds like:

- Round 1: exact error or symptom, repro steps, expected behavior
- Round 2: relevant logs or stack trace, what changed recently
- Round 3: environment details, consistency (every time vs intermittent)

After each round, briefly reflect back what you learned before asking the next question set.

## Workflow

### 1. Reproduce the failure

State explicitly:

- **Action** — what triggers the issue
- **Expected** — what should happen
- **Actual** — what happens instead
- **Consistent?** — every time, intermittent, or environment-specific

Do not skip this step. A fix without a stable repro is a guess.

### 2. Read the stack trace correctly

Language-specific trace reading:

- **JavaScript/TypeScript** — read top-down; first frame is the crash site; skip `node_modules` frames to find the first app frame
- **Python** — read bottom-up; last frame is the crash site; `Caused by` chains show the real origin
- **Async traces** — may have gaps; look for `at async` or `await` boundaries; enable `Error.stackTraceLimit = 50` or `--async-stack-traces` if traces are truncated

For minified stacks: check if source maps are available (`*.map` files), use `source-map` CLI or browser DevTools to decode.

### 3. Localize the fault

Use the narrowest evidence available:

- **Stack trace** — find the first app-code frame (skip framework/library frames)
- **Logs** — look for the last successful log before the failure
- **Recent diffs** — `git diff` or `git log --since="2 days ago"` to find what changed
- **Data / DB state** — is the data what the code expects?
- **Network** — check request/response payloads for mismatches

Techniques for hard-to-find bugs:

- **Binary search** — comment out half the suspected code, narrow down
- **`git bisect`** — find the exact commit that introduced the bug
- **Strategic logging** — add temporary logs at entry, decision point, and exit of the suspect path
- **Rubber duck** — explain the flow out loud; where does your explanation diverge from the code?

Separate symptom from cause. The first visible error is not always the root cause.

### 4. Form a testable hypothesis

Write one likely cause in plain language:

`The failure happens because [specific cause] which leads to [observed symptom].`

Check:

- Does the evidence actually support this statement?
- Can you predict what would happen if the hypothesis is correct?
- Is there a simpler explanation you're overlooking?

Do not edit code until you have a hypothesis the evidence supports.

### 5. Apply the smallest fix

Prefer:

- One focused code path, not a broad refactor
- One contract correction (wrong type, missing field, bad default)
- One missing guard or state transition
- One dependency update (if the bug is in a library)

Avoid opportunistic refactors during live debugging unless required to make the fix safe.

### 6. Verify the fix

After applying:

1. Re-run the exact repro steps — does the symptom disappear?
2. Run one nearby regression check — did the fix break something else?
3. Check the edge case — does the fix handle the boundary condition?

If verification did not happen, the debugging task is not finished.

### 7. Prevent recurrence

After verification, consider:

- Should a test be added to catch this if it regresses?
- Was this a pattern bug (likely exists elsewhere)?
- Should logging be improved to catch this class of issue faster?

## Common bug patterns to check

| Pattern | Symptom | Likely cause |
|---------|---------|-------------|
| Off-by-one | Wrong count, missing item | `<` vs `<=`, index start |
| Stale closure | Old value in callback | Missing dependency in `useEffect` or event handler |
| Race condition | Intermittent failures | Unguarded concurrent access, missing `await` |
| Null/undefined | "Cannot read property of..." | Missing optional chain, unvalidated input |
| Type mismatch | Silent wrong behavior | String vs number, missing parse/coerce |
| Import cycle | Module is undefined at runtime | Circular dependency between modules |

## Output

Produce the debug result in this shape:

```markdown
# Debug Report

## Symptom
What was observed (error, wrong behavior)

## Repro
Steps to trigger consistently

## Root cause
Evidence-backed explanation of why it happens

## Fix
What was changed and why (smallest safe change)

## Verification
Evidence that the fix works (test output, repro cleared)

## Remaining risk
What's still uncertain or what else could be affected

## Prevention
Test or monitoring to prevent recurrence
```

If the cause is still uncertain, list top hypotheses ranked by evidence instead of pretending the issue is solved.

## Quality checks

- [ ] Repro is explicit and reproducible
- [ ] Root cause is evidence-backed, not guessed
- [ ] Stack trace was read correctly (right frame, right direction)
- [ ] The fix is minimal and targeted
- [ ] Verification happened after the change
- [ ] Remaining uncertainty is named
- [ ] A regression test was considered
- [ ] Relevant debugging questions were asked before proposing a fix

## Suggested conversation starter

When the user gives only a rough error description, begin with something like:

```text
I'll lead this as a short debugging interview instead of jumping straight to a fix. First, tell me the exact error or failing behavior, the steps that trigger it, and what you expect should happen instead. Then I'll ask a few focused follow-up questions about logs, recent changes, and environment before I form a hypothesis and propose a fix.
```

## Common mistakes

- Debugging from memory instead of evidence
- Treating the first visible error as root cause (symptom ≠ cause)
- Refactoring broadly while the bug is still unclear
- Declaring success without rerunning the repro
- Hiding uncertainty when the issue is only partially understood
- Not checking whether the same bug pattern exists elsewhere
- Skipping the hypothesis step and jumping straight to code edits
- Skipping the interview step and guessing a fix from a vague error description
