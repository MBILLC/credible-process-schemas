# Known real-world records (corpus)

The profiles were calibrated against the few real SSP-LS-Traceability process records that exist
publicly. Useful to know when judging how strict a level is, and as test material.

| Source | What | Notes |
|---|---|---|
| `github.com/modelica/ssp-ls-traceability-examples`, `DC-Motor/contents/extra/org.ssp-standard.ssp-traceability.stmd/` | one `SimulationTask.stmd` (window-lifter DC-motor pre-selection) with 3 `.srmd`, ~70 per-step Markdown/PDF resources, 2 `.ssd`, 2 simulation-run folders with logs and results | The densest real instance: all 28 steps and their Input/Procedure/Output/Rationale particles are exercised; `stc:Links` and the life-cycle state elements are not (every `LifeCycleInformation` is empty). The root-context XPath convention of the profiles (`//stmd:SimulationTaskMetaData//stmd:Step`, prefixed, no default namespace) was confirmed against it. |
| `github.com/modelica/ssp-standard` examples (`SSPExamples`), `<example>/extra/org.ssp-standard.ssp-traceability.stmd/SimulationTask.stmd` | 8 STMD files, 6 unique by content hash (EV range variants, sandbox copies) | Mostly sparsely populated (3 of 28 steps); the EV-range one is the basis of `examples/ev-range/`, where it was filled to 28/28. |
| DTMD | none found publicly | The DTMD fixtures and the EV example are the only known instances. |
| MTMD | none found publicly (schema itself is unmerged upstream, branch `feat/CMP`) | Same. |

Practical consequences: at CL1 a real-world STMD such as DC-Motor passes on its content alone;
CL3 and CL4 require life-cycle entries with signatures that no public instance carries yet, so a
record authored today has to add them (`csp sign`). Where a public instance carries
`stc:Classification` blocks of prostep's own types (`org.prostep.srmd.*`), those are untouched by
this layer's rules.

A further corpus, produced with this layer rather than found: the RotorDynamics Modelica library's
records (six family MTMDs, one library MTMD, one task STMD), generated from the library's own
evidence annotations by `csp modelica` -- see `extensions/modelica/`.
