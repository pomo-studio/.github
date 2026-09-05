## Change

Describe the problem, confirmed root cause, and focused solution.

## Compatibility And Safety

- [ ] Interface/default/provider-constraint changes are explained.
- [ ] Resource address changes have migration support and reviewed upgrade evidence.
- [ ] IAM, credentials, DR, and cost implications are documented.
- [ ] No secrets, raw plans/state, or production infrastructure changes are included.

## Evidence

Record exact commands/results and commit/run links. Mark unavailable checks as blocked, not passed.

- Formatting, validation, lint, and mock tests:
- Generated docs drift/idempotence:
- Terraform Cloud example plan (workspace, commit, run, existing/fresh state):
- Previous-tag upgrade plan (baseline and candidate, authorized exceptions):
- Deployed integration test, if applicable:

## Release

- [ ] Changelog updated for behavioral changes, or hygiene-only/no release needed.
- [ ] Any future tag will use the release script and applicable ADR gates.
