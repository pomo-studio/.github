# Module Testing

How a pomo-studio Terraform module is tested, from a lint check to a live apply
and destroy. Three tiers, each answering a different question.

## The three tiers

| Tier | When | Credentials | Question it answers |
|------|------|-------------|---------------------|
| Static | Every push and pull request | None | Does it parse, conform, and match its generated docs? |
| Offline unit tests | Every pull request | None | Does the interface and composition hold together? |
| Live acceptance | Dispatch, on demand | Terraform Cloud holds them | Does it still stand up against real AWS? |

Static is `terraform fmt -check`, `terraform init -backend=false` plus
`terraform validate`, tflint, and the `terraform-docs` drift check, in the
repository's `terraform.yml`.

Offline tests are `terraform test` runs with `mock_provider`, so they need no
AWS credentials. They live in `tests/*.tftest.hcl` and run as the `test` job in
`terraform.yml`. They pin defaults, count resources, and check that validation
rejects bad input. They do not call AWS.

Live acceptance applies a self-contained `examples/live` against a real account
and then destroys it. It runs in Terraform Cloud, never in GitHub Actions, and
only when a maintainer dispatches it. This is the tier that catches what mocks
cannot: unsupported resource types, IAM and trust, quotas, service limits, and
eventual consistency.

## What live acceptance proves, and what it does not

It proves the module can create its resources in a real account and remove them
without leaving anything behind. It is a fresh-state apply, not an upgrade test:
an upgrade test would start from the previous tag's state. Run live acceptance
before tagging a release, and treat a green run as the release gate for that
version.

## How the workflow runs

`pomo-studio/.github/.github/workflows/module-acceptance.yml` is the reusable
implementation. Each module that has a live example carries a thin caller,
`.github/workflows/acceptance.yml`, which is `workflow_dispatch` only.

On dispatch it resolves the workspace, finds the run Terraform Cloud created for
the dispatched commit, approves it if it is waiting, waits for the apply, then
triggers a destroy run and waits for that. The apply and destroy execute in
Terraform Cloud; the workflow only speaks to the Terraform Cloud API. Cloud
credentials never reach GitHub Actions, and nothing runs automatically.

Set `skip_destroy` only to inspect a failed run, and always destroy it by hand
afterward.

## Setting up an acceptance workspace

One workspace per module that has a live example. The steps assume the Terraform
Cloud organization `Pitangaville` and use `cloudfront-vpc-origin` as the example.

1. **Create the workspace.** Terraform Cloud, organization `Pitangaville`, new
   workspace, version control workflow. Connect the module repository
   (`pomo-studio/terraform-aws-cloudfront-vpc-origin`) on the `main` branch.
2. **Name it** `<module>-acceptance`, for example
   `cloudfront-vpc-origin-acceptance`.
3. **Advanced settings.**
   - Terraform Working Directory: `examples/live`
   - Terraform Version: `1.9.0`, the floor the module declares
   - Apply Method: manual apply, so the workflow's approval is the authorization
4. **Give it AWS credentials.** Prefer dynamic provider credentials: set the
   workspace variables `TFC_AWS_PROVIDER_AUTH=true` and `TFC_AWS_RUN_ROLE_ARN` to
   a role in the sandbox account that trusts Terraform Cloud as an OIDC provider.
   Otherwise add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as sensitive
   environment variables. Use a sandbox account, never production.
5. **Create a token.** A Terraform Cloud team token scoped to the acceptance
   workspaces, or a user token. Store it as the `TF_API_TOKEN` repository secret
   on the module repository.
6. **Dispatch.** Actions, `Live acceptance`, Run workflow. Leave `skip_destroy`
   off.
7. **Confirm.** The apply run reaches `applied`, the workflow triggers a destroy
   run, and the job finishes green. Note the duration and the cost.

The workspace is ephemeral in spirit: it holds the state between the apply and
the destroy of a single acceptance run, and nothing else.

## Adding a live example to a module

Copy the shape of `cloudfront-vpc-origin/examples/live` and `tests/plan.tftest.hcl`.

- [ ] Create `examples/live` with a local module source (`source = "../../"`), so
  the run tests the working commit, not a published version. Registry-sourced
  examples do not work here.
- [ ] Make it self-contained. It creates every prerequisite it needs (network,
  load balancer, buckets, and so on) and takes no external ARN or name.
- [ ] Declare `name` and `region` variables. The workflow sets `TF_VAR_name` to a
  run-specific value, so resources are unique.
- [ ] Tag every resource with `ManagedBy = "module-acceptance"` and
  `AutoDestroy = "true"`.
- [ ] Add the example to the `validate` matrix in `terraform.yml`.
- [ ] Add credential-free `tests/plan.tftest.hcl`.
- [ ] Create the acceptance workspace and the `TF_API_TOKEN` secret.
- [ ] Add `.github/workflows/acceptance.yml` from an existing module.
- [ ] Dispatch once and confirm apply and destroy.

## Current status

| Module | Live example | Acceptance workspace |
|--------|--------------|----------------------|
| cloudfront-vpc-origin | yes | to create |
| cloudfront-frontdoor | yes | to create |
| cloudfront-edge-router | no, still being implemented | no |
| internet-ingress | no, still being implemented | no |
| the other 14 modules | no, examples are `basic`/`complete` | no |

Existing examples are not drop-in ready. Some reference the published module
through the registry, and most expect external inputs. Convert them to local,
self-contained examples before giving them a workspace, module by module, as each
one is next touched or released. The SSR component set, `event-pipeline`, and
`dynamodb-global-table` already use local sources and are the cheapest to
convert.

## Guardrails and cost

- The reusable workflow has a job timeout, 60 minutes by default.
- The destroy run is triggered in the same block as the apply, so a failed apply
  is still cleaned up. A cancelled job can orphan resources, so check the workspace
  after a cancellation.
- Terraform Cloud serializes runs in a workspace, so two dispatches cannot apply
  at the same time. The modules use one workspace each.
- Keep the sandbox small. A CloudFront distribution takes roughly 10 to 20
  minutes to deploy and about as long to remove; the VPC origin example is a few
  minutes.
- Add a budget alarm on the sandbox account, and treat an orphan as an incident
  to clean up by hand.

## Troubleshooting

- **No run found for the commit.** The workspace is not VCS-connected, or the
  commit predates the connection. Reconnect the repository, or dispatch on a
  newer commit.
- **The run is discarded.** A newer push to the workspace superseded it. Dispatch
  again on the current `main`.
- **Plan fails on credentials.** The workspace is missing AWS dynamic provider
  credentials or the static keys.
- **Destroy fails.** Read the run log, fix the dependency, and run a destroy from
  the workspace's Actions menu.
