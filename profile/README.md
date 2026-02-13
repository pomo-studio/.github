# postmodern.

Open source infrastructure for the modern web.

We build reusable Terraform modules and serverless patterns for AWS — opinionated, hardened, production-ready.

### Projects

| Repository | Description |
|---|---|
| [terraform-aws-serverless-ssr](https://github.com/pomo-studio/terraform-aws-serverless-ssr) | Multi-region serverless SSR on AWS — CloudFront, Lambda, S3, optional DynamoDB |
| [terraform-aws-oidc](https://github.com/pomo-studio/terraform-aws-oidc) | Full OIDC lifecycle on AWS — identity provider + scoped IAM roles |
| [terraform-tfc-workspace](https://github.com/pomo-studio/terraform-tfc-workspace) | VCS-driven Terraform Cloud workspaces with optional OIDC credentials |

### Sites

- **[pomo.dev](https://pomo.dev)** — patterns, experiments, open source
- **[pomo.studio](https://pomo.studio)** — cloud infrastructure for ambitious fintech teams

### Principles

- OIDC everywhere — no static AWS keys
- Terraform Cloud for all deployments — never run locally
- Multi-region by default — us-east-1 + us-west-2 failover
- Least privilege — scoped IAM per project prefix
