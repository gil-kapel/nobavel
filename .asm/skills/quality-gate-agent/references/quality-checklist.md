# Quality Checklist

Run checks in this order:

1. correctness and regressions
2. security, permissions, and data exposure
3. data integrity and validation
4. missing tests on critical paths
5. maintainability and cleanup

For each finding, always include:

- what is wrong
- why it matters
- where it appears (`file:line`)
- minimal fix direction

Test planning rules:

- Map each test case to either a finding ID or acceptance criterion ID
- Prefer the cheapest level that proves behavior (unit -> integration -> component -> e2e)
- Prioritize critical/high-risk behavior first
- Include at least one negative/error-path test

Release gate rules:

- No unresolved critical findings
- High findings must be fixed or explicitly accepted with owner/date
- One high-risk automated test added or updated for changed critical behavior
- Open questions listed explicitly (do not hide assumptions)
