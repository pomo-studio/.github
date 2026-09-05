# Contributing

Open an issue for substantial interface or architectural changes before implementation. Include the module version, Terraform/provider versions, expected behavior, and a minimal reproduction. Do not include credentials, state, saved plans, account details, or personal data.

## Terraform Modules

- Keep changes focused and preserve compatibility unless a breaking change is explicitly agreed.
- Run `terraform fmt -check -recursive`. Follow the repository's mock-test conventions and CI validation matrix.
- Generate the README interface with terraform-docs **v0.20.0** (`terraform-docs .`); CI checks for drift. Keep prose outside `BEGIN_TF_DOCS` / `END_TF_DOCS`.
- Provider aliases must be wired in examples. Regional resources must support primary/DR deployment and document stateful recovery limitations.
- Use `moved` / `removed` blocks for resource address changes and document consumer migrations. An upgrade plan must reject unexpected destroys, replacements, and state removal.
- Update the changelog for behavioral changes and explain testing, compatibility, and migration evidence in the PR.

## Validation Is Not Deployment

Credential-free CI initialization (`-backend=false`), validation, linting, and mock tests check syntax and contracts. They do **not** establish that an example plans against AWS or that deployed behavior works.

Use existing, approved non-production Terraform Cloud workspaces for real plans. Only trusted, maintainer-reviewed commits may run with cloud credentials, including speculative plans: Terraform configuration can execute code during planning. Do not use `pull_request_target` to execute PR code, expose secrets to fork PRs, or run infrastructure plans/applies locally or in GitHub Actions.

Record the exact commit, example, workspace, configuration version, run URL, plan result, and whether state existed. A fresh-state plan is not an upgrade test. An upgrade test additionally needs an established previous-tag state and reviewed, exact-address migration exceptions. Raw plan JSON and state are sensitive; keep them out of issues, PRs, logs, and artifacts.

Applies, destroys, state surgery, new workspaces, and expanded IAM permissions require separate explicit authorization. No automatic apply/destroy is part of maintenance CI. Never substitute a production smoke check or an unrelated latest run for candidate-specific evidence.

## Releases And Dependencies

Weekly Dependabot PRs group minor/patch updates and limit queue size. Terraform major updates are intentionally excluded: propose compatibility changes explicitly and test them. Action majors remain individually reviewable. No dependency updates are auto-merged.

Hygiene changes do not require a module release. Module tags must use the maintained `pomo-release.sh` release script, not bare `git tag`. Release gates require a confirmed root cause, tests, a changelog entry, migration safety, and applicable integration evidence. A green syntax check alone does not meet a live-integration gate.
