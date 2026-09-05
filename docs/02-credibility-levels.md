# Credibility levels and how obligations scale

The four M&S Credibility Levels are prostep ivip's, not this layer's:

| Level | Name | Purpose | What the record must therefore show |
|---|---|---|---|
| **CL1** | Trend Behavior | Qualitative comparisons, early concept evaluation; not for product V&V | The spine: what was asked, what was run, what came out, who decided — nothing more is mandatory |
| **CL2** | Quantitative Predictions | Quantitative design support; an accuracy requirement is specified | Model and test-case requirements, the implemented model and test case, and verified inputs/procedures |
| **CL3** | Design Evaluation | Reliable predictions that reduce physical testing; statistical validation against reference data | A formal V&V plan: all requirement/design/implementation steps, documented verification, rationale and signed life-cycle entries |
| **CL4** | Virtual Product V&V | Full working range, uncertainty analysis; may replace physical tests | Everything, plus the deepest design artefacts and explicit links between steps (full traceability) |

## How a level turns into a profile

Two matrices define the obligations; the profiles are generated from them and never hand-edited:

- `matrices/process-profile-matrix.csv` — for every record type, step and level: Mandatory or
  Optional, with a one-line justification. The DTMD is tiered like the others (its QA steps become
  mandatory at CL3); the MTMD's CL1/CL2 columns inherit the CSP obligation of the same-named step.
- `matrices/particle-profile-matrix.csv` — for a mandatory step, which of its particles must be
  populated: `Output` always; `Input` and `Procedure` from CL2; `Rationale` and
  `LifeCycleInformation` from CL3; `Links` at CL4.

"Populated, not merely present": a particle counts only if it holds a `stc:Resource` that is not a
placeholder and has a `@source` or inline `Content`, or a `stc:ResourceReference`. A mandatory step
that is absent altogether fails too (the profiles assert presence from the document root).

Three things are level-independent and therefore live outside the generated profiles: the decision
maker's steps `DefineResultQuality` and `DecideObjectiveFulfillment` carry a signed life-cycle entry
at every level (in every `dtmd-cl*.sch`); every life-cycle entry anywhere is signed
(`stc-integrity.sch`); and the level itself is written with `credibility.level` (`vocabulary/`).

## Who assigns the level, and how

The decision maker does, in the CDP step the white paper calls "Assign specific Credibilities"
(`DefineResultQuality`), from product and development risk and acceptable residual risk. This layer
prescribes *that* the level is assessed and recorded — and that the assessment can be referenced
(`credibility.assessment-ref`) — but never *how* the assessment is done: prostep leaves the method to
company practice (FMEA and the like), and so does this layer.

## SIC Core

Where an SRMD carries the prostep SIC Core block (`org.mic-core.sic-core`), `sic-core-cl*.sch`
promotes attribute groups from SIC Core's own Recommended to Mandatory per level
(`matrices/sic-core-profile-matrix.csv`). SIC Core's own Mandatory attributes are never demoted
(its conformance clause forbids it), and the groups that duplicate the process record's own
life-cycle sign-off are never promoted: the record is authoritative for whether a step was signed.
