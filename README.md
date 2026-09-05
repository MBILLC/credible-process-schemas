# credible-process-schemas

Industry-neutral conformance layer for the **Credible Decision / Simulation / Modeling Processes**
(prostep ivip SmartSE credibility framework) recorded in the Modelica Association's
**SSP-LS-Traceability** formats (DTMD / STMD / MTMD / SRMD): the vocabulary that writes the assigned
credibility level into a record, ISO Schematron profiles that say which steps must be populated at
CL1–CL4, the integrity rules for signed life-cycle entries and references, fixtures, templates and a
worked example. Schemas, profiles, matrices, fixtures and docs — no code (the toolchain is
[credible-process-tools](https://github.com/MBILLC/credible-process-tools)).

## Quick start for a project that wants to record its simulations

1. Read `docs/01-overview.md` (10 minutes) and `docs/02-credibility-levels.md`.
2. Copy a template from `templates/` for your record type and level; follow `docs/06-user-walkthrough.md`.
3. Check it: with the toolchain, `csp check my.stmd`; or with any XSD 1.1 + ISO Schematron processor,
   in this order: `schemas/upstream/<Record>.xsd` → `profiles/stc-integrity.sch` →
   `profiles/credible-process-core.sch` → `profiles/<record>-cl<n>.sch`.
4. Sign the life-cycle entries (`csp sign`), and if you have a decision record, run `csp roles`.
5. Look at `examples/ev-range/` for a complete CL3 set of records.

## Quick start for a standard or company building on this layer

`docs/09-building-on-this-layer.md` — your own vocabulary block, your own overlay Schematron, tooling
on top of the Python API, fragment references, CI. `docs/07-conformance.md` defines what
"conforms to CSP-STMD-CL3 of credible-process-schemas x.y" means and how versions change.

## Documentation

| | |
|---|---|
| `docs/01-overview.md` | what this layer is, layout, check order, the layer-boundary rule |
| `docs/02-credibility-levels.md` | the four levels and how obligations scale; who assigns the level |
| `docs/03-obligation-rationale.md` | every step × level with its rationale (rendered from the matrix) |
| `docs/04-signatures.md` | XAdES per-step signatures: why, scope, pitfalls, long-term validity |
| `docs/05-role-separation.md` | decision maker vs. simulation engineer, how it is checked |
| `docs/06-user-walkthrough.md` | from a decision to a checked record |
| `docs/07-conformance.md` | conformance ids, namespace ownership, fragment references, versioning |
| `docs/08-matrices-fixtures-reference.md` | column-by-column reference of the matrices, config and fixture registry |
| `docs/09-building-on-this-layer.md` | recipe for downstream profiles |
| `docs/10-corpus.md` | known real-world records |
| `docs/glossary.md` | terms |
| `vocabulary/Credible_Process_Core_Vocabulary.md` | the five keywords, values, attachment points |
| `templates/README.md`, `examples/ev-range/README.md`, `schemas/upstream/NOTICE.md` | templates, worked example, upstream provenance and licences |

Licence: BSD 2-Clause (`LICENSE`). Version: `VERSION` / `CHANGELOG.md`. Contributions: edit the
matrices or vocabulary, regenerate with `csp generate`, add a fixture pair for any new rule, and keep
`csp fixtures` green.
