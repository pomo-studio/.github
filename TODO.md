# pomo-studio TODO

Organization-wide follow-ups. Capture things here rather than leaving them in chat.

**Last updated**: 2026-09-13

---

## Dependency maintenance (Dependabot)

- [ ] **Verify the shared automation end-to-end on the next real bump.** Especially a README-changing one on `serverless-ssr`: docs regenerated, commit pushed with `MAINTENANCE_TOKEN`, required checks re-triggered, auto-merge completes with no nudge.
- [ ] **Decide whether dependency *majors* should auto-merge.** `.github/dependabot.yml` ignores Terraform majors but not GitHub Actions majors, so major action bumps (e.g. `actions/checkout` 4 to 7, `setup-go` 5 to 7, `lychee-action` 1 to 2) merge automatically. If majors should be reviewed, either ignore action majors in the config or stop auto-merging them.
- [ ] **Keep `terraform_docs_version` in sync.** The shared workflow's input (default `0.20.0`) must match each repo's pinned version in `.terraform-docs.yml`.

## Security / credentials

- [ ] **Replace `MAINTENANCE_TOKEN` with a least-privilege fine-grained PAT.** It is currently the personal `gh` OAuth token (broad scopes: `delete_repo`, `repo`, `workflow`), stored as a repository secret on `serverless-ssr` only. Prefer a fine-grained PAT with Contents: read/write and Pull requests: read/write, limited to the module repos.
- [ ] **Optional: promote it to an organization secret** named `MAINTENANCE_TOKEN`. Requires `gh auth refresh -s admin:org` first (the current token has only `read:org`).

## CI / branch protection

- [ ] **`serverless-ssr` required checks.** Now requires `checker`, `validate (examples/basic)`, `validate (examples/complete)` with `strict` off. These were chosen because they run on every PR. Revisit whether the path-filtered checks (`Validate (.)`, `Format Check`, `Lint`, `Docs Check`) should be made always-run and added as required.
- [ ] **Consider the same required-checks model for the other module repos** if branch protection is added. If so, they will likely need the `MAINTENANCE_TOKEN` secret too.
- [ ] **Remove the leftover `chore/module-maintenance` branches** from the 12 closed stale PRs (optional tidy-up).
- [ ] **Address the GitHub Actions Node.js 20 deprecation.** Several pinned actions still target Node 20 and are force-run on Node 24; bump them across repos.

## Recently done (for context)

- Enabled Dependabot plus squash auto-merge across 14 module repos; added the shared reusable workflow in `pomo-studio/.github`.
- Closed 13 stale maintenance PRs; merged the one genuinely behind (`event-consumer`).
- Fixed a broken `terraform-docs` check in `serverless-ssr` (`--check` was an unsupported flag; switched to `fail-on-diff`).
- Removed a stale required check (`CloudFront -> Lambda GET`) that was blocking all `serverless-ssr` merges.
