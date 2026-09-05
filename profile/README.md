# postmodern.tf

**Cloud-native applications. Composed with Terraform.**

Opinionated building blocks for web delivery, identity, APIs, data, and events on AWS. Designed to fit together, stay understandable, and evolve with your application.

A focused toolkit for applications, not a catalogue of AWS services. Supported by [Pomo Studio](https://pomo.studio).

[Explore architectures](https://pomo.dev/compositions) · [Browse modules](https://pomo.dev/#patterns) · [SSR demo](https://ssr.pomo.dev) · [Demo source](https://github.com/pomo-studio/pomo-ssr)

### Application Building Blocks

| Capability | Module | Terraform Registry |
|---|---|---|
| Serve rendered web applications | [Serverless SSR](https://github.com/pomo-studio/terraform-aws-serverless-ssr) | [serverless-ssr/aws](https://registry.terraform.io/modules/pomo-studio/serverless-ssr/aws) |
| Authenticate users | [Cognito Auth](https://github.com/pomo-studio/terraform-aws-cognito-auth) | [cognito-auth/aws](https://registry.terraform.io/modules/pomo-studio/cognito-auth/aws) |
| Connect applications through GraphQL | [AppSync](https://github.com/pomo-studio/terraform-aws-appsync) | [appsync/aws](https://registry.terraform.io/modules/pomo-studio/appsync/aws) |
| Store data with optional regional replication | [DynamoDB Global Table](https://github.com/pomo-studio/terraform-aws-dynamodb-global-table) | [dynamodb-global-table/aws](https://registry.terraform.io/modules/pomo-studio/dynamodb-global-table/aws) |
| Route application events | [Event Bus](https://github.com/pomo-studio/terraform-aws-event-bus) | [event-bus/aws](https://registry.terraform.io/modules/pomo-studio/event-bus/aws) |
| Process events through queues and consumers | [Event Consumer](https://github.com/pomo-studio/terraform-aws-event-consumer) | [event-consumer/aws](https://registry.terraform.io/modules/pomo-studio/event-consumer/aws) |

### Delivery And Supporting Components

| Purpose | Module | Terraform Registry |
|---|---|---|
| Workload identity and scoped AWS roles | [OIDC](https://github.com/pomo-studio/terraform-aws-oidc) | [oidc/aws](https://registry.terraform.io/modules/pomo-studio/oidc/aws) |
| VCS-driven infrastructure workspaces | [TFC Workspace](https://github.com/pomo-studio/terraform-tfe-workspace) | [workspace/tfe](https://registry.terraform.io/modules/pomo-studio/workspace/tfe) |
| SSR edge delivery | [SSR CloudFront](https://github.com/pomo-studio/terraform-aws-ssr-cloudfront) | [ssr-cloudfront/aws](https://registry.terraform.io/modules/pomo-studio/ssr-cloudfront/aws) |
| SSR edge policies and support resources | [SSR CloudFront Support](https://github.com/pomo-studio/terraform-aws-ssr-cloudfront-support) | [ssr-cloudfront-support/aws](https://registry.terraform.io/modules/pomo-studio/ssr-cloudfront-support/aws) |
| SSR DNS and certificates | [SSR DNS](https://github.com/pomo-studio/terraform-aws-ssr-dns) | [ssr-dns/aws](https://registry.terraform.io/modules/pomo-studio/ssr-dns/aws) |
| SSR compute | [SSR Lambda](https://github.com/pomo-studio/terraform-aws-ssr-lambda) | [ssr-lambda/aws](https://registry.terraform.io/modules/pomo-studio/ssr-lambda/aws) |
| SSR assets and deployment storage | [SSR Storage](https://github.com/pomo-studio/terraform-aws-ssr-storage) | [ssr-storage/aws](https://registry.terraform.io/modules/pomo-studio/ssr-storage/aws) |

The older [Event Pipeline](https://github.com/pomo-studio/terraform-aws-event-pipeline) ([Registry](https://registry.terraform.io/modules/pomo-studio/event-pipeline/aws)) is superseded by Event Bus and Event Consumer.

### Beyond The First Deployment

Understand the decisions, compose the capabilities you need, and choose when to adopt changes. Each module's documentation, releases, changelog, and workflow results provide the details for evaluating it in your environment.

Our approach favors managed services, serverless compute, explicit configuration, scoped workload identities, and deliberate regional recovery design.

### Get Involved

Share a use case, improve an explanation, or contribute a tested fix.

- [Contribution guide](https://github.com/pomo-studio/.github/blob/main/CONTRIBUTING.md)
- [Report a vulnerability privately](https://github.com/pomo-studio/.github/blob/main/SECURITY.md)
- [postmodern.tf project site](https://pomo.dev)
- [Pomo Studio](https://pomo.studio)
