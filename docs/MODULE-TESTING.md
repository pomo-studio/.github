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

One workspace per module that has a live example. Workspaces are declared in
`pomo-studio/pomo`, not created by hand, so the configuration, the IAM role, and
the trust policy stay in version control. The `appsync-example` workspace is the
model.

1. **Add an OIDC role** in `oidc.tf` under `module "tfc_oidc"`'s `roles` map. Scope
   the trust to one workspace:
   `organization:<org>:project:*:workspace:<name>:run_phase:*`, and give it a
   policy limited to what the example creates. Where resource ARNs carry the
   resource name (load balancer, target group, listener), scope by the
   `acceptance-` prefix; where they do not (VPC, subnet, security group) and for
   CloudFront, the statement is account-wide, which is why the trust is narrow.
2. **Add the workspace** in `terraform_cloud.tf` with the `pomo-studio/workspace/tfe`
   module: `vcs_repo` the module repository, `working_directory = "examples/live"`,
   `terraform_version` the module's floor, `auto_apply` off, and `role_arn` built
   as a string from the account id. Do not read the ARN from
   `module.tfc_oidc.role_arns[...]`: a brand-new role's ARN is unknown at plan
   time, and the workspace module gates its OIDC variable set on it.
3. **Apply `pomocore`.** Pushing to `main` queues a plan and a human confirms it.
   That creates the role and the workspace and wires the OIDC dynamic credentials.
4. **Add the token.** Create a Terraform Cloud user token and store it as the
   `TF_API_TOKEN` repository secret on the module repository, so the workflow can
   trigger runs.
5. **Dispatch.** Actions, `Live acceptance`, Run workflow. Leave `skip_destroy`
   off. A VCS-triggered run from the workspace's creation may already be waiting;
   the workflow finds the run for the commit and approves it.
6. **Confirm.** The apply run reaches `applied`, the workflow triggers a destroy
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
- [ ] Declare the acceptance workspace and its OIDC role in `pomo-studio/pomo`, and add the `TF_API_TOKEN` secret.
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
