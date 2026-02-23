# postmodern.

Open source infrastructure for the modern web.

We build reusable Terraform modules and serverless patterns for AWS - opinionated, hardened, production-ready.

### Modules

| Registry Module | Repository | Description |
|---|---|---|
| [`pomo-studio/serverless-ssr/aws`](https://registry.terraform.io/modules/pomo-studio/serverless-ssr/aws) | [terraform-aws-serverless-ssr](https://github.com/pomo-studio/terraform-aws-serverless-ssr) | Multi-region serverless SSR on AWS (CloudFront + Lambda + S3) |
| [`pomo-studio/cognito-auth/aws`](https://registry.terraform.io/modules/pomo-studio/cognito-auth/aws) | [terraform-aws-cognito-auth](https://github.com/pomo-studio/terraform-aws-cognito-auth) | Cognito User Pool + App Client patterns for SSR/API backends |
| [`pomo-studio/appsync/aws`](https://registry.terraform.io/modules/pomo-studio/appsync/aws) | [terraform-aws-appsync](https://github.com/pomo-studio/terraform-aws-appsync) | Opinionated GraphQL APIs with Cognito, DynamoDB/Lambda, and tracing |
| [`pomo-studio/event-bus/aws`](https://registry.terraform.io/modules/pomo-studio/event-bus/aws) | [terraform-aws-event-bus](https://github.com/pomo-studio/terraform-aws-event-bus) | Shared EventBridge bus foundation (schema + archive + optional DR routing) |
| [`pomo-studio/event-consumer/aws`](https://registry.terraform.io/modules/pomo-studio/event-consumer/aws) | [terraform-aws-event-consumer](https://github.com/pomo-studio/terraform-aws-event-consumer) | Per-service EventBridge consumer (SQS + optional Lambda + alarms) |
| [`pomo-studio/oidc/aws`](https://registry.terraform.io/modules/pomo-studio/oidc/aws) | [terraform-aws-oidc](https://github.com/pomo-studio/terraform-aws-oidc) | OIDC provider + scoped IAM role patterns (no static AWS keys) |
| [`pomo-studio/workspace/tfe`](https://registry.terraform.io/modules/pomo-studio/workspace/tfe) | [terraform-tfe-workspace](https://github.com/pomo-studio/terraform-tfe-workspace) | VCS-driven Terraform Cloud workspace provisioning |

### Current Status

- `txwatch` is now migrated from legacy event-pipeline to split `event-bus` + `event-consumer` modules.
- `terraform-aws-cognito-auth` is released as `v1.0.0` and validated in txwatch.
- Event smoke gate is active in txwatch CI with regression issue automation on main failures.

### Sites

- **[pomo.dev](https://pomo.dev)** - patterns, experiments, and open source modules
- **[pomo.studio](https://pomo.studio)** - cloud architecture for ambitious fintech teams
- **[txwatch.pomo.dev](https://txwatch.pomo.dev)** - live end-to-end reference app using pomo modules

### Principles

- OIDC everywhere - no static AWS keys
- Terraform Cloud for infrastructure deployment
- Multi-region architecture where it matters
- Least privilege IAM by default
- Integration gates before tagging releases
