# Documentation Standard

The [README standard](README-GUIDE.md) says how a module README should read.
This says where everything else goes, so a reader finds one answer in one place.

## Where something goes

| Content | Home |
|---------|------|
| What it is, when to use it, quickstart, what it creates, design decisions, examples, reference | `README.md` |
| Depth that would bury the README: architecture, caching, troubleshooting, migrations | `docs/` |
| What changed, per release | `CHANGELOG.md` |
| Anything with a lifecycle: roadmaps, planned work, known gaps | A GitHub issue |

The test: if a reader needs it to adopt the module, it belongs in the README. If
it is a deep dive or an operational runbook, it belongs in `docs/`. If it has an
owner and a finish line, it is an issue.

## Naming

- `docs/` files are lowercase and kebab-case: `getting-started.md`,
  `architecture.md`, `troubleshooting.md`, `migration-v1-to-v2.md`.
- No date-stamped file names. Put the date in the content or in the issue.
- When `docs/` exists, add a `docs/README.md` index that links every file with a
  one-line description.

## Examples

Every example has a `README.md`: what it shows, what it requires, how to run it,
and how to clean up. Start from
[`templates/EXAMPLE-README.template.md`](../templates/EXAMPLE-README.template.md).

## The no-TODO rule

- No `TODO`, `FIXME`, or `XXX` comments, and no `TODO` or `ROADMAP` files in git.
- File an issue and reference it, or fix it. A note in git has no owner and no
  trigger; an issue has both.
- The same applies to date-stamped one-off documents. If it is a finding it is an
  issue, if it is reference it is `docs/`, and if it is neither it does not belong
  in the repository.

## Shared commitments

- The stewardship commitment lives once in this repository and is referenced,
  not copied into each module.
- Do not restate the generated reference in prose. It has one source of truth.

## Checks

- `readme-quality` lints `README.md`, its prose, and its required sections on
  every pull request.
- `docs-quality` (planned) will lint `docs/`, check links, and fail on a tracked
  `TODO` or `ROADMAP` file.
