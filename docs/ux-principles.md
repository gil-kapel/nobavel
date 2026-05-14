# UX Principles

The UX should feel closer to:

- ArcGIS
- Google Maps
- Figma collaboration

NOT traditional CAD software.

Device priority:

- tablet first (primary — field, site trailer, design review)
- mobile second (quick checks, notifications, approvals on the go)
- desktop is a bonus, used mainly for debugging and admin

Tablet-first implications:

- design for touch first; no hover-only affordances
- minimum touch target 44pt; spacing tuned for gloved fingers
- landscape is the default canvas; portrait must work but is not primary
- pinch / two-finger pan for the spatial viewer; momentum scrolling
- legible in direct sunlight; high contrast, no thin gray text
- performance budget targets mid-tier tablet hardware, not desktop GPUs
- assume intermittent connectivity; treat reconnect as a normal state, not an error

Mobile-second implications:

- focus on read-and-act flows: notifications, comment replies, approval taps
- not every screen needs full feature parity on phone
- one-column layouts; sheets and bottom-anchored actions

Core UX principles:

- spatial clarity
- smooth navigation
- minimal complexity
- hierarchical layers
- realtime collaboration
- map-style interactions
- progressive detail reveal

Avoid:

- CAD ribbon toolbars
- cluttered engineering UI
- editing-heavy workflows
- desktop-first patterns: dense menubars, right-click affordances, tiny click targets
