# pomo-studio TODO

Organization-wide follow-ups. Capture things here rather than leaving them in chat.

**Last updated**: 2026-09-13
**State**: all 14 module repos green on `terraform.yml` and `readme-quality`; no open PRs.

---

## Dependency maintenance (Dependabot)

- [ ] **Verify the shared automation end-to-end on the next real bump.** Especially a README-changing one on `serverless-ssr`: docs regenerated, commit pushed with `MAINTENANCE_TOKEN`, required checks re-triggered, auto-merge completes with no nudge.
- [ ] **Decide whether dependency *majors* should auto-merge.** `.github/dependabot.yml` ignores Terraform majors but not GitHub Actions majors, so major action bumps (e.g. `actions/checkout` 4 to 7, `setup-go` 5 to 7, `lychee-action` 1 to 2) merge automatically. If majors should be reviewed, ignore action majors in the config or stop auto-merging them.
- [ ] **Keep `terraform_docs_version` in sync.** The shared workflow's input (default `0.20.0`) must match each repo's pinned version in `.terraform-docs.yml`.

## Security / credentials

- [ ] **Replace `MAINTENANCE_TOKEN` with a least-privilege fine-grained PAT.** It is currently the personal `gh` OAuth token (broad scopes: `delete_repo`, `repo`, `workflow`), stored as a repository secret on `serverless-ssr` only. Prefer a fine-grained PAT with Contents: read/write and Pull requests: read/write, limited to the module repos.
- [ ] **Optional: promote it to an organization secret** named `MAINTENANCE_TOKEN`. Requires `gh auth refresh -s admin:org` first (the current token has only `read:org`).

## CI / branch protection

- [ ] **`serverless-ssr` required checks.** Now requires `checker`, `validate (examples/basic)`, `validate (examples/complete)` with `strict` off. Revisit whether the path-filtered checks (`Validate (.)`, `Format Check`, `Lint`, `Docs Check`) should be made always-run and added as required.
- [ ] **Consider the same required-checks model for the other module repos** if branch protection is added. If so, they will likely need the `MAINTENANCE_TOKEN` secret too.
- [ ] **Address the GitHub Actions Node.js 20 deprecation.** Several pinned actions still target Node 20 and are force-run on Node 24; bump them across repos.

## Design

- [ ] **Inject the blueprint blue more widely, carefully.** A `::selection` tint was tried and reverted, because users preferred the default. Remaining candidates, all hairline or state details rather than colored type or filled areas: frame the illustrations in blueprint blue, a thin accent rule under the header, an active-nav underline, and accent focus rings.

## README quality

Live and enforced. The standard is in `pomo-studio/.github` (`docs/README-GUIDE.md`, `templates/README.template.md`, `.markdownlint-cli2.jsonc`, `.vale.ini` + `styles/pomo`, `scripts/check-readme-sections.sh`, reusable `readme-quality` workflow). All 14 module READMEs are in the canonical layout, including when-to-use, design decisions, and examples, and the checks block (`strict: true`). The sections check requires an intro/usage heading, a Design decisions section, and the generated reference.

- [ ] **Start new modules from `templates/README.template.md`.**
- [ ] **Update the shared standard when the house style changes.** Callers pick it up automatically.

## Recently done (for context)

- Reworked the pomo.dev information architecture to Patterns / Blueprints / Components, with 301 redirects from the old routes.
- Added or redrew the site illustrations: home hero (clean line art), components tray (isometric solids), patterns triptych (isometric), and the materialized-view projection.
- Fixed the CloudFront invalidation path list in `pomo-dev`'s deploy script (it missed route indexes such as `/patterns` and named the retired `/compositions` route); it now invalidates `/*`.
- Enabled Dependabot plus squash auto-merge across 14 module repos via a shared reusable workflow in `pomo-studio/.github`.
- Closed 13 stale maintenance PRs; merged the one genuinely behind (`event-consumer`).
- Fixed the broken `terraform-docs` Docs Check (`args: --check` is an unsupported flag; switched to `fail-on-diff`) in `serverless-ssr` and `cognito-auth`.
- Removed a stale required check (`CloudFront -> Lambda GET`) that was blocking `serverless-ssr` merges.
- Made the AppSync integration test `workflow_dispatch` only, refreshed its Terraform Cloud token, and verified a full apply and destroy succeeds.
- Deleted the stale `chore/module-maintenance` branches left by the closed PRs.
