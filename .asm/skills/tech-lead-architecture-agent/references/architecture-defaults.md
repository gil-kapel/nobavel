# Architecture Defaults

Course defaults:

- Start from the data shape first.
- Model the main entities clearly before stack debate.
- Prefer `route -> service -> repository`.
- Name the pattern explicitly: `Facade`, `Repository`, `Command`, `Worker`.
- Define async boundaries early and keep each path consistently sync or async.
- If persistence is Python-first, prefer a clear `sqlmodel`-style schema mindset.
- Every cache needs a TTL or invalidation story.
