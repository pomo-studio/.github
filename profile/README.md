# postmodern.

Open source infrastructure for the modern web.

We build reusable Terraform modules and serverless patterns for AWS - opinionated, hardened, production-ready.

### Modules

| Registry Module | Repository | Description |
|---|---|---|
| [`pomo-studio/serverless-ssr/aws`](https://registry.terraform.io/modules/pomo-studio/serverless-ssr/aws) | [terraform-aws-serverless-ssr](https://github.com/pomo-studio/terraform-aws-serverless-ssr) | Multi-region serverless SSR on AWS (CloudFront + Lambda + S3) |
| [`pomo-studio/ssr-cloudfront/aws`](https://registry.terraform.io/modules/pomo-studio/ssr-cloudfront/aws) | [terraform-aws-ssr-cloudfront](https://github.com/pomo-studio/terraform-aws-ssr-cloudfront) | CloudFront distribution building block for SSR stacks |
| [`pomo-studio/ssr-cloudfront-support/aws`](https://registry.terraform.io/modules/pomo-studio/ssr-cloudfront-support/aws) | [terraform-aws-ssr-cloudfront-support](https://github.com/pomo-studio/terraform-aws-ssr-cloudfront-support) | CloudFront support resources for SSR stacks |
| [`pomo-studio/ssr-dns/aws`](https://registry.terraform.io/modules/pomo-studio/ssr-dns/aws) | [terraform-aws-ssr-dns](https://github.com/pomo-studio/terraform-aws-ssr-dns) | DNS and ACM building block for SSR stacks |
| [`pomo-studio/ssr-lambda/aws`](https://registry.terraform.io/modules/pomo-studio/ssr-lambda/aws) | [terraform-aws-ssr-lambda](https://github.com/pomo-studio/terraform-aws-ssr-lambda) | Lambda building block for SSR stacks |
| [`pomo-studio/ssr-storage/aws`](https://registry.terraform.io/modules/pomo-studio/ssr-storage/aws) | [terraform-aws-ssr-storage](https://github.com/pomo-studio/terraform-aws-ssr-storage) | S3 storage building block for SSR stacks |
| [`pomo-studio/dynamodb-global-table/aws`](https://registry.terraform.io/modules/pomo-studio/dynamodb-global-table/aws) | [terraform-aws-dynamodb-global-table](https://github.com/pomo-studio/terraform-aws-dynamodb-global-table) | DynamoDB tables with optional cross-region replica support |
| [`pomo-studio/cognito-auth/aws`](https://registry.terraform.io/modules/pomo-studio/cognito-auth/aws) | [terraform-aws-cognito-auth](https://github.com/pomo-studio/terraform-aws-cognito-auth) | Cognito User Pool + App Client patterns for SSR/API backends |
| [`pomo-studio/appsync/aws`](https://registry.terraform.io/modules/pomo-studio/appsync/aws) | [terraform-aws-appsync](https://github.com/pomo-studio/terraform-aws-appsync) | Opinionated GraphQL APIs with Cognito, DynamoDB/Lambda, and tracing |
| [`pomo-studio/event-bus/aws`](https://registry.terraform.io/modules/pomo-studio/event-bus/aws) | [terraform-aws-event-bus](https://github.com/pomo-studio/terraform-aws-event-bus) | Shared EventBridge bus foundation (schema + archive + optional DR routing) |
| [`pomo-studio/event-consumer/aws`](https://registry.terraform.io/modules/pomo-studio/event-consumer/aws) | [terraform-aws-event-consumer](https://github.com/pomo-studio/terraform-aws-event-consumer) | Per-service EventBridge consumer (SQS + optional Lambda + alarms) |
| [`pomo-studio/event-pipeline/aws`](https://registry.terraform.io/modules/pomo-studio/event-pipeline/aws) | [terraform-aws-event-pipeline](https://github.com/pomo-studio/terraform-aws-event-pipeline) | Combined EventBridge + SQS + Lambda pipeline (superseded by event-bus + event-consumer) |
| [`pomo-studio/oidc/aws`](https://registry.terraform.io/modules/pomo-studio/oidc/aws) | [terraform-aws-oidc](https://github.com/pomo-studio/terraform-aws-oidc) | OIDC provider + scoped IAM role patterns (no static AWS keys) |
| [`pomo-studio/workspace/tfe`](https://registry.terraform.io/modules/pomo-studio/workspace/tfe) | [terraform-tfe-workspace](https://github.com/pomo-studio/terraform-tfe-workspace) | VCS-driven Terraform Cloud workspace provisioning |

### Current Status

- All modules are published on the Terraform Registry with CI (fmt / validate / tflint) and automated releases on every repo.
- Every AWS module supports provider v5 and v6 (`>= 5.0, < 7.0`), validated against the latest provider releases.
- `event-pipeline` is superseded by the split `event-bus` + `event-consumer` modules; kept maintained for existing consumers.

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
