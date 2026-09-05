# Reference: matrices, profile configuration, fixtures

## `matrices/process-profile-matrix.csv`

One row per record type × step × level.

| Column | Values | Meaning |
|---|---|---|
| `record_type` | `STMD` \| `DTMD` \| `MTMD` | which upstream schema |
| `phase` | `Analysis`, `Requirements`, `Design`, `Implementation`, `Execution`, `Evaluation`, `Fulfillment`, `Definition`, `-` | phase element the step lives in (`-` for `GeneralInformation`) |
| `step` | local element name | as declared in the XSD (`AnalyzeSimulationTaskAndObjectives`, …) |
| `level` | `CL1`..`CL4` | the level this row applies to |
| `obligation` | `M` \| `O` | Mandatory: the step must exist and its level-mandatory particles be populated; Optional: not checked |
| `justification` | text | one-line rationale, copied into the generated profile as a comment |

Every (record_type, step) needs all four level rows. A step Mandatory at a lower level should stay
Mandatory at higher levels (obligations only tighten); nothing enforces that, review it when editing.

## `matrices/particle-profile-matrix.csv`

| Column | Meaning |
|---|---|
| `particle` | `Input`, `Procedure`, `Output`, `Rationale`, `Links`, `LifeCycleInformation` |
| `cl1`..`cl4` | `M`/`O`: whether a *mandatory step* must have this particle populated at that level |
| `populated_rule_ref` | which predicate defines "populated": `resource-or-reference` (a non-placeholder `stc:Resource` with `@source` or `Content`, or a `stc:ResourceReference`), `links-schema-forces-populated` (presence suffices; the XSD forces ≥1 Link with ≥2 Locators), `lifecycle-state-present` (any of the six state elements; the signature itself is STC-INT-100) |

`GeneralInformation` is not a step (`stc:GeneralInformationType`): it must carry a populated
`Resource`/`ResourceReference` directly; the particle table does not apply to it.

## `matrices/sic-core-profile-matrix.csv`

One row per SIC Core attribute group (`keyword`), with `cl1`..`cl4` in SIC Core's own scale
(`O` Optional, `R` Recommended, `M` Mandatory). Only `M` cells that are neither in the schema's own
baseline-Mandatory set (`profile-config.json` → `sic_core.baseline_mandatory_keywords`) nor marked
`process_record_authoritative = Y` generate an assert. Composite groups (a keyword with `.name`,
`.version`, `.identifier`, `.url` or `.full-name` children) are satisfied by any child.

## `matrices/profile-config.json`

| Key | Purpose |
|---|---|
| `classification_type` | the `stc:Classification/@type` of this layer's vocabulary (`org.credible-process.core`) — the one place to rename it |
| `levels` | the ordered level names |
| `records.<REC>.{prefix,namespace,root,conformance_id,file,title}` | per record type: XML prefix/namespace/root element, id and file-name patterns (`{level}`, `{level_lc}`) |
| `sic_core.{classification_type,conformance_id,file,xsd,baseline_mandatory_keywords}` | the SIC Core overlay's equivalents |
| `dtmd_level_keyword.{step,particle,keyword}` | where the level is written (`DefineResultQuality/Output`, `credibility.level`) |
| `dtmd_signed_steps` | DTMD steps that carry a signed life-cycle entry at every level |
| `mtmd_external_attestation_steps` | MTMD QA steps whose Output/Rationale may be satisfied by attestation |
| `mtmd_validation_mode_mandatory_from` | level from which `model-validation.mode` is mandatory on an MTMD |

Change → `csp generate` → commit matrices and `profiles/` together; CI runs `csp generate --check`.

## `profiles/profiles.json`

Generated index: one entry per profile with `file`, `conformance_id`, `record`, `level`, `xsd` and
(for process profiles) `mandatory_steps`. Consumers that need "which steps are mandatory at CL3"
without parsing Schematron read this.

## Fixtures

`fixtures/registry.json` is a list of `{profile, record, level, valid: [...], invalid: [...]}`.
`csp fixtures` runs, for every entry, each `VALID/<file>` through XSD + `stc-integrity` +
`credible-process-core` + the level profile and requires zero failures; each `INVALID/<file>` must
fail with **exactly** the assert ids listed one-per-line in `INVALID/<file stem>.expected.txt`
(the literal `XSD` stands for an XSD error). To add a fixture: put the files in place, add the
registry entry, write the expected file from a run you have inspected. Convention for an INVALID
twin: make one particle "present but not populated" (set `placeholder="true"` on its Resource,
drop its ResourceReferences) rather than deleting elements that other references point at,
otherwise STC-INT-110 fires as well.
