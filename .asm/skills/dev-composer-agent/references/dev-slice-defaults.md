# Dev Slice Defaults

Default implementation order:

1. data shape or schema
2. repository or persistence boundary
3. service or command
4. route, handler, or UI
5. verification

Course coding defaults:

- start with the data shape
- keep functions short
- prefer `route -> service -> repository`
- do not mix sync and async in one path
- verify after each meaningful slice
