# Security Policy

## Reporting A Vulnerability

Use **Security > Advisories > Report a vulnerability** in the affected pomo-studio module repository. GitHub private vulnerability reporting is enabled for the Terraform module repositories. This opens a private report to repository maintainers, not a public issue.

Direct URL pattern: `https://github.com/pomo-studio/REPOSITORY/security/advisories/new`.

If the affected repository does not offer private reporting, use the [organization defaults repository's private reporting form](https://github.com/pomo-studio/.github/security/advisories/new) and identify the affected repository. Do not file vulnerability details publicly or invent an email destination.

Include affected module/provider/Terraform versions, impact, a minimal sanitized reproduction, and any proposed mitigation. Never attach credentials, raw state, raw plan JSON, customer data, or exploit output containing secrets. Coordinate disclosure with maintainers through the private advisory.

## Support Scope

Maintainers assess reports against the latest published version of each non-deprecated module. Older versions may require an upgrade; there is no guaranteed backport or response-time SLA. Deprecated modules should be migrated to their documented replacements. Report vulnerabilities in deprecated versions privately as well so maintainers can assess exposure and migration guidance.

Infrastructure examples are not permission to deploy into production. Review IAM policies, regional recovery, provider constraints, and migration plans for your environment.
