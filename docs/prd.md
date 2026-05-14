# PRD: NoBavel — MVP (v0.1)

## Summary

NoBavel is a GIS-style construction coordination platform built around a live spatial building model. The MVP gives every discipline on a construction project — architects, structural, MEP, finishes, inspectors, PMs, owners — a single shared view of plans, revisions, comments, and approvals. The product is NOT a CAD editor; it is a coordination surface that sits *on top of* CAD/BIM artifacts (DWG today, IFC later) and synchronizes the human workflow around them.

**Core differentiator — simplicity for trades.** NoBavel's competitive advantage vs. BIM 360, Autodesk Construction Cloud, Procore, and similar platforms is **end-user simplicity for the trade contractor**. An electrician, paving contractor, plumber, glazier, HVAC technician, or flooring installer — typically with zero CAD experience — must be able to open the app and complete their daily tasks **without training**. Every feature, every screen, every word of UI copy is judged against this constraint. If a paving contractor on a tablet on a job site can't succeed without help, the feature is wrong.

**Who pays, who uses.** The **General Contractor (GC)** is the buyer (per-project license, invites everyone else). The **trade contractor is the primary user** the product is designed around. Architects, PMs, inspectors, and owners are first-class participants but the UX is shaped by the trade.

**Why the GC pays.** The GC's economic case for NoBavel rests on three measurable outcomes per project: **shorter total project schedule** (less time lost to revision miscommunication and waiting for the right plan to reach the right trade), **fewer inspector remarks and punch-list items** (because trades built against the *current* plan, not yesterday's), and **lower unexpected expenses** (fewer change orders, RFIs, and field-discovered conflicts requiring rework). Every feature in this PRD must trace back to at least one of those three outcomes — otherwise it doesn't belong in v0.1. Trade simplicity is the *operational lever*; GC ROI is the *economic destination*.

**Pilot context.** v0.1 targets **mid-rise residential (5–15 floors)** in **Israel**, with **Hebrew (RTL) and English** at launch; Arabic deferred to a near-term post-MVP release with RTL-ready architecture from day one.

The MVP delivers seven tightly-scoped capabilities: a shareable-link invite system, a trade-focused "what's changed since last time" home view, a spatial plan viewer, a hierarchical layer system, revision tracking, spatial comments/annotations with notifications, and approvals. Everything else is explicitly deferred.

## Problem

Construction coordination today happens in email threads, WhatsApp groups, paper markups, and disconnected PDF exports of CAD files. The result is well-documented and expensive:

- **Revision drift** — one trade builds against an outdated plan because the latest revision never reached them.
- **Spatial illegibility** — comments live in text ("the column near the south stair on level 2") rather than pinned to coordinates, so context is lost and arguments multiply.
- **Layer chaos** — every discipline has its own file; cross-discipline conflicts (electrical conduit vs. HVAC duct vs. structural beam) are discovered only on site.
- **No accountability trail** — who approved what, on which revision, when? Usually unanswerable without a forensic email search.
- **Field rework** — the consequence: expensive, schedule-breaking corrections caught after construction has already started.
- **Tool-gap for trades.** Existing platforms (BIM 360, ACC, Procore) are built for CAD-literate users — architects, engineers, GC office staff. The actual people doing the work — an electrician pulling cable, a paving contractor coordinating a pour — are either excluded from the system entirely (and rely on a foreman to relay) or use it badly under duress. The result: the people closest to the problem have the worst tools for surfacing it.

Existing CAD tools (AutoCAD, Revit) are authoring tools. BIM 360 / ACC and similar platforms exist but skew toward enterprise pricing, heavy CAD-style UI, and per-discipline silos rather than a unified spatial map *that trades can use*. Smaller GCs and mid-size projects fall back to PDFs + email + WhatsApp and absorb the coordination cost.

**Cost of the status quo (for the GC).** Every revision-drift incident, every spatially-illegible argument, every late-discovered conflict translates into one or more of three line items the GC absorbs directly: **days added to the schedule** (trades waiting, redoing, or rebuilding), **remarks raised at inspection** (each remark = a reopen → fix → reinspect cycle), and **unexpected expenses** (change orders, additional labor, demolition and redo, RFI-driven rework). Coordination-related rework is widely cited as a meaningful share of mid-rise residential project cost; the exact figure varies by source, but every GC who has built a mid-rise can point to specific incidents on their last project. These are precisely the line items NoBavel is built to reduce — and they are how the GC will judge whether the platform is worth paying for.

Success means: every trade on a project, on the day they show up to work, opens NoBavel, sees the *current* spatial state with their relevant layers, sees what changed since they last looked, leaves comments pinned to coordinates when they find a problem, and cannot proceed without seeing — and acknowledging — revisions that affect them. **The trade does this without anyone explaining the app to them.** As a downstream consequence, the GC sees fewer remarks, a shorter schedule, and fewer unexpected expenses on the project's bottom line.

## Target users

**Primary user — Trade Contractor.** Electricians, plumbers, HVAC technicians, glazing contractors, paving contractors, flooring contractors, structural sub-contractors. Typically: not CAD-literate; mobile-first habits (WhatsApp is the dominant work tool); on a tablet or phone in the field; mixed Hebrew/English literacy; sometimes wearing gloves; sometimes in direct sunlight; intermittent connectivity. **Goal:** know what I have to do today, where, and whether anything affecting my work has changed. **The product is designed for this user.**

**Buyer — General Contractor (GC).** A construction firm running the project. Pays per-project; invites trades, architects, inspectors, owners under that license. The GC's project manager is the operator who sets up the project, invites people, configures layer-to-discipline mapping, and chases approvals.

**Why the GC writes the check.** The GC is not buying a coordination tool for coordination's sake — they're buying a measurable reduction in three line items they absorb on every project:

1. **Total project schedule** — days from start to substantial completion. Coordination failures add days; the platform removes them.
2. **Inspector remarks and punch-list items** — each remark is a reopen → fix → reinspect cycle that costs labor and time. The platform reduces them by making sure every trade builds against the current plan.
3. **Unexpected expenses** — change orders, field-discovered conflicts requiring rework, RFI-driven rework, demolition + redo. The platform surfaces conflicts as comments *before* they become rework.

The license cost only makes sense if NoBavel measurably moves at least two of these three numbers on the pilot project vs. the GC's most recent comparable project. **The GC's PM is a power user but is not the user the product is *shaped around*** — the trade is, because the trade is the leverage point for the GC's outcomes. If the trade doesn't open the app, the GC's numbers don't move.

**Secondary users:**

- **Architects** — publish revisions; resolve cross-discipline conflicts. Power-user surface (publishing) tolerates more complexity than the trade surface.
- **Inspectors** — verify on-site conditions against the current approved revision; pin findings spatially. Tablet primary; trade-like simplicity bar applies.
- **Owners / Developers** — read-only oversight on most flows; approve at milestone gates. Lighter usage frequency; UX bar similar to trade.

**Context of use:**

- **Frequency:** trades open NoBavel **once or twice per workday** during active construction phases (start of shift to check changes; sometimes mid-day to flag an issue). Architects/PMs open daily during design and weekly during construction.
- **Devices:** **tablet-first** (primary — iPad / Android tablet, landscape default). **Mobile phone second** (quick checks, notification triage, approval taps; read-and-act flows, not full authoring). **Desktop is a bonus** — used mainly for debugging, admin, and bulk uploads; not the design target.
- **Environment:** outdoor and on-site is the realistic case — direct sunlight, gloves, dust, intermittent LTE/Wi-Fi. UI must remain legible and usable in these conditions.
- **Languages:** Hebrew (RTL) and English at MVP. The same trade user may receive a Hebrew message from one PM and an English plan from an architect; per-user language preference is independent of project content language.
- **Expertise:** the trade end of the spectrum has **zero CAD vocabulary** and may also have low SaaS familiarity. UI uses plain-language equivalents only ("plan," "linked drawing," "view") — never "viewport," "xref," "plot."
- **Permissions:** role-based — GC PMs and architects can publish revisions and approve; trades can comment and acknowledge; inspectors can pin findings; owners are read-only with approval rights at milestone gates.

## Goals

1. **Make trades productive without training** — a trade contractor with zero CAD experience must complete the daily workflow (tap invite link → land in project → see what's changed → leave a spatial comment if needed → acknowledge the revision) within **5 minutes of first opening the app, with no onboarding tutorial**. This is the primary product goal because it is the *operational lever* for everything below.
2. **Deliver measurable GC ROI on every pilot project.** Every feature in this PRD must trace back to at least one of three GC-economics outcomes: **reduce total project schedule**, **reduce inspector remarks / punch-list items at inspection**, **reduce unexpected coordination-related expenses** (change orders, field-discovered rework, RFI-driven rework). If a feature can't be tied to at least one of these, it doesn't belong in v0.1. Trade simplicity (Goal 1) is the *how*; this is the *why the GC pays*.
3. **Frictionless invite.** A GC PM can invite a trade with a shareable link sent over any messaging channel (WhatsApp, SMS, email); the trade taps the link, signs in once, and is in the project. No account-creation flow that pre-supposes a desktop browser, no email-verification ping-pong.
4. **Eliminate revision drift** — when a revision is published, every affected trade is notified, and the old revision is visibly superseded in the viewer. (Mechanism for Goal 2's schedule and remarks outcomes.)
5. **Make every discussion spatial** — every comment and annotation is anchored to coordinates on a specific layer of a specific revision. No floating text threads. (Mechanism for Goal 2's unexpected-expense outcome — conflicts surface as comments *before* they become rework.)
6. **Make accountability auditable** — every approval, comment, and revision publish event is recorded with user, timestamp, and the exact revision/layer it applied to. (Reduces dispute-driven delay; serves Goal 2.)
7. **Make the map feel like a map** — pan, zoom, layer toggle, and progressive detail must feel like Google Maps / ArcGIS, not like AutoCAD. A non-CAD user should be able to navigate a plan within 60 seconds of first opening it.
8. **Stay coordination-only** — no CAD editing, no BIM authoring, no schedule/budget management in MVP.

## In scope

**1. Invite & sign-in (channel-agnostic shareable link)**

- GC PM enters a trade's name + role + assigned disciplines, generates a shareable invite link. PM sends that link via whatever channel they already use (WhatsApp / SMS / email).
- Tap → arrives at NoBavel → sees a login screen with a clear path (default: phone-number + one-time code; email + magic link supported as alternative — final mechanism is an open question, see below).
- After first successful sign-in, identity is bound to the invite. Subsequent taps go straight to the project.
- Invite links are project-scoped, single-recipient-bound after first use, and expire after a configurable window (default 14 days).
- No password creation required from the trade.

**2. Trade home view — "What's changed since last time"**

- The default landing surface for **trade-role users**. Architects, PMs, owners see a different home (project switcher / admin dashboard).
- Lists, top-down: revisions published since the trade's last visit affecting their assigned layers; new comments on their layers or mentioning them; approvals or acknowledgments pending from them.
- Each item shows a one-line summary in the user's preferred language and links directly to the spatial pin / revision / approval.
- Empty state ("nothing's changed since your last visit — you're current") is a first-class design surface, not an afterthought.

**3. Spatial plan viewer**

- Load 2D plan from DWG (via Autodesk APS Model Derivative API) and display in APS Viewer.
- Pan, zoom, fit-to-screen, jump-to-coordinate — touch-first gestures.
- Display the currently selected revision; switch between historical revisions.
- Minimum-disruption UI: map-style chrome, not CAD ribbons. No CAD vocabulary in any label.

**4. Hierarchical layer system**

- Layers organized hierarchically: discipline → sub-system → element type (e.g., Electrical → Power → Outlets).
- Show/hide toggle per layer and per branch of the hierarchy.
- Layer visibility state persists per user per project.
- Trade users default to seeing **only their assigned discipline's layers** plus a small set of shared layers (architectural backdrop); they can opt into more.
- Layers are derived from the source CAD file's layer metadata; MVP does *not* support manual layer creation in-app.

**5. Revision tracking**

- A project has an ordered list of revisions; each revision is an immutable snapshot of plans + layers at publish time.
- Architects (and GC PMs as a fallback) publish a new revision by uploading a new DWG; system processes it through APS, diffs layers against the previous revision, and marks the prior revision as superseded.
- Every user can see which revision they are viewing and how it differs from the previous (at the layer level — e.g., "Plumbing layer changed").
- Trades affected by changes in a revision (per their assigned disciplines) get a notification and must acknowledge before the system considers them "current."

**6. Comments and annotations**

- A user can pin a comment to a coordinate on a specific revision + layer.
- A comment has: author, timestamp, text body (in the author's preferred language), optional image attachment, thread of replies, status (open / resolved).
- Comments are visible to everyone with project access; resolution requires the original author or a GC PM.
- Comments survive across revisions: if a comment's anchor is on a layer that changed in a new revision, the comment is flagged as "needs review on new revision" rather than silently moved or lost.
- Trade-friendly composition: large input target, voice-to-text supported via OS-native input (no custom voice infra in MVP), single-tap photo attach from camera.

**7. Notifications**

- Triggered by: new revision affecting your discipline, new comment on your layer, new comment mentioning you, approval request directed at you, status change on your comment.
- Delivered in-app (real-time via WebSockets) and via email (immediate for approvals, configurable digest otherwise).
- Per-user notification preferences (immediate / digest / off) per event type.
- The invite link channel (WhatsApp/SMS/email/anywhere) is **not** a notification delivery channel at MVP; only in-app and email.

**8. Approvals**

- A GC PM or architect can request approval on a specific revision or layer-scope from one or more named approvers (typically architect + structural + owner at milestone gates).
- Approver sees a queued task; can approve, reject (with required comment), or request changes.
- Approval state is recorded immutably against the revision.
- A revision can be marked "approved" only after all required approvers have approved. (Copy: "approved," not "approved for construction" — see Risks.)

**9. Internationalization & RTL**

- UI ships in Hebrew (RTL) and English at MVP.
- Per-user language preference, independent of project / org / plan-content language.
- All components built RTL-ready from day one: bidirectional text, mirrored icons where appropriate, mirrored layouts, locale-aware dates / numbers.
- Plan-content text (labels inside DWG files) is rendered as-is by APS Viewer; UI chrome around it is per the user's preferred language.

## Out of scope

- CAD editing of any kind. NoBavel does not modify geometry.
- BIM authoring (Revit-style model creation).
- 3D model viewing in MVP — 2D plans only. (3D APS view is on the roadmap; not v0.1.)
- IFC support — DWG only for MVP.
- Scheduling, Gantt charts, budget/cost tracking, RFIs, submittals as formal workflow objects.
- Standalone progress photos / as-built markers (a photo pinned to a coordinate without a comment thread). Photo attachment **inside** a comment is in scope; standalone is post-MVP.
- WhatsApp Business API integration. MVP invite is a shareable link the PM pastes into any channel; we do not send via WhatsApp programmatically. (WhatsApp Business API is a post-MVP add.)
- Arabic at v0.1. RTL machinery ships at MVP; Arabic copy is a near-term post-MVP release.
- Native mobile apps (iOS/Android). MVP is delivered as a responsive web app, installable as a PWA.
- Full offline editing. MVP supports *graceful* connectivity loss (silent reconnect, queued user actions) but not authoring an entire revision offline.
- Desktop-polished experience. Desktop is supported as a debugging/admin surface only — layout and interactions are tuned for tablet first, mobile second.
- AI-assisted clash detection or auto-conflict resolution.
- Public/external sharing (anonymous viewer links).
- White-labeling / multi-tenant theming.
- SSO / enterprise IdP integration. (SAML/OIDC on roadmap.)
- Voice commands or custom voice infrastructure. (OS-native voice-to-text input is fine; nothing custom.)

## Main user flow

### Primary flow — Trade contractor checks what changed and responds

1. **Invite.** GC PM creates an invite for "Avi the electrician" with disciplines = Electrical. System generates a shareable link. PM pastes it into a WhatsApp message to Avi.
2. **Tap.** Avi taps the link on his tablet. The PWA opens (installable add-to-home-screen banner offered but not required); he sees a sign-in screen with a clear "enter your phone number" path. Enters number, gets a code via SMS, types it in.
3. **Land.** Avi is in the project, on his **What's changed** home view. He sees three items: "Revision 4 — Electrical layer changed (yesterday)", "Comment from HVAC: conflict with your conduit run in unit 3B (this morning)", "Acknowledge revision 4 — pending."
4. **Spatial check.** Avi taps the first item → lands on the spatial viewer at revision 4, with only the Electrical layer tree expanded and the changed area highlighted. He pans/pinches to see what's different. The layer-diff side panel summarizes: "two outlets relocated in unit 3B, one new circuit added."
5. **Comment / acknowledge.** Avi taps the HVAC comment, sees the pinned location, leaves a one-line reply ("I'll move the conduit east by 30cm — OK?") via voice-to-text on his keyboard. Then taps **Acknowledge revision 4**. His home view goes empty: "you're current."
6. **Architect responds.** The architect gets the comment notification, replies, and the cycle continues. If the architect needs to publish a new revision to resolve, that triggers the secondary flow below.

### Secondary flow — Architect publishes a revision

1. **Entry.** Architect opens NoBavel on a tablet or desktop, selects the project, lands on the spatial plan viewer showing the current revision.
2. **Publish.** Architect taps "Publish revision," uploads the new DWG. System enqueues an APS Model Derivative job (BullMQ) to translate the file and extract layer metadata.
3. **Processing.** Architect sees an in-progress state; receives a notification when translation completes. System diffs the new revision's layers against the previous and identifies affected disciplines.
4. **Fan-out.** Every trade assigned to an affected discipline gets an in-app + email notification. Their **What's changed** home view picks up the new revision the next time they open the app.
5. **Approval gate.** GC PM requests approval on the revision from the named approvers (architect, structural engineer, owner). Each approves or rejects with comment. Once all required approve, the revision is marked **approved**.

### Failure / edge states

- DWG translation fails → architect sees a clear error with reason; previous revision remains current.
- Trade taps an invite link that has expired → friendly screen: "This invite has expired. Ask your PM to send a new one." No dead-end.
- Trade taps an invite link that was already used by them previously → goes straight to the project (not back through invite acceptance).
- Trade taps a link that was bound to someone else → friendly screen: "This invite isn't for you. Ask your PM to send a new one to your phone."
- Comment's anchor layer changed in a new revision → comment shown with a "needs review — anchor layer changed" badge.
- Notification fan-out fails for a user (bad email, bounced SMS) → in-app notification still delivered; failure surfaced to PM in an admin view.
- Two users edit the same comment thread simultaneously → WebSocket-pushed updates with last-write-wins on the comment body, append-only on replies.
- Trade loses connectivity mid-action (comment in flight) → action queued locally and replayed silently on reconnect.

## Requirements

### Functional

- The system must let a GC PM generate a project-scoped, expiring, shareable invite link for a named recipient with assigned disciplines.
- The system must accept that link on tap, present a sign-in flow, and bind the invite to the authenticated user on first successful sign-in.
- The system must, for trade-role users, present a **What's changed since last visit** home view summarizing relevant revisions, comments, and pending acknowledgments / approvals.
- The system must render a 2D plan from a DWG file using Autodesk APS Viewer with touch-first pan / pinch-zoom / fit-to-screen.
- The system must extract layer metadata from the source CAD file and present it as a hierarchical tree (discipline → sub-system → element type).
- The system must default trade-role users to viewing only their assigned disciplines' layers, with an explicit opt-in to view others.
- The system must allow per-user toggling of layer visibility, and persist that state per user per project.
- The system must support uploading a new DWG as a new revision, asynchronously translating it via APS Model Derivative API.
- The system must produce a layer-level diff between consecutive revisions.
- The system must allow a user to switch between historical revisions of a plan.
- The system must allow a user to pin a comment to a coordinate on a specific revision and layer, with text body and optional image attachment.
- The system must accept comment text in any language the user types (Hebrew, English, mixed) and render it correctly per the bidirectional text rules.
- The system must support threaded replies on comments and an open/resolved status.
- The system must propagate comments forward across revisions, flagging comments whose anchor layer changed as "needs review."
- The system must deliver in-app notifications in real time (WebSocket) and email notifications (immediate for approvals, configurable digest otherwise).
- The system must allow each user to configure notification preferences per event type.
- The system must support requesting approval on a revision from one or more named approvers and recording each approver's decision.
- The system must mark a revision "approved" only after all required approvers have approved.
- The system must enforce role-based permissions per the *Permissions* table; deny prohibited actions both at the API and the UI level.
- The system must record an immutable audit log of revision publishes, approvals, and resolution events.
- The system must support per-user UI language preference (Hebrew / English) with full RTL layout in Hebrew.

### Non-functional

- **Performance (tablet target).** Initial plan view (cached revision) must render to interactive in under 4 seconds on a mid-tier tablet (iPad 9th gen / equivalent Android) over LTE for plans up to 20 MB. Desktop is faster as a side effect, not as a target.
- **Touch.** All primary interactions must work via touch alone: pan, pinch-zoom, layer toggle, comment pin, approval tap. No interaction may require hover or right-click.
- **Touch targets.** Minimum 44pt hit area on all interactive elements; spacing tuned to be reliable with gloves.
- **Outdoor legibility.** Color contrast meets WCAG AA at minimum, AAA on critical state indicators (notification badges, approval status, revision currency).
- **RTL / i18n.** All UI components are RTL-correct in Hebrew without per-screen retrofits. Numbers, dates, times follow the user's locale. Mixed-direction text (Hebrew + English in the same comment) renders correctly per Unicode bidirectional algorithm.
- **Connectivity.** Treat reconnect as a normal state. WebSocket disconnect/reconnect must be silent under 30s of outage; pending user actions (comment send, acknowledgment, approval tap) are queued locally and replayed on reconnect.
- **Real-time.** WebSocket notifications must reach connected clients in under 2 seconds from the triggering event (when connected).
- **APS processing.** DWG translation is async; UI must clearly communicate processing state and not block other work.
- **Availability.** 99.5% monthly availability target for the API and viewer. Notifications best-effort but with retry (BullMQ).
- **Scale (v0.1 target).** Up to 100 concurrent projects, up to 50 concurrent users per project, up to 100 revisions per project. Larger projects deferred.
- **Security.** All project data isolated per organization; no cross-tenant data leakage. S3 objects served via signed URLs only. Invite links signed and single-recipient-bound after first use.
- **Auditability.** Revision publish, approval, and resolution events are append-only and timestamped.
- **Strict TypeScript end-to-end.** Shared types between Next.js frontend and NestJS backend; no `any`.
- **Modularity.** Backend is domain-modular (identity, invites, projects, revisions, layers, comments, notifications, approvals, i18n). No cross-module reach-arounds.
- **Device / browser support.** **Primary:** Safari on iPadOS (latest two majors), Chrome on Android tablets (latest two majors). **Secondary:** Mobile Safari on iPhone, Chrome on Android phones. **Bonus (debug/admin):** latest Chrome / Edge / Safari / Firefox on desktop.
- **Layout.** Tablet landscape is the canonical canvas; tablet portrait must work without feature loss. Phone is one-column with sheets and bottom-anchored actions. Desktop reuses tablet layout at a max content width.
- **No CAD vocabulary in UI.** Lint rule on copy / translation strings rejecting CAD jargon (viewport, plot, xref, model space, paper space, etc.) — fails CI.

### Permissions

| Role               | View                                  | Comment | Acknowledge | Publish revision | Request approval | Approve       | Resolve comment   |
| ------------------ | ------------------------------------- | ------- | ----------- | ---------------- | ---------------- | ------------- | ----------------- |
| GC PM              | ✓                                     | ✓       | ✓           | ✓ (fallback)     | ✓                | ✓ (if named)  | ✓                 |
| Architect          | ✓                                     | ✓       | ✓           | ✓                | ✓                | ✓ (if named)  | ✓                 |
| Trade contractor   | ✓ (own disciplines + shared backdrop) | ✓       | ✓           | —                | —                | —             | ✓ (own comments)  |
| Inspector          | ✓                                     | ✓       | ✓           | —                | —                | ✓ (if named)  | ✓ (own comments)  |
| Owner / Developer  | ✓                                     | ✓       | —           | —                | —                | ✓ (if named)  | —                 |

## Acceptance criteria

Each criterion is observable and pass/fail.

- **A1. Plan loads (tablet).** Given a valid uploaded DWG, when a user opens the project on a mid-tier tablet (iPad 9th gen / equivalent Android) over LTE, the 2D plan renders in the viewer with pinch-zoom and two-finger-pan working, in under 4s for a 20 MB plan.
- **A1b. Touch-only navigation.** Every primary action (pan, zoom, layer toggle, pin comment, send approval) is reachable using touch alone, with no reliance on hover or right-click.
- **A2. Layer tree visible.** Given an uploaded DWG with layer metadata, the layer tree displays as a hierarchical tree, and toggling any node hides/shows the corresponding geometry.
- **A3. Trade default layer scope.** Given a trade user assigned to discipline X, on first opening the project they see only discipline X's layers plus the configured shared backdrop; opting into other disciplines requires one explicit tap and persists.
- **A4. Layer state persists.** Given a user has toggled specific layers off, when the user reloads the project, the same layers remain off.
- **A5. Revision publish triggers async job.** Given an architect uploads a new DWG, the system enqueues an APS Model Derivative job and shows in-progress UI; on completion, the new revision becomes selectable.
- **A6. Layer diff displayed.** Given a new revision exists, when a user views it, a panel lists which layers changed vs. the prior revision.
- **A7. Affected trades notified.** Given a new revision changes a layer assigned to discipline X, every trade user with discipline X receives both an in-app and email notification within 2s (in-app) / 60s (email).
- **A8. Comment pin works.** Given a user taps a coordinate in comment mode, a comment is created anchored to that coordinate + current revision + current layer.
- **A9. Comments persist across revisions.** Given a comment on revision N, when revision N+1 is published, the comment is visible in N+1; if its anchor layer changed in N+1, the comment shows a "needs review" badge.
- **A10. WebSocket real-time.** Given user A pins a comment, user B (currently viewing the same plan) sees the new pin within 2s without page reload.
- **A11. Approval gate.** Given a revision has 3 named approvers, the revision shows "approved" only after all 3 have approved; if any rejects, the revision is marked "rejected" with the reason.
- **A12. Audit log.** Given any revision publish, approval, or resolution event, an audit entry exists with user, timestamp, event type, and target id, and is retrievable via the admin view.
- **A13. Role enforcement.** Given a trade contractor user, attempting to publish a revision via the API returns 403; the UI hides the action.
- **A14. Failure surfaced.** Given a DWG translation job fails, the user who uploaded it sees the error reason within the project view and the previous revision remains current.
- **A15. Notification preferences honored.** Given a user sets "comment-on-my-layer" to digest, they receive that event only in the daily digest email, not as an immediate email.
- **A16. Reconnect is silent.** Given a tablet user loses WebSocket connectivity for up to 30 seconds, the UI does not display a disruptive error; any pending user action (comment send, acknowledgment, approval tap) is queued locally and replayed on reconnect.
- **A17. Invite flow works on tap.** Given a PM generates an invite link and a trade taps it on their tablet (fresh device, no prior session), the trade reaches the sign-in screen, completes sign-in, and lands on the project's **What's changed** home view in under 60 seconds total.
- **A18. Invite link reuse.** Given a trade has already accepted an invite, when they tap the same link again from the same device or a new device after re-sign-in, they go straight to the project (no re-acceptance).
- **A19. Invite link expiry.** Given an invite link past its expiry window, when anyone taps it, they see the "this invite has expired" screen and not the sign-in flow.
- **A20. Trade home view shows what changed.** Given a trade user opens the app and there have been relevant changes since their last visit, the home view shows those items sorted with the most relevant on top, each linking to its target location.
- **A21. Empty state is friendly.** Given a trade user with nothing pending, the home view shows a clear "you're current" state, not an empty list with no context.
- **A22. RTL correctness (Hebrew).** Given a user with language preference = Hebrew, every screen renders in RTL with mirrored layouts, correct bidirectional text, mirrored directional icons, and locale-appropriate dates.
- **A23. Mixed-direction comments.** Given a comment containing both Hebrew and English in one paragraph, the text renders per the Unicode bidirectional algorithm with no broken word order or punctuation.
- **A24. No CAD jargon in UI.** A copy-lint rule fails CI if any user-facing string contains the words "viewport," "plot," "xref," "model space," or "paper space" (in any supported language).
- **A25. Trades no-training test.** In a moderated usability test with at least 5 trade-contractor participants (mix of electrician / plumbing / HVAC / paving / glazing / flooring) who have never seen the product, ≥ 4 of 5 complete the daily workflow (tap invite link → sign in → see what's changed → pin a comment → acknowledge revision) within 5 minutes from first tap of the link, with **no facilitator intervention**. Re-run before every release. **A failure of this test blocks ship.**
- **A26. GC measurement framework in place.** Before pilot construction starts, the following exist *in writing, signed by the GC PM and the NoBavel team*: (a) the pilot project profile, (b) the baseline project profile (most recent comparable), (c) the three baseline numbers — schedule days, inspector remarks count, coordination-related expense total, (d) the agreed taxonomy of "coordination-related expense," (e) the GC's commitment to track the same three numbers on the pilot project. The system has recorded these as a `ProjectBaseline` row and all leading-indicator instrumentation (revision-to-ack time, comment-resolution time, unresolved-comment count, badge-resolution rate) is live and emitting data.

## Success metrics

Quantified targets for v0.1 success, measured at substantial completion of the first paying pilot project (or, for adoption metrics, 90 days after the pilot project goes live, whichever comes first).

### GC ROI outcomes (the metrics the GC pays for)

These are the three line items the GC's economic case rests on. All are computed as deltas vs. a baseline collected from the GC's most recent comparable project at pilot kickoff.

- **Schedule reduction.** Total project schedule (start of construction → substantial completion) reduced by **≥ 8%** vs. the GC's baseline. Calibration target — see Open questions.
- **Remarks reduction.** Inspector remarks / punch-list items at final inspection reduced by **≥ 25%** vs. the GC's baseline (using the same inspector or inspection regime where possible).
- **Unexpected-expense reduction.** Coordination-related unexpected expenses (change orders, field-discovered rework, RFI-driven rework, demolition + redo — definition agreed in writing at pilot kickoff) reduced by **≥ 30%** vs. the GC's baseline. Reported in absolute currency *and* as a percentage of total project cost.

> Pilot success criterion: NoBavel measurably moves **at least two of these three** numbers on the pilot project. One out of three is insufficient — it's likely noise. Three of three is the target.

### Leading indicators (in-product proxies for the GC outcomes above)

These are directly measurable in NoBavel and are expected to correlate with the GC outcomes. They are the early signals during the pilot — if these don't move, the lagging GC outcomes won't either.

- **Revision-to-acknowledgment time.** Median time from revision publish to last-affected-trade acknowledgment ≤ **24 hours** during active construction phases. (Faster ack → less time trades spend building against old plans → fewer remarks + faster schedule.)
- **Comment resolution time.** Median time from comment opened (a flagged coordination issue) to resolved ≤ **48 hours**. (Faster resolution → conflicts caught and fixed at planning cost, not field-rework cost.)
- **Unresolved-comment leakage.** Fewer than **5% of opened comments** remain unresolved at substantial completion. (Unresolved comments at handover are a proxy for issues that became field problems.)
- **"Needs review" badge resolution.** ≥ **90%** of "needs review on new revision" badges are resolved (acknowledged or commented) within 7 days of the revision that produced them.

### Trade adoption metrics (the mechanism for the outcomes above)

If trades don't adopt, none of the above moves. These metrics gate the others.

- **Trades time-to-first-value.** ≥ 80% of invited trade users complete the daily workflow within **5 minutes** of receiving their invite, with no training session, measured via funnel telemetry.
- **Invite conversion.** ≥ 90% of invite links sent to trades result in a successful first sign-in within 48 hours of send.
- **Trades stickiness.** ≥ 70% of invited trade users return on day 7 and again on day 14 without a nudge from the PM.
- **Trades NPS.** Onboarding NPS from trade users ≥ 50 at 30 days after invite (separate measurement from PM / architect NPS).
- **Adoption breadth.** ≥ 80% of named trade members on a project log in at least once per week during active construction phases.
- **Revision currency.** ≥ 95% of revision-acknowledgment notifications are acknowledged within 48 hours of publish.
- **Spatial commenting share.** ≥ 70% of project communication on coordination issues happens as in-app comments (self-reported by GC PM at end-of-project survey) vs. WhatsApp / email.

### System metrics

- Plan-load p95 ≤ 3s on tablet over LTE; WebSocket event delivery p95 ≤ 2s; monthly availability ≥ 99.5%.

Targets are **proposed**; the GC-ROI thresholds in particular must be calibrated with the pilot GC at kickoff — see Open questions.

## Risks

| Risk | Type | Severity | Mitigation |
|---|---|---|---|
| Trades won't adopt the app because it feels like CAD software they've avoided their whole career. Without trade adoption the platform's whole premise fails. | Product | **Critical** | Simplicity-for-trades is goal #1. Every release runs the A25 no-training usability test on real trades before ship. If a release fails A25, it does not ship. UI copy avoids CAD terminology entirely (enforced by CI lint, A24). |
| **Cannot prove GC ROI.** Pilot completes, trades adopt, everything *feels* better — but we cannot show the GC their schedule shortened, remarks dropped, and unexpected expenses fell. Without the three GC-outcome numbers moving, the platform has no monetization case despite technical success. | Product / GTM | **Critical** | Co-define the three-metric measurement framework with the pilot GC in writing at kickoff, *before* construction begins. Collect explicit baseline from their most recent comparable project (definition of "comparable" agreed in writing). Instrument all in-product proxy metrics from day one. Run a structured before/after review at pilot completion. If only one of three moves, treat the pilot as a learning project, not a reference customer. |
| Pilot GC dependency — too much depends on one design partner; if their schedule slips or they pull out, v0.1 has no real-world signal. | Delivery | **High** | Recruit 2–3 candidate GC pilots in parallel; sign at least 2 to LOIs before locking v0.1 scope; treat the first pilot's project as instrumented learning, not as a monetization milestone. |
| RTL bugs are pervasive because Hebrew correctness wasn't enforced from day one. | Technical / UX | **High** | Build RTL-correctness into the component library before any feature work; CI runs both LTR and RTL visual regression snapshots; every PR includes Hebrew QA pass. |
| Users default back to WhatsApp / email because the in-app comment habit doesn't form. | Product | **High** | Every email + in-app notification deep-links to the spatial pin; **What's changed** home view makes ignoring the app costly; measure spatial-commenting share weekly. |
| Invite link security: leaked links allow access by unintended people. | Security | **High** | Bind invite token to first-acceptor device + identity; revoke unused links on expiry; PM-revocable mid-flight; rate-limit attempts; audit-log all acceptances. |
| Layer hierarchy derived from CAD file metadata is inconsistent across architects/firms — same discipline modeled with different layer names. | Product / Data | **High** | MVP: per-project layer-to-discipline mapping UI for GC PM. Document the limitation explicitly. Post-MVP: layer-name normalization. |
| Designers default to desktop-first habits and produce layouts that only work well on desktop. | UX / Delivery | **High** | Every design review and usability test runs on a physical tablet first, then a phone. No screen is signed off purely from a desktop browser. |
| Tablet performance on large DWGs is worse than expected; APS Viewer chokes on mid-tier iPads. | Technical | **High** | Benchmark on a target-tier iPad and target-tier Android tablet before locking the viewer integration; degrade gracefully (simplified rendering tier) if needed. |
| Per-tenant data isolation bug leaks plans across orgs. | Security | **High** | Tenant scoping enforced at the repository/data-access layer (not just route guards); automated cross-tenant access tests in CI. |
| APS Model Derivative API latency or quota becomes a bottleneck. | Technical | Medium | Aggressive BullMQ retries with backoff; transparent in-UI progress; pre-translate on upload, not on first view; monitor APS quota and alert. |
| WebSocket scaling pain at higher concurrent-user counts in a single project (50+ users). | Technical | Medium | Redis pub/sub fan-out from the start; load-test the 50-user-per-project target before launch. |
| Site connectivity is more unreliable than the "intermittent" assumption — users lose 30s+ frequently. | Technical / Product | Medium | Silent reconnect under 30s; non-blocking "reconnecting" affordance beyond that; queue user actions locally regardless. Revisit offline-edit scope post-MVP based on telemetry. |
| Outdoor sunlight and gloved use make subtle UI affordances unreadable / untappable. | UX | Medium | Enforce AA contrast minimum, AAA on status indicators; 44pt touch targets; field-test on a sunny day with at least one gloved user. |
| Approval flow ambiguity: "approved" is treated as legally binding sign-off without legal review. | Delivery / Legal | Medium | Neutral copy ("approved," not "approved for construction"); per-project disclaimer; clarify in onboarding that this is coordination, not legal sign-off. Open question for legal review. |
| Scope creep into RFI / submittal / scheduling / as-built territory mid-build. | Delivery | Medium | This PRD is the contract; new asks become v0.2 candidates with their own PRD. |
| DWG-only at launch limits addressable market (large clients use Revit/IFC). | Product | Medium | Document explicitly as MVP constraint; IFC roadmap commitment communicated to design partners. |
| Pilot's first project is too large/complex and fails to demonstrate value. | Delivery | Medium | Define a "good first project" profile (≤ 6 disciplines, ≤ 20 layers per discipline, mid-rise residential 5–15 floors); recruit pilots whose first project matches. |
| Quality-over-speed mandate becomes infinite-scope drift without a date forcing function. | Delivery | Medium | Use the A25 no-training test as the forcing function: ship the moment we pass A25 with a real GC's actual trades on the pilot project. Re-evaluate scope quarterly against that bar. |

## Open questions

The following materially affect scope, design, or success metrics and need answers before or during the design phase:

1. **Pilot GC.** Specifically which GC firm is design-partner-1? And ideally 2–3 candidates in parallel. Their layer conventions, approval rituals, and typical project profile calibrate the whole MVP.
2. **Sign-in mechanism.** Phone-number + SMS OTP, email + magic link, or both at MVP? Phone-OTP is the trade-friendly default but adds Twilio / SMS-gateway cost from day one. Email+magic-link is cheaper but worse UX for trades. Recommendation: **phone OTP primary, email magic-link as fallback for users whose phone OTP fails or who don't want to share their number** — confirm with pilot GC.
3. **Discipline-to-layer mapping authority.** Who owns the mapping per project — GC PM, architect, or NoBavel admin? MVP defaults to GC PM; needs validation with a real architect.
4. **Approval semantics.** Is "approved" legally meaningful in Israeli construction law? Need legal review of copy and audit-log retention requirements.
5. **Audit log retention.** How long must audit data be retained? Israeli construction-industry-typical may differ from US (7+ years); affects storage and archival design. Need pilot-GC legal input.
6. **PWA installability depth.** v0.1 ships installable add-to-home-screen + standalone shell? Or just a regular browser tab? Recommendation: **add-to-home-screen + standalone shell from day one** — the marginal cost is low and trade UX is meaningfully better.
7. **Android tablet share.** What proportion of target field users are on Android tablets vs. iPad in Israeli construction? Affects how much Chromium / Android-specific testing we invest in for v0.1.
8. **Offline-edit depth.** "Graceful connectivity loss" is in scope, but full offline authoring of a revision is not. If pilot data shows users lose connectivity >5 minutes frequently, this scope decision must be revisited.
9. **WhatsApp Business API timeline.** MVP uses a regular shareable link the PM pastes manually. When does programmatic WhatsApp delivery become important enough to add? Likely v0.2 or v0.3 — pilot signal will tell.
10. **DWG layer metadata reliability.** What % of real DWGs from Israeli architects have clean, parseable layer metadata vs. ad-hoc Hebrew naming? Needs a sample of 10–20 real files from pilot architect.
11. **Hebrew layer names.** DWG files in Israel may have layer names in Hebrew. Are we comfortable matching those to disciplines via the PM mapping UI, or do we need transliteration / canonicalization machinery?
12. **Pricing model.** Per-project (GC-paid)? Per-seat? Per-organization? Doesn't block MVP build but blocks billing scope decisions.
13. **Identity / SSO.** Email + password (or phone OTP) for MVP, but how soon do enterprise pilots require SAML/OIDC?
14. **Notification channels beyond email.** SMS for approvals? Slack/Teams integration? WhatsApp Business outbound? Out of scope for v0.1 but signal interest now.
15. **Success-metric baselines.** The GC-ROI percentages (8% schedule / 25% remarks / 30% expense) need a credible baseline from the pilot GC's prior comparable project. How do we collect it — self-report from the PM's memory, extract from their job-cost / scheduling systems, or both? What level of evidence is "credible enough" for the pilot vs. for an external success story?
15a. **Definition of "comparable project."** Floor count, sqft, unit count, trade mix, duration, geography, season — which dimensions must match for a baseline project to be comparable? Locked in writing with the pilot GC at kickoff.
15b. **Definition of "coordination-related unexpected expense."** Need a written taxonomy with the pilot GC: which change orders count? Which RFIs count? Which rework events count? Edge cases (e.g., rework due to a city-mandated design change vs. rework due to revision drift) must be classified up front, not argued at pilot end.
15c. **Realism of the GC-ROI targets.** Are 8% schedule / 25% remarks / 30% expense reductions realistic on a first pilot, or aspirational? Industry benchmark research and a pilot-GC sanity check needed before quoting them externally.
15d. **GC participation in measurement.** The lagging GC outcomes can only be measured if the GC's office tracks them. Will the pilot GC commit to (a) sharing baseline numbers, (b) tracking the same numbers on the pilot project in a comparable way, and (c) sharing the result openly? If not, the ROI case is unprovable.
16. **3D viewer urgency.** Is the absence of 3D a deal-breaker for any prospective pilot? If yes, scope shifts.
17. **Comment migration on revision.** When an anchor layer changes, "needs review" is the MVP behavior. Should we attempt automated re-anchoring (nearest-coordinate) post-MVP, or keep it explicit forever?
18. **Project size at pilot.** Mid-rise residential 5–15 floors is the target; what's the typical pilot project at the upper end (e.g., 15-floor, 8 disciplines, hundreds of layers)? Affects the v0.1 scale target.
19. **Arabic timeline.** Post-MVP, but how soon? Affects how much we invest in Arabic-specific i18n testing infrastructure during v0.1.

## Handoff to architecture / UX

### Obvious entities

- `Organization` (tenant boundary — typically a GC firm; also architect firms, owner-developer firms)
- `Project` (belongs to one Organization as the "operator org"; has many Members, Revisions; the GC org is the project operator)
- `Member` (User × Project × Role × Disciplines[] × LanguagePreference)
- `User` (identity; cross-org; phone number + email; LanguagePreference)
- `Role` (GC-PM, Architect, Trade, Inspector, Owner)
- `Discipline` (Architectural, Structural, Electrical, Plumbing, HVAC, Glazing, Paving, Flooring, …) — extensible
- `Invite` (Project × invited recipient identity (phone or email) × Role × Disciplines[] × token × expires_at × acceptedBy?)
- `InviteAcceptance` (Invite × User × acceptedAt × deviceFingerprint)
- `Session` (User × token × deviceFingerprint × createdAt × lastSeenAt)
- `Revision` (belongs to Project; immutable snapshot; status: processing | ready | superseded | approved | rejected)
- `Layer` (belongs to Revision; hierarchical; mapped to a Discipline)
- `LayerDiff` (computed between consecutive Revisions; per-layer change record)
- `Comment` (belongs to Revision + Layer; anchored to coordinate; threaded; bodyLanguage)
- `CommentReply`
- `Notification` (User × event × channel × delivery state)
- `NotificationPreference` (User × event type × channel × mode)
- `Acknowledgment` (User × Revision)
- `ApprovalRequest` (Revision × required Approvers[])
- `ApprovalDecision` (ApprovalRequest × Approver × decision × comment)
- `AuditLog` (append-only event stream)
- `Attachment` (S3 object reference; signed-URL served)
- `UserActivity` (User × Project × lastSeenAt) — drives the **What's changed since last visit** home view
- `ProjectBaseline` (Project × baseline_schedule_days × baseline_remarks_count × baseline_coordination_expense_total × baseline_project_reference × agreed_at) — the GC's reported metrics from their most-recent-comparable project, captured in writing at pilot kickoff. Drives the GC ROI computation.
- `ProjectOutcome` (Project × actual_schedule_days × actual_remarks_count × actual_coordination_expense_total × computed_at) — the same three metrics for the current project at substantial completion. Reported by the GC; deltas against `ProjectBaseline` give the GC ROI numbers.
- `ProxyMetric` (Project × metric_name × computed_value × window_start × window_end) — in-product leading indicators: revision-to-acknowledgment time, comment-resolution time, unresolved-comment count, badge-resolution rate. Computed continuously during the pilot.

### Likely screens / surfaces

- **Trade "What's changed" home** — *the primary surface for trade users*. Personalized list: new revisions affecting them, new comments on their layers / mentioning them, pending acknowledgments / approvals. Empty state designed first-class.
- **Operator dashboard (GC PM / Architect home)** — project switcher with status badges, member admin, invite generator.
- **Sign-in** — phone-number + OTP primary, email magic-link fallback. Single screen, Hebrew/English toggle visible.
- **Invite-accepted landing** — the first screen a trade sees on first tap of an invite link.
- **Spatial plan viewer** — *the central surface for everyone*. APS Viewer canvas + map-style chrome + layer tree panel + revision selector + comment panel. Touch gestures are the canonical interaction.
- **Layer tree** — hierarchical, multi-level toggle, per-discipline filter, per-user persisted state. Trades default to their disciplines + backdrop.
- **Revision history** — timeline of revisions with diff summaries; tap to switch.
- **Layer-diff panel** — what changed between current revision and previous; primary content of the trade flow step 4.
- **Comment thread overlay / side panel** — pinned to a coordinate; replies; resolve action; voice-to-text-friendly input.
- **Notifications center** — in-app real-time list; preferences sub-screen.
- **Approvals queue** — "approvals pending you" + "approvals you've requested."
- **Project admin (GC PM)** — members, invite generation + revoke, role assignment, discipline-to-layer mapping, notification policy defaults.
- **Audit log viewer** — admin-only.
- **Language switcher** — accessible from any screen (Hebrew ↔ English at MVP; Arabic added later without UI restructuring).

### Roles and permissions

See the table in *Requirements → Permissions*. Architectural note: enforce at the repository/data-access layer with tenant + role + discipline scoping, NOT only at the HTTP guard. Route guards remain as a defense-in-depth layer.

### External integrations

- **Autodesk APS** — Model Derivative API (DWG → SVF/SVF2 translation), Viewer SDK (frontend rendering). OAuth 2-legged for service-to-service.
- **AWS S3** — storage for uploaded DWGs and comment attachments; signed URLs for delivery.
- **SMS gateway** (Twilio or local Israeli provider) — phone-OTP at sign-in; abstract behind a pluggable adapter.
- **Email provider** (SES or similar) — transactional + digest emails + magic-link fallback at sign-in.
- **(Future)** WhatsApp Business API, IFC import, SAML/OIDC IdP, Slack/Teams notifications.

### Suggested architecture questions to resolve

1. **Identity model.** Phone-number-first or email-first identity? Recommend phone-first (trade UX), with email as an attached secondary identifier. Final call needed before any auth code is written.
2. **Invite token cryptography.** Signed token vs. opaque random + DB lookup? Recommend signed (HMAC) for stateless verification, plus a revocation list for invites the PM revokes mid-flight.
3. **APS job orchestration.** BullMQ worker per-project queue or shared? How do we handle APS rate limits and retries cleanly?
4. **WebSocket fan-out.** Single Socket.IO / native WS layer in front of NestJS, with Redis pub/sub for cross-instance? Confirm topology before any UI work depends on it.
5. **Layer-diff computation.** Where does it run — inline post-translation in the BullMQ worker, or lazy on first view? Recommend inline.
6. **Comment coordinate model.** APS gives us a coordinate space per drawing; we need to stably reference coordinates across revisions even when geometry shifts. Define the coordinate-anchor schema (model-space coordinates + layer ref) explicitly.
7. **Tenant isolation enforcement strategy.** Postgres row-level security vs. application-layer scoping vs. both? Recommend both; finalize before any data-access code.
8. **Audit log storage.** Same Postgres database (append-only table) or separate event store? Same DB is fine for MVP; design for migration.
9. **Notification delivery pipeline.** Single BullMQ queue for all notification events with channel fan-out workers, or per-channel queues? Recommend single event queue + per-channel workers.
10. **APS viewer integration boundary.** The viewer is heavy JS; isolate it behind a thin React component with a typed prop contract so the rest of the app remains unaware of APS internals.
11. **Realtime state reconciliation.** Zustand store + WebSocket events: define the event schema and reconciliation rules (last-write-wins for comment body, append-only for replies, idempotent for acknowledgments) before the UX agent designs interactions that depend on this.
12. **APS Viewer on tablet.** Validate frame-rate and memory behavior on iPad 9th gen / mid-tier Android tablet with a representative 20 MB DWG before committing to the viewer integration shape. Identify a fallback rendering tier if needed.
13. **PWA shell + installability.** Service-worker-friendly app shell from day one; ship installable add-to-home-screen at v0.1 per the open question recommendation.
14. **Action queue.** Comment send, acknowledgment, and approval tap must each be idempotent at the API level and queue-replayable on the client. Define the client-side action queue early — Zustand middleware + a typed envelope per action.
15. **Touch gesture layer.** Pinch / two-finger pan / single-tap pin / long-press context — decide whether to ride on APS Viewer's gesture handling, layer our own on top, or both. Lock the gesture map before any UX work on the viewer.
16. **i18n / RTL architecture.** Choose the i18n stack (next-intl, react-intl, custom) and the RTL strategy (CSS logical properties, `dir="rtl"` on root, per-component overrides) and lock both before component-library work begins. Retrofitting RTL is one of the worst tax bills in this PRD.
17. **"What's changed" computation.** UserActivity.lastSeenAt × project-event-stream filtered by user's disciplines and mentions. Decide whether to compute on read (cheaper, scales worse) or maintain a per-user inbox (more storage, faster reads). Recommend read-side computation at MVP scale.

### Handoff sequence

1. **UX agent** picks up *Main user flow* + *Likely screens* and produces flow diagrams + low-fidelity wireframes for the trade home view, sign-in flow, spatial viewer, layer tree, comment pin, revision switcher, and approvals queue. **All wireframes are produced at tablet landscape first, tablet portrait second, phone third. Desktop is derived, not designed. Wireframes are produced in both LTR (English) and RTL (Hebrew) variants — RTL is not a post-hoc mirror.**
2. **Tech-lead architecture agent** picks up *Obvious entities* + *Architecture questions* and produces the module map, data model, API contract, and answers to questions 1–17.
3. **PRD owner** revisits *Open questions* with pilot-GC input before either agent locks decisions that depend on those answers — especially Q1 (pilot GC), Q2 (sign-in mechanism), Q10 (real DWG sample), and Q11 (Hebrew layer names).
