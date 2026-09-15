# postmodern.tf

Terraform components and architectural patterns for building applications on AWS.

Start with a blueprint for a complete system, or use individual components in
an architecture of your own. Explore how the services fit together, understand
the choices, and adapt the design to your application.

## Find your starting point

| You want to… | Start here |
| --- | --- |
| See how the pieces form a system | [Blueprints](https://pomo.dev/blueprints): architectures assembled from patterns and components |
| Understand an architectural approach | [Patterns](https://pomo.dev/patterns): the ideas, tradeoffs, and diagrams behind the designs |
| Find a Terraform building block | [Components](https://pomo.dev/modules): modules with documentation, examples, and Registry links |

The collection covers web delivery, identity, APIs, data, and events, alongside
workload identity and deployment automation.

## Testing and releases

A useful module needs more than a successful deployment. You need to understand
how it behaves when you change it, roll it back, or encounter a failure.

Check each component's repository for its supported configurations, automated
checks, and validation evidence. For example, the CloudFront edge router has
[reusable AWS integration tests](https://github.com/pomo-studio/terraform-aws-cloudfront-edge-router/tree/main/tests/live)
for traffic shifts, sticky sessions, origin failures, and recovery. Its
[published release evidence](https://github.com/pomo-studio/terraform-aws-cloudfront-edge-router/releases/tag/v0.1.1)
includes testing of the exact package downloaded from the Terraform Registry.

## People and contributions

Supported by [postmodern.](https://pomo.studio). Share a use case, improve an
explanation, report a bug, or contribute a tested fix.

[Contribute](https://github.com/pomo-studio/.github/blob/main/CONTRIBUTING.md) ·
[Report a vulnerability privately](https://github.com/pomo-studio/.github/blob/main/SECURITY.md) ·
[About the project](https://pomo.dev/about)
