# Credible-Process Core vocabulary

*Classification type `org.credible-process.core` (working name — see docs/07-conformance.md on namespace
ownership). Part of credible-process-schemas, BSD 2-Clause.*

SSP-LS-Traceability records (STMD for the Credible Simulation Process, DTMD for the Credible
Decision Process, MTMD for the Credible Modeling Process, SRMD for any resource) carry
key/value metadata in `stc:Classification[@type]` blocks whose keywords are defined by whoever
owns the `@type`. This vocabulary defines the five keywords the credible-process layer itself
needs. Everything administrative, legal or archival is deliberately left to the profiles that
industries or companies build on top of this layer under their own `@type`.

| Keyword | Values | Obligation (this layer) | Where it attaches | Meaning |
| --- | --- | --- | --- | --- |
| `credibility.level` | `CL1` \| `CL2` \| `CL3` \| `CL4` | **Mandatory** on the DTMD step `DefinitionPhase/DefineResultQuality`'s `Output` particle (enforced by every `dtmd-cl*.sch`); Optional on the `GeneralInformation` of an STMD or MTMD recorded without a governing DTMD | `Output/stc:Classification` of `DefineResultQuality`; or `GeneralInformation/stc:Classification` | The M&S Credibility Level assigned to the simulation (sub-)task — the level whose obligation profile the STMD/MTMD must then satisfy. |
| `credibility.assessment-ref` | free text / URI | Recommended alongside `credibility.level` | same block as `credibility.level` | Reference to the risk/criticality assessment that produced the level (a document id, a `stc:Resource`, a URL). This layer prescribes *that* a level is assessed, never *how*. |
| `model-validation.mode` | `internal` \| `copied-in` \| `externally-attested` | Mandatory on MTMD `GeneralInformation` at CL3 and CL4; Optional below | `GeneralInformation/stc:Classification` of an MTMD | How the model's V&V evidence is handled. `externally-attested` switches the QA-step obligations of the MTMD profiles to the attestation test (a signed `Approved`/`Validated` life-cycle entry on the step) instead of locally populated content. |
| `signature.method` | e.g. `XAdES-B`, `XAdES-LTA` | Optional | any element that carries a signed `LifeCycleInformation` entry | Durable, crypto-independent plain-text record of *how* the entry was signed, for readers after the signature stack has aged out. |
| `signature.validation-note` | free text | Optional | same | Plain-text validation note (who verified the signature, when, with what result). |

## Rules (machine-checkable)

`profiles/credible-process-core.sch` (conformance id CP-CORE) checks, for every block of this
type anywhere in a document: only the five keywords above appear (CP-CORE-001), the two closed
enumerations hold (CP-CORE-002/003), no keyword repeats within a block (CP-CORE-004), and no
element carries two blocks of this type (CP-CORE-005). Mandatoriness is enforced by the
level-specific profiles, not here.

`schemas/SRMDCredibleProcessCore.xsd` additionally publishes the named XSD simple types
`CredibilityLevelType` and `ModelValidationModeType` for schemas that want to bind the same
enumerations natively (e.g. a manifest with a `Credibility_Level` element).

## Attachment points, precisely

- The level: `dtmd:DecisionTaskMetaData/dtmd:DefinitionPhase/dtmd:DefineResultQuality/stc:Output/stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='credibility.level']`.
  `stc:StepType` includes `stc:GElementCommon`, so every step and every step particle may carry
  `Classification` directly; no `Resource` wrapper is needed.
- Linking the decision record to the task records it spawns: `stc:ResourceReference` inside the
  spawning step's `Output` (`DefineSubTasks/Output` → the STMD; `ImplementModel/Output` → the
  MTMD), not step-level `stc:Links`. See docs/07-conformance.md for the fragment convention.
