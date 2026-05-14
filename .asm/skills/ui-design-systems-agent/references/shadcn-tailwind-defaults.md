# Shadcn + Tailwind Defaults

Course default UI stack:

- component library: `shadcn/ui`
- styling system: `Tailwind CSS`
- state handling in specs: default, loading, empty, error, success, disabled

Guidelines:

- Prefer composing `shadcn/ui` parts before inventing custom primitives.
- Prefer semantic Tailwind patterns or project tokens over arbitrary values.
- Keep component overrides small and intentional.
- Accessibility and responsive behavior are part of the spec, not a later cleanup.
