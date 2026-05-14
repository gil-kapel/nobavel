# PRD: NoBavel — MVP (v0.1)

## Summary

NoBavel is a GIS-style construction coordination platform built around a live spatial building model. The MVP gives every discipline on a construction project — architects, structural, MEP, finishes, inspectors, PMs — a single shared view of plans, revisions, comments, and approvals. The product is NOT a CAD editor; it is a coordination surface that sits *on top of* CAD/BIM artifacts (DWG today, IFC later) and synchronizes the human workflow around them.

**Core differentiator.** NoBavel's competitive advantage vs. BIM 360, Autodesk Construction Cloud, Procore, and similar platforms is **end-user simplicity for the trades**. An electrician, paving contractor, plumber, glazier, HVAC technician, or flooring installer — typically with zero CAD experience — must be able to open the app and complete their daily tasks **without training**. Every feature, every screen, every word of UI copy is judged against this constraint. If a paving contractor on a tablet on a job site can't succeed without help, the feature is wrong.

The MVP delivers six tightly-scoped capabilities: a spatial plan viewer, a hierarchical layer system, revision tracking, spatial comments/annotations, notifications, and approvals. Everything else is explicitly deferred.

## Problem

Construction coordination today happens in email threads, WhatsApp groups, paper markups, and disconnected PDF exports of CAD files. The result is well-documented and expensive:

- **Revision drift** — one trade builds against an outdated plan because the latest revision never reached them.
- **Spatial illegibility** — comments live in text ("the column near the south stair on level 2") rather than pinned to coordinates, so context is lost and arguments multiply.
- **Layer chaos** — every discipline has its own file; cross-discipline conflicts (electrical conduit vs. HVAC duct vs. structural beam) are discovered only on site.
- **No accountability trail** — who approved what, on which revision, when? Usually unanswerable without a forensic email search.
- **Field rework** — the consequence: expensive, schedule-breaking corrections caught after construction has already started.

Existing CAD tools (AutoCAD, Revit) are authoring tools. BIM 360 / ACC and similar platforms exist but skew toward enterprise pricing, heavy CAD-style UI, and per-discipline silos rather than a unified spatial map. Smaller teams and mid-size projects fall back to PDFs + email and absorb the coordination cost.

Success means: every stakeholder on a project opens NoBavel, sees the *current* spatial state with their relevant layers, leaves comments pinned to coordinates, and cannot proceed without seeing — and acknowledging — revisions that affect them.

## Target users

**Primary user — Project Manager / Coordinator.** Owns the project schedule, feels the pain of coordination failures most directly, has authority to mandate a tool, and is the buyer. Goal: prevent rework by ensuring every trade is working from the current plan.

**Secondary users (consumers of the product, daily):**

- **Architects** — publish revisions; resolve cross-discipline conflicts.
- **Structural / MEP / finishes contractors** (electricians, plumbers, HVAC, glazing, paving, flooring) — view layers relevant to their trade, leave spatial comments, acknowledge revisions, request approvals.
- **Inspectors** — verify on-site conditions against the current approved revision; pin findings spatially.
- **Developers / owners** — read-only oversight; approve milestones.

**Context of use:**

- **Frequency:** daily during active construction phases; weekly during design.
- **Devices:** **tablet-first** (primary — used in the field, site trailer, and design reviews; iPad / Android tablet, landscape default). **Mobile phone second** (quick checks, notification triage, approval taps; read-and-act flows, not full authoring). **Desktop is a bonus** — used mainly for debugging, admin, and bulk uploads; not the design target.
- **Environment:** outdoor and on-site is the realistic case — direct sunlight, gloves, dust, intermittent LTE/Wi-Fi. UI must remain legible and usable in these conditions.
- **Expertise:** ranges from CAD-literate architects to non-technical site supervisors. UI must not assume CAD vocabulary.
- **Permissions:** role-based — PMs and architects can publish revisions and approve; trades can comment and acknowledge; inspectors can pin findings; owners are read-only with approval rights at milestone gates.

## Goals

1. **Make trades productive without training** — a trade contractor (electrician, paving contractor, plumber, glazier, HVAC, flooring) with zero CAD experience must complete the daily workflow (open project → find their layers → see what's changed → leave a spatial comment → acknowledge a revision) within 5 minutes of first opening the app, with no onboarding tutorial. This is the primary product goal; everything else serves it.
2. **Eliminate revision drift** — when a revision is published, every affected stakeholder is notified, and the old revision is visibly superseded in the viewer.
3. **Make every discussion spatial** — every comment and annotation is anchored to coordinates on a specific layer of a specific revision. No floating text threads.
4. **Make accountability auditable** — every approval, comment, and revision publish event is recorded with user, timestamp, and the exact revision/layer it applied to.
5. **Make the map feel like a map** — pan, zoom, layer toggle, and progressive detail must feel like Google Maps / ArcGIS, not like AutoCAD. A non-CAD user should be able to navigate a plan within 60 seconds of first opening it.
6. **Stay coordination-only** — no CAD editing, no BIM authoring, no schedule/budget management in MVP.

## In scope

**1. Spatial plan viewer**
- Load 2D plan from DWG (via Autodesk APS Model Derivative API) and display in APS Viewer.
- Pan, zoom, fit-to-screen, jump-to-coordinate.
- Display the currently selected revision; switch between historical revisions.
- Minimum-disruption UI: map-style chrome, not CAD ribbons.

**2. Hierarchical layer system**
- Layers organized hierarchically: discipline → sub-system → element type (e.g., Electrical → Power → Outlets).
- Show/hide toggle per layer and per branch of the hierarchy.
- Layer visibility state persists per user per project.
- Layers are derived from the source CAD file's layer metadata; MVP does *not* support manual layer creation in-app.

**3. Revision tracking**
- A project has an ordered list of revisions; each revision is an immutable snapshot of plans + layers at publish time.
- Architects/PMs publish a new revision by uploading a new DWG; system processes it through APS, diffs layers against the previous revision, and marks the prior revision as superseded.
- Every user can see which revision they are viewing and how it differs from the previous (at the layer level — e.g., "Plumbing layer changed").
- Users who are *affected* by changes in a revision (per their assigned discipline) get a notification and must acknowledge before the system considers them "current."

**4. Comments and annotations**
- A user can pin a comment to a coordinate on a specific revision + layer.
- A comment has: author, timestamp, text body, optional attachment (image), thread of replies, status (open / resolved).
- Comments are visible to everyone with access to the project; resolution requires the original author or a PM.
- Comments survive across revisions: if a comment's anchor is on a layer that changed in a new revision, the comment is flagged as "needs review on new revision" rather than silently moved or lost.

**5. Notifications**
- Triggered by: new revision affecting your discipline, new comment mentioning you, comment on your layer, approval request directed at you, status change on your comment.
- Delivered in-app (real-time via WebSockets) and via email (digest + immediate for approvals).
- Per-user notification preferences (immediate / digest / off) per event type.

**6. Approvals**
- A PM or architect can request approval on a specific revision or layer-scope from one or more named approvers.
- Approver sees a queued task; can approve, reject (with required comment), or request changes.
- Approval state is recorded immutably against the revision.
- A revision can be marked "approved for construction" only after all required approvers have approved.

## Out of scope

- CAD editing of any kind. NoBavel does not modify geometry.
- BIM authoring (Revit-style model creation).
- 3D model viewing in MVP — 2D plans only. (3D APS view is on the roadmap; not v0.1.)
- IFC support — DWG only for MVP.
- Scheduling, Gantt charts, budget/cost tracking, RFIs, submittals as formal workflow objects.
- Native mobile apps (iOS/Android). MVP is delivered as a responsive web app installable as a PWA.
- Full offline editing. MVP supports *graceful* connectivity loss (reconnect, retry, queued comment send) but not authoring an entire revision offline.
- Desktop-polished experience. Desktop is supported as a debugging/admin surface only — layout and interactions are tuned for tablet first, mobile second.
- AI-assisted clash detection or auto-conflict resolution.
- Public/external sharing (anonymous viewer links).
- White-labeling / multi-tenant theming.
- SSO / enterprise IdP integration beyond email + password. (SAML/OIDC on roadmap.)

## Main user flow

**Primary flow — Architect publishes a revision; trades acknowledge and comment.**

1. **Entry.** Architect opens NoBavel, selects their project, lands on the spatial plan viewer showing the current revision.
2. **Publish.** Architect clicks "Publish revision," uploads the new DWG. System enqueues an APS Model Derivative job (BullMQ) to translate the file and extract layer metadata.
3. **Processing.** Architect sees an in-progress state; receives a notification when translation completes (typically minutes, not seconds — set expectation in UI). System diffs the new revision's layers against the previous and identifies affected disciplines.
4. **Notification fan-out.** Every user assigned to an affected discipline gets an in-app + email notification: "Revision 3 published — Electrical layer changed."
5. **Trade reviews.** An electrician opens the notification → lands on the viewer at the new revision with only the Electrical sub-tree of layers expanded → can see what changed visually and via a layer-diff side panel.
6. **Trade comments / acknowledges.** Electrician either acknowledges ("seen, no concern") which clears their notification, or pins a comment to a specific coordinate ("conflict with HVAC duct here") which opens a thread.
7. **Resolution branch.** Architect receives the comment notification; replies, or if resolution requires a revision, the cycle returns to step 2.
8. **Approval gate.** PM requests approval on the revision from the named approvers (e.g., the structural engineer and owner). Each approves/rejects with comment. Once all required approvers approve, the revision is marked "approved for construction."

**Failure / edge states:**

- DWG translation fails (corrupt file, unsupported feature) → architect sees a clear error with reason; previous revision remains current.
- User opens a comment whose anchor layer no longer exists in the current revision → comment is shown with a "needs review — anchor layer changed" badge.
- Notification fan-out fails for a user (bad email, etc.) → in-app notification still delivered; failure surfaced to PM in an admin view.
- Two users edit the same comment thread simultaneously → WebSocket-pushed updates with last-write-wins on the comment body, append-only on replies.

## Requirements

### Functional

- The system must render a 2D plan from a DWG file using Autodesk APS Viewer.
- The system must allow users to pan, zoom, and fit-to-screen on the plan.
- The system must extract layer metadata from the source CAD file and present it as a hierarchical tree (discipline → sub-system → element type).
- The system must allow per-user toggling of layer visibility, and persist that state per user per project.
- The system must support uploading a new DWG as a new revision, asynchronously translating it via APS Model Derivative API.
- The system must produce a layer-level diff between consecutive revisions.
- The system must allow a user to switch between historical revisions of a plan.
- The system must allow a user to pin a comment to a coordinate on a specific revision and layer, with text body and optional image attachment.
- The system must support threaded replies on comments and an open/resolved status.
- The system must propagate comments forward across revisions, flagging comments whose anchor layer changed as "needs review."
- The system must deliver in-app notifications in real time (WebSocket) and email notifications (immediate for approvals, digest configurable for other types).
- The system must allow each user to configure notification preferences per event type.
- The system must support requesting approval on a revision from one or more named approvers and recording each approver's decision.
- The system must mark a revision "approved for construction" only after all required approvers have approved.
- The system must enforce role-based permissions: PM, architect, trade, inspector, owner — with the rules described in *Target users*.
- The system must record an immutable audit log of revision publishes, approvals, and resolution events.

### Non-functional

- **Performance (tablet target).** Initial plan view (cached revision) must render to interactive in under 4 seconds on a mid-tier tablet (iPad 9th gen / equivalent Android) over LTE for plans up to 20 MB. Desktop is faster as a side effect, not as a target.
- **Touch.** All primary interactions must work via touch alone: pan, pinch-zoom, layer toggle, comment pin, approval tap. No interaction may require hover or right-click.
- **Touch targets.** Minimum 44pt hit area on all interactive elements; spacing tuned to be reliable with gloves.
- **Outdoor legibility.** Color contrast meets WCAG AA at minimum, AAA on critical state indicators (notification badges, approval status, revision currency).
- **Connectivity.** Treat reconnect as a normal state. WebSocket disconnect/reconnect must be silent under 30s of outage; pending user actions (comment send, acknowledgment, approval) are queued locally and replayed on reconnect.
- **Real-time.** WebSocket notifications must reach connected clients in under 2 seconds from the triggering event (when connected).
- **APS processing.** DWG translation is async; UI must clearly communicate processing state and not block other work.
- **Availability.** 99.5% monthly availability target for the API and viewer. Notifications best-effort but with retry (BullMQ).
- **Scale (v0.1 target).** Up to 100 concurrent projects, up to 50 concurrent users per project, up to 100 revisions per project. Larger projects deferred.
- **Security.** All project data isolated per organization; no cross-tenant data leakage. S3 objects served via signed URLs only.
- **Auditability.** Revision publish, approval, and resolution events are append-only and timestamped.
- **Strict TypeScript end-to-end.** Shared types between Next.js frontend and NestJS backend; no `any`.
- **Modularity.** Backend is domain-modular (projects, revisions, layers, comments, notifications, approvals). No cross-module reach-arounds.
- **Device / browser support.** **Primary:** Safari on iPadOS (latest two majors), Chrome on Android tablets (latest two majors). **Secondary:** Mobile Safari on iPhone, Chrome on Android phones. **Bonus (debug/admin):** latest Chrome / Edge / Safari / Firefox on desktop.
- **Layout.** Tablet landscape is the canonical canvas; tablet portrait must work without feature loss. Phone is one-column with sheets and bottom-anchored actions. Desktop reuses tablet layout at a max content width.

### Permissions

| Role | View | Comment | Acknowledge | Publish revision | Request approval | Approve | Resolve comment |
|---|---|---|---|---|---|---|---|
| Project Manager | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ (if named) | ✓ |
| Architect | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ (if named) | ✓ |
| Trade contractor | ✓ (own disciplines + shared) | ✓ | ✓ | — | — | — | ✓ (own comments) |
| Inspector | ✓ | ✓ | ✓ | — | — | ✓ (if named) | ✓ (own comments) |
| Owner / Developer | ✓ | ✓ | — | — | — | ✓ (if named) | — |

## Acceptance criteria

Each criterion is observable and pass/fail.

- **A1. Plan loads (tablet).** Given a valid uploaded DWG, when a user opens the project on a mid-tier tablet (iPad 9th gen / equivalent Android) over LTE, the 2D plan renders in the viewer with pinch-zoom and two-finger-pan working, in under 4s for a 20 MB plan.
- **A1b. Touch-only navigation.** Given a tablet or phone user, every primary action (pan, zoom, layer toggle, pin comment, send approval) is reachable using touch alone, with no reliance on hover or right-click.
- **A2. Layer tree visible.** Given an uploaded DWG with layer metadata, the layer tree displays as a hierarchical tree, and toggling any node hides/shows the corresponding geometry.
- **A3. Layer state persists.** Given a user has toggled specific layers off, when the user reloads the project, the same layers remain off.
- **A4. Revision publish triggers async job.** Given an architect uploads a new DWG, the system enqueues an APS Model Derivative job and shows in-progress UI; on completion, the new revision becomes selectable.
- **A5. Layer diff displayed.** Given a new revision exists, when a user views it, a panel lists which layers changed vs. the prior revision.
- **A6. Affected users notified.** Given a new revision changes a layer assigned to discipline X, every user with discipline X receives both an in-app and email notification within 2s (in-app) / 60s (email).
- **A7. Comment pin works.** Given a user clicks a coordinate in comment mode, a comment is created anchored to that coordinate + current revision + current layer.
- **A8. Comments persist across revisions.** Given a comment on revision N, when revision N+1 is published, the comment is visible in N+1; if its anchor layer changed in N+1, the comment shows a "needs review" badge.
- **A9. WebSocket real-time.** Given user A pins a comment, user B (currently viewing the same plan) sees the new pin within 2s without page reload.
- **A10. Approval gate.** Given a revision has 3 named approvers, the revision shows "approved for construction" only after all 3 have approved; if any rejects, the revision is marked "rejected" with the reason.
- **A11. Audit log.** Given any revision publish, approval, or resolution event, an audit entry exists with user, timestamp, event type, and target id, and is retrievable via the admin view.
- **A12. Role enforcement.** Given a trade contractor user, attempting to publish a revision via the API returns 403; the UI hides the action.
- **A13. Failure surfaced.** Given a DWG translation job fails, the user who uploaded it sees the error reason within the project view and the previous revision remains current.
- **A14. Notification preferences honored.** Given a user sets "comment-on-my-layer" to digest, they receive that event only in the daily digest email, not as an immediate email.
- **A15. Reconnect is silent.** Given a tablet user loses WebSocket connectivity for up to 30 seconds, the UI does not display a disruptive error; any pending user action (comment send, acknowledgment, approval tap) is queued locally and replayed on reconnect.
- **A16. Trades no-training test.** In a moderated usability test with at least 5 trade-contractor participants (mix of electrician / plumbing / HVAC / paving / glazing / flooring) who have never seen the product, ≥ 4 of 5 complete the daily workflow (open project → find their layers → see what changed → pin a comment → acknowledge revision) within 5 minutes, with **no facilitator intervention**. Re-run before every release.

## Success metrics

Quantified targets for v0.1 success, measured 90 days after first paying project goes live.

- **Adoption breadth.** ≥ 80% of named project members log in at least once per week during active construction phases.
- **Revision currency.** ≥ 95% of revision-acknowledgment notifications are acknowledged within 48 hours of publish.
- **Spatial commenting share.** ≥ 70% of project communication on coordination issues happens as in-app comments (self-reported by PM at end-of-project survey) vs. email/WhatsApp.
- **Trades time-to-first-value.** A new trade-contractor user (electrician / paving / plumbing / HVAC / glazing / flooring) completes the full daily workflow — open project, find their layers, see what's changed, leave a spatial comment, acknowledge the current revision — within **5 minutes** of receiving their invite, **with no training session or tutorial**, measured via funnel telemetry.
- **Trades stickiness.** ≥ 70% of invited trade-contractor users return on day 7 and again on day 14 without a nudge from the PM.
- **Trades NPS.** Onboarding NPS from trade users ≥ 50 at 30 days after invite (separate measurement from PM / architect NPS).
- **Coordination defects.** PM-reported coordination-related rework events drop by ≥ 30% vs. their last comparable project (self-reported baseline).
- **System.** Plan-load p95 ≤ 3s; WebSocket event delivery p95 ≤ 2s; monthly availability ≥ 99.5%.

Targets are **proposed**; calibrate after pilot data — see Open questions.

## Risks

| Risk | Type | Severity | Mitigation |
|---|---|---|---|
| Trades won't adopt the app because it feels like CAD software they've avoided their whole career. Without trade adoption the platform's whole premise fails. | Product | **Critical** | Simplicity-for-trades is goal #1 (see Goals). Every release runs the A16 no-training usability test on real trades before ship. If a release fails A16, it does not ship. UI copy avoids CAD terminology entirely (no "viewport," "plot," "xref" — say "view," "plan," "linked drawing"). |
| Users default back to email/WhatsApp because the spatial-comment habit doesn't form. | Product | **High** | Make notifications and digest emails the primary entry point — every email links directly to the spatial pin. Measure spatial-commenting share weekly and intervene at pilot accounts. |
| Layer hierarchy derived from CAD file metadata is inconsistent across architects/firms — same discipline modeled with different layer names — making the discipline-routing logic unreliable. | Product / Data | **High** | MVP: per-project layer-to-discipline mapping UI for PMs. Document the limitation explicitly. Post-MVP: layer-name normalization. |
| APS Model Derivative API latency or quota becomes a bottleneck (jobs queue up; users wait minutes). | Technical | Medium | Aggressive BullMQ retries with backoff; transparent in-UI progress; pre-translate on upload, not on first view; monitor APS quota and alert. |
| WebSocket scaling pain at higher concurrent-user counts in a single project (50+ users simultaneously). | Technical | Medium | Redis pub/sub fan-out from the start (don't shortcut with in-process emitters); load-test the 50-user-per-project target before launch. |
| UX feels CAD-like despite intent because designers default to familiar patterns. | UX | Medium | Hard rule: every UI review uses the GIS/Figma reference, not any CAD product. Recruit one non-CAD-literate user (e.g., owner/developer persona) into every usability test. |
| Designers default to desktop-first habits and produce layouts that only work well on desktop. | UX / Delivery | **High** | Every design review and usability test runs on a physical tablet first, then a phone. No screen is signed off purely from a desktop browser. |
| Tablet performance on large DWGs is worse than expected; APS Viewer chokes on mid-tier iPads. | Technical | **High** | Benchmark on a target-tier iPad and a target-tier Android tablet before locking the viewer integration; degrade gracefully (simplified rendering tier) if needed. |
| Site connectivity is more unreliable than the "intermittent" assumption — users lose 30s+ frequently. | Technical / Product | Medium | Make reconnect silent under 30s; surface a clear, non-blocking "reconnecting" affordance beyond that; queue user actions locally regardless. Revisit offline-edit scope post-MVP based on telemetry. |
| Outdoor sunlight and gloved use make subtle UI affordances unreadable / untappable. | UX | Medium | Enforce AA contrast minimum, AAA on status indicators; 44pt touch targets; field-test on a sunny day with at least one gloved user. |
| Approval flow ambiguity: "approved for construction" is treated by some users as legally binding sign-off without legal review of what that phrase implies. | Delivery / Legal | Medium | Use neutral copy ("approved") and surface a per-project disclaimer; explicitly clarify in onboarding that this is coordination, not legal sign-off. Open question for legal review. |
| Scope creep into RFI/submittal/scheduling territory mid-build. | Delivery | Medium | This PRD is the contract; new asks become v0.2 candidates with their own PRD. |
| DWG-only at launch limits addressable market (large clients use Revit/IFC). | Product | Medium | Document explicitly as MVP constraint; IFC roadmap commitment communicated to design partners. |
| Pilot customer's first project is too large/complex and fails to demonstrate value. | Delivery | Medium | Define a "good first project" profile (≤ 5 disciplines, ≤ 20 layers per discipline, mid-rise residential or small commercial); recruit pilots that match. |
| Per-tenant data isolation bug leaks plans across orgs. | Security | **High** | Tenant scoping enforced at the repository/data-access layer (not just route guards); add automated cross-tenant access tests in CI. |

## Open questions

The following materially affect scope, design, or success metrics and need answers before or during the design phase:

1. **Pilot customer profile.** Who is design-partner-1? A specific named GC, architect firm, or developer would calibrate everything (project size, layer conventions, approval rituals).
2. **Discipline-to-layer mapping authority.** Who owns the mapping per project — PM, architect, or NoBavel admin? MVP defaults to PM, but this needs validation with a real architect.
3. **Approval semantics.** Is "approved for construction" legally meaningful in any jurisdiction we're targeting? Need legal review of copy and audit-log retention requirements.
4. **Audit log retention.** How long must audit data be retained? Industry-typical is 7+ years for construction; this materially affects storage and archival design.
5. **PWA installability.** Tablet is primary — do field users need an installable PWA (add-to-home-screen, standalone shell, push notifications) at launch, or is a regular browser tab acceptable for v0.1?
5a. **Android tablet share.** What proportion of target field users are on Android tablets vs. iPad? This affects how much Chromium/Android-specific testing we invest in for v0.1.
5b. **Offline-edit depth.** "Graceful connectivity loss" is in scope, but full offline authoring of a revision is not. If pilot data shows users frequently lose connectivity for >5 minutes on site, this scope decision must be revisited.
6. **Identity / SSO.** Email + password for MVP, but how soon do enterprise pilots require SAML/OIDC? Affects backend identity architecture choice today.
7. **Pricing model.** Per-seat, per-project, per-organization? Doesn't block MVP build but blocks Stripe/billing scope decisions.
8. **DWG layer metadata reliability.** What % of real-world DWGs we'll receive have clean, parseable layer metadata vs. ad-hoc naming? Needs a sample of 10–20 real files from a design partner.
9. **Notification channels beyond email.** SMS for approvals? Slack/Teams integration? Out of scope for v0.1 but signal interest now.
10. **Success-metric baselines.** Coordination-rework "30% reduction" needs a baseline from the pilot's prior project — how do we collect it?
11. **3D viewer urgency.** Is the absence of 3D a deal-breaker for any prospective pilot? If yes, scope shifts.
12. **Comment migration on revision.** When an anchor layer changes, "needs review" is the MVP behavior. Should we attempt automated re-anchoring (nearest-coordinate) post-MVP, or keep it explicit forever?

## Handoff to architecture / UX

### Obvious entities

- `Organization` (tenant boundary)
- `Project` (belongs to Organization; has many Members, Revisions)
- `Member` (User × Project × Role × Disciplines[])
- `User` (identity; cross-org)
- `Role` (PM, Architect, Trade, Inspector, Owner)
- `Discipline` (Architectural, Structural, Electrical, Plumbing, HVAC, Glazing, Paving, Flooring, …) — extensible
- `Revision` (belongs to Project; immutable snapshot; status: processing | ready | superseded | approved | rejected)
- `Layer` (belongs to Revision; hierarchical; mapped to a Discipline)
- `LayerDiff` (computed between consecutive Revisions; per-layer change record)
- `Comment` (belongs to Revision + Layer; anchored to coordinate; threaded)
- `CommentReply`
- `Notification` (User × event × channel × delivery state)
- `NotificationPreference` (User × event type × channel × mode)
- `Acknowledgment` (User × Revision)
- `ApprovalRequest` (Revision × required Approvers[])
- `ApprovalDecision` (ApprovalRequest × Approver × decision × comment)
- `AuditLog` (append-only event stream)
- `Attachment` (S3 object reference; signed-URL served)

### Likely screens / surfaces

- **Project switcher / dashboard** — list of projects with role badges and unread/unack counts.
- **Spatial plan viewer** (the central surface) — APS Viewer canvas + map-style chrome + layer tree panel + revision selector + comment panel.
- **Layer tree** — hierarchical, multi-level toggle, per-discipline filter, per-user persisted state.
- **Revision history** — vertical timeline of revisions with diff summaries; click to switch.
- **Layer-diff panel** — what changed between current revision and previous.
- **Comment thread overlay / side panel** — pinned to a coordinate; replies; resolve action.
- **Notifications center** — in-app real-time list; preferences sub-screen.
- **Approvals queue** — "approvals pending you" + "approvals you've requested."
- **Project admin** — members, role assignment, discipline-to-layer mapping, notification policy defaults.
- **Audit log viewer** — admin-only.

### Roles and permissions

See the table in *Requirements → Permissions*. Architectural note: enforce at the repository/data-access layer with tenant + role + discipline scoping, NOT only at the HTTP guard. Route guards remain as a defense-in-depth layer.

### External integrations

- **Autodesk APS** — Model Derivative API (DWG → SVF/SVF2 translation), Viewer SDK (frontend rendering). OAuth 2-legged for service-to-service.
- **AWS S3** — storage for uploaded DWGs and comment attachments; signed URLs for delivery.
- **Email provider** (SES or similar) — transactional + digest emails.
- **(Future)** IFC import, SAML/OIDC IdP, Slack/Teams notifications.

### Suggested architecture questions to resolve

1. **APS job orchestration.** BullMQ worker per-project queue or shared? How do we handle APS rate limits and retries cleanly?
2. **WebSocket fan-out.** Single Socket.IO/native WS layer in front of NestJS, with Redis pub/sub for cross-instance? Confirm the topology before any UI work depends on it.
3. **Layer-diff computation.** Where does it run — inline post-translation in the BullMQ worker, or lazy on first view? Inline is simpler and is the recommended default.
4. **Comment coordinate model.** APS gives us a coordinate space per drawing; we need to stably reference coordinates across revisions even when geometry shifts. Define the coordinate-anchor schema (model space coordinates + layer ref) explicitly.
5. **Tenant isolation enforcement strategy.** Postgres row-level security vs. application-layer scoping vs. both? Recommend both; finalize before any data-access code is written.
6. **Audit log storage.** Same Postgres database (append-only table) or separate event store? Same DB is fine for MVP; design for migration.
7. **Notification delivery pipeline.** Single BullMQ queue for all notification events with channel fan-out workers, or per-channel queues? Recommend single event queue, per-channel workers.
8. **Authentication.** Email + password for MVP via NestJS Passport; build with a clean abstraction so SAML/OIDC can be added without rewriting session handling.
9. **APS viewer integration boundary.** The viewer is heavy JS; isolate it behind a thin React component with a typed prop contract so the rest of the app remains unaware of APS internals.
10. **Realtime state reconciliation.** Zustand store + WebSocket events: define the event schema and reconciliation rules (last-write-wins for comment body, append-only for replies, idempotent for acknowledgments) before the UX agent designs interactions that depend on this.
11. **APS Viewer on tablet.** Validate frame-rate and memory behavior on iPad 9th gen / mid-tier Android tablet with a representative 20 MB DWG before committing to the viewer integration shape. Identify a fallback rendering tier if needed.
12. **PWA shell.** Even if installability is deferred from v0.1, build the app behind a clean service-worker-friendly boundary so the upgrade does not require restructuring.
13. **Action queue.** Comment send, acknowledgment, and approval tap must each be idempotent at the API level and queue-replayable on the client. Define the client-side action queue early — Zustand middleware + a typed envelope per action — so feature work doesn't have to invent it ad-hoc.
14. **Touch gesture layer.** Pinch / two-finger pan / single-tap pin / long-press context — decide whether to ride on APS Viewer's gesture handling, layer our own on top, or both. Lock the gesture map before any UX work on the viewer.

### Handoff sequence

1. **UX agent** picks up *Main user flow* + *Likely screens* and produces flow diagrams + low-fidelity wireframes for the spatial viewer, layer tree, comment pin, revision switcher, and approvals queue. **All wireframes are produced at tablet landscape first, tablet portrait second, phone third. Desktop is derived, not designed.**
2. **Tech-lead architecture agent** picks up *Obvious entities* + *Architecture questions* and produces the module map, data model, API contract, and the answers to questions 1–10 above.
3. **PRD owner** revisits *Open questions* with design-partner input before either agent locks decisions that depend on those answers.
