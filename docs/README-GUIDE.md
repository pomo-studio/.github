# README Standard

Every module repository's `README.md` should read like a well-edited short article
first, and a reference second. The generated reference is authoritative, but it is
not the pitch.

## Canonical layout

Keep this order. The generated block always comes last, on its own.

1. **Title and one line** — what it is, in a sentence a person would say out loud.
2. **When to use it (and when not to)** — the problem it solves; the cases it is the
   wrong tool for.
3. **Quickstart** — the smallest working `module` block, copyable.
4. **What it creates** — the resources and how they connect. A diagram if you have one.
5. **Design decisions** — why it is built this way; trade-offs; the alternatives you
   rejected. This is where a README earns trust.
6. **Examples** — links to runnable examples in the repo.
7. **Reference** — the generated `terraform-docs` block, wrapped in a collapsible
   `<details>` so the human narrative leads.
8. **Support and license** — stewardship link, licence.

## Rules

- **Never duplicate the generated tables in prose.** Inputs, outputs, providers and
  requirements have exactly one source of truth: the generated block. A hand-written
  copy goes stale and the drift check will not catch it.
- **Lead with specifics.** Name the resource, the default, the failure mode. "Strong
  defaults" says nothing; "retries three times, then dead-letters" says something.
- **Write for a person skimming**, then for one reading closely. Short paragraphs.
  A sentence can be a paragraph.
- **Show the trade-off.** If the module cannot do something, say so plainly.
- **No AI tells.** No em dashes, no tier-1 vocabulary (delve, leverage, robust,
  seamless, comprehensive, holistic, meticulous, pivotal). Prefer the plain word.
  See the [avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing) rules.
- **Keep the generated markers.** `<!-- BEGIN_TF_DOCS -->` and `<!-- END_TF_DOCS -->`
  must stay; the drift check and the Dependabot maintenance workflow depend on them.

## Generated block

`terraform-docs` (pinned in `.terraform-docs.yml`) injects the reference between the
markers. Wrap it so it collapses:

```md
<details>
<summary>Reference</summary>

<!-- BEGIN_TF_DOCS -->
...
<!-- END_TF_DOCS -->

</details>
```

Once wrapped, run `terraform-docs .` to refresh, and commit the result.

## How this is checked

CI runs markdownlint and Vale (prose) against `README.md`, plus a required-sections
check, via the shared `readme-quality` workflow. See the template at
[`templates/README.template.md`](../templates/README.template.md).

Modules also ship credential-free unit tests (`tests/*.tftest.hcl`), run by the
`test` job in the repository's `terraform.yml`. Live acceptance against real AWS
is a separate, authorized step, not part of pull request CI; see
[Module Testing](MODULE-TESTING.md).
