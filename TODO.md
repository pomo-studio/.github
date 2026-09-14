# pomo-studio TODO

Organization-wide follow-ups. Prefer a GitHub issue over a note here. Internal
operations notes live in the private `pomo-studio/ops` repository.

**Last updated**: 2026-09-13
**State**: 18 module repos (14 established, 4 ingress), all green on
`terraform.yml`. The ingress repos run credential-free `terraform test` suites
and have live acceptance in Terraform Cloud.

## Tracked as issues

- [Verify the shared Dependabot maintenance automation end-to-end](https://github.com/pomo-studio/.github/issues/15)
- [Decide whether dependency majors should auto-merge](https://github.com/pomo-studio/.github/issues/16)
- [Keep the terraform-docs version in sync across modules](https://github.com/pomo-studio/.github/issues/17)
- [Extend the required-checks and branch-protection model to the module repos](https://github.com/pomo-studio/.github/issues/18)
- [Address the GitHub Actions Node.js 20 deprecation](https://github.com/pomo-studio/.github/issues/19)
- [Run readme-quality on the ingress repos](https://github.com/pomo-studio/.github/issues/20)
- [Run module acceptance in a dedicated sandbox account](https://github.com/pomo-studio/.github/issues/21)
- [Inject the blueprint blue in hairline details](https://github.com/pomo-studio/pomo-dev/issues/11)
- [Acceptance: assert the blue/green routing decision](https://github.com/pomo-studio/terraform-aws-internet-ingress/issues/4)

## Where the rest lives

- Internal operations notes, including credentials: the private
  `pomo-studio/ops` repository.
- Module testing runbook: [docs/MODULE-TESTING.md](docs/MODULE-TESTING.md).
- House style and README standard: [docs/README-GUIDE.md](docs/README-GUIDE.md),
  plus the reusable workflows in this repository.
