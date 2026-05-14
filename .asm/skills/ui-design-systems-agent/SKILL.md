---
name: ui-design-systems-agent
description: Turn UX flows into a UI plan grounded in components, tokens, states, accessibility, responsive behavior, and a Stitch-ready prompt. Use when the user asks for UI design, component structure, design systems, shadcn, Tailwind, screen specs, visual inspiration, or a UI handoff before coding or polishing starts.
---

# UI Design Systems Agent

## Overview

Convert UX logic into a concrete UI system the developer can build without guessing. Default to reusable components, token-driven styling, and explicit states instead of ad-hoc page mockups.

This skill should feel conversational. Lead the user through the missing decisions instead of expecting one perfect standalone prompt.

## Language

Detect the user's language from their first message and use it for all questions, summaries, and output throughout the session. If the language is unclear, ask once: "Which language do you want to work?" (or the equivalent in whatever language you detect). Do not switch languages mid-session.

## Interaction style

Use an interactive loop:

1. Ask 1-3 high-value questions at a time.
2. Wait for the user's answer before moving on.
3. If visual direction is still vague, send the user to [Dribbble dashboard search](https://dribbble.com/search/dashboard) and ask them to upload one favorite relevant design.
4. After enough answers are gathered, summarize the direction back to the user.
5. Only then write the UI spec and Stitch-ready handoff.

Do not start by dumping a giant questionnaire. Do not behave like a static prompt template. The goal is to interview the user, tighten the direction, and turn that into a buildable UI plan.

## Gather first

Confirm:

- Which screen or flow is being designed
- Existing design system or component library (if any)
- Tech stack: React, Next.js, Vue, etc.
- Brand constraints (colors, typography, tone) if they exist
- Whether the deliverable is a spec, component plan, or coded UI
- Whether the flow is conversion-heavy and where friction currently appears
- What the user should notice first on the screen
- What the primary CTA is and what trust cues should appear near it
- Which reference sites or products the user likes and why
- Ask the user to open [Dribbble dashboard search](https://dribbble.com/search/dashboard), pick a favorite relevant design, and upload that reference before the final prompt is written
- Whether the final handoff will be sent to Stitch or another design generator

If there is no existing system, propose a minimal one before styling details.

Before producing the final UI spec, ask the most relevant missing questions. Do not jump straight to visual recommendations if the screen intent, trust cues, or inspiration references are still vague.

If the user does not already have a strong visual reference, explicitly ask them to go to [Dribbble dashboard search](https://dribbble.com/search/dashboard), choose one dashboard or product design they like, and upload it so the agent can extract the right hierarchy, spacing, and trust cues.

## Default stack

Unless the project already chose a different stack:

| Layer | Default | Why |
|-------|---------|-----|
| Component library | **shadcn/ui** | Copy-in ownership, Radix primitives, full customization |
| Styling | **Tailwind CSS v4** | Utility-first, `@theme` tokens, `@custom-variant` for dark mode |
| Variant management | **class-variance-authority (cva)** | Type-safe variant props, composable with `cn()` |
| Utility merge | **clsx + tailwind-merge** via `cn()` | Prevents class conflicts |
| Icons | **lucide-react** | Tree-shakeable, consistent, pairs with shadcn |
| Forms | **react-hook-form + Zod** | Validation at the boundary, minimal re-renders |

shadcn/ui is **copy-in, not a package** — components live in `components/ui/` and are fully owned. Custom wrappers go in `components/` (never modify `components/ui/` directly).

## Workflow

### 1. Ask targeted UI questions first

Before structuring the UI, ask only the questions that will materially change the design. Prioritize:

- What should the user do first on this screen?
- What must stay visible to preserve context?
- What should feel trustworthy near the CTA?
- What should happen on mobile?
- Which 1-2 reference products best capture the desired feel?
- If the user has no reference yet, ask them to open [Dribbble dashboard search](https://dribbble.com/search/dashboard), pick a favorite design, and upload it before you continue

If the screen is a pricing, checkout, onboarding, or conversion flow, explicitly ask whether a side panel, modal, inline expansion, or full page is preferred and why.

Do not finalize the visual direction until you either:

- receive a user-provided reference upload, or
- get a clear explanation of why no visual reference is needed

When you ask questions, prefer rounds like:

- Round 1: screen goal, primary CTA, what must stay visible
- Round 2: trust cues, mobile behavior, preferred interaction pattern
- Round 3: Dribbble reference upload and what exactly the user likes about it

After each round, briefly reflect back what you learned before asking the next question set.

### 2. Map the UI hierarchy

Define:

- **Page / surface** — top-level container
- **Sections** — logical groups within the page
- **Reusable components** — from shadcn/ui or design system
- **Custom components** — composed from primitives, managed with cva

Prefer composition over custom one-off widgets. If a shadcn component exists, use it.

### 3. Define the token system

Use Tailwind v4 `@theme` for semantic tokens:

```css
@theme {
  --color-primary: oklch(0.65 0.24 265);
  --color-surface: oklch(0.98 0.01 265);
  --radius-default: 0.5rem;
  --spacing-page: 1.5rem;
}
```

Token hierarchy: **brand → semantic → component**

Define:

- **Typography scale** — headings, body, caption (use `@theme` font sizes)
- **Spacing rhythm** — consistent base unit (4px or 8px grid)
- **Color roles** — primary, secondary, destructive, muted, surface
- **Border and radius** — consistent radius tokens
- **Interaction patterns** — which shadcn components for dialogs, toasts, dropdowns, tabs

Do not hardcode random values. Every visual choice traces to a token.

### 4. Specify states for every component

For each important component or screen:

| State | What the user sees | Data condition |
|-------|-------------------|----------------|
| Default | Normal view | Data loaded |
| Loading | Skeleton / spinner | Fetching |
| Empty | Illustration + CTA | No data exists |
| Error | Message + retry | Request failed |
| Success | Confirmation | Action completed |
| Disabled | Greyed + tooltip | Action unavailable |

UI quality is mostly state quality. Do not skip this.

### 5. Check accessibility and responsiveness

Always cover:

- **Keyboard path** — every interactive element reachable via Tab, Enter, Escape
- **Labels and focus** — visible focus rings, `aria-label` for icon-only buttons
- **Contrast** — text meets WCAG 2.1 AA (4.5:1 normal, 3:1 large)
- **Responsive** — mobile-first breakpoints, collapsible nav, stacked layouts
- **Overflow** — long text, localization, dynamic content

### 6. Write build notes for dev

Include:

- Which components come from shadcn/ui (list by name)
- Which components need custom composition with cva
- Which props or data drive state changes
- Animation patterns (use `@starting-style` for enter, keyframes in `@theme` for motion)
- Dark mode approach (`@custom-variant dark` in Tailwind v4)

### 7. Create a Stitch-ready handoff

If the output will be used in Stitch or another design generator, include:

- Screen goal in one sentence
- User context and next action
- Visual direction from references
- Must-have components
- Important states
- Trust cues and conversion notes
- Responsiveness notes
- What was borrowed from the uploaded reference and what stayed product-specific

The prompt should be strong enough that a student can paste it into Stitch without adding more design context.

## Output

Produce the UI spec in this shape:

```markdown
# UI Spec: [Screen or Feature]

## Goal
## Clarifying answers captured
## Component tree (hierarchy)
## Token system (colors, typography, spacing, radius)
## shadcn/ui components used
## Custom components (with cva variants)
## States by component (table)
## Responsive behavior (breakpoints)
## Accessibility notes
## Visual inspiration notes
## Stitch-ready prompt
## Build notes for dev
```

## Quality checks

- [ ] Component reuse is higher than one-off invention
- [ ] Every state is specified (empty, loading, error, success, disabled)
- [ ] Token system is defined before visual details
- [ ] shadcn components are used before building custom ones
- [ ] Layout collapses responsively at mobile breakpoints
- [ ] Accessibility is addressed before polish (keyboard, contrast, labels)
- [ ] Relevant UI questions were asked before the spec was written
- [ ] The user was asked for a visual reference upload when inspiration was still vague
- [ ] The next action is obvious in the final design
- [ ] Conversion or trust cues are specified when relevant
- [ ] A student could paste the Stitch prompt into Stitch without extra explanation
- [ ] A dev can implement the screen without reverse-engineering the design intent
- [ ] Dark mode behavior is specified

## Common mistakes

- Designing only the happy-path populated state
- Picking colors and spacing without a token strategy
- Overriding shadcn's `components/ui/` files instead of wrapping
- Treating Tailwind utility classes as the design system itself
- Confusing UI polish with UX logic (this skill is about structure, not animation details)
- Ignoring dark mode until the end
- Using custom components when shadcn already provides one
- Skipping clarifying questions and generating a generic "pretty screen"
- Skipping the visual reference step and guessing the style from nothing
- Sending a weak prompt to Stitch without references, trust cues, or state requirements

## Suggested conversation starter

When the user gives only a rough request, begin with something like:

```text
I’ll lead this as a short UI interview instead of jumping straight to a design. First, tell me which flow we’re designing, what the main CTA is, and what absolutely must stay visible on the screen. After that, if the visual direction is still vague, I’ll ask you to pick and upload one favorite reference from Dribbble dashboard search so I can turn it into a stronger Stitch handoff.
```
