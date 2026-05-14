# UX Handoff Defaults

Every UX handoff in this course should include:

- User and goal
- Roles and permissions (if multi-role)
- Main journey (numbered steps)
- Failure and edge paths (including cancel/back/undo)
- Screen inventory (table with routes from the architecture handoff)
- State list per screen: empty, loading, populated, error, success, disabled
- Accessibility notes: focus order per screen, screen-reader announcements for state changes, keyboard trap risks
- Analytics events: event name, payload, and success signal per main journey step
- Friction points and UX risks
- Handoff notes for UI and dev

If there are more than 8 flow steps, split into main path plus named secondary paths.

## Minimum quality bar

- Every screen lists a route **and** a human-readable name.
- Every error state includes a proposed user-facing message.
- Every empty state includes proposed placeholder content (not just "no data").
- Every destructive or multi-step action has a documented escape hatch (cancel, back, or undo).
