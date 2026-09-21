# Glossary

| Term | Meaning here |
|---|---|
| CDP / CSP / CMP | Credible Decision / Simulation / Modeling Process — the three processes of the prostep ivip SmartSE credibility framework |
| DTMD / STMD / MTMD | `DecisionTaskMetaData` / `SimulationTaskMetaData` / `ModelingTaskMetaData`: the SSP-LS-Traceability XML records of those processes |
| SRMD | `SimulationResourceMetaData`: metadata about any resource (a model, a data file, a report), carrying `Classification` blocks |
| STC | SSP-LS-Traceability Common: the shared types (`StepType`, `Resource`, `LifeCycleInformation`, `Classification`, …) |
| SIC Core / MIC Core | prostep's simulation-task-context and model-identity Classification vocabularies |
| Credibility level, CL1–CL4 | Trend Behavior / Quantitative Predictions / Design Evaluation / Virtual Product V&V — assigned by the decision maker per sub-task |
| Profile | a Schematron file that says which steps/particles/keywords are mandatory at one level for one record type; conformance id e.g. `CSP-STMD-CL3` |
| Phase, step | the process structure of a record; a step is an `stc:StepType` element inside a phase element |
| Particle | one of a step's six children: `Input`, `Procedure`, `Output`, `Rationale`, `Links`, `LifeCycleInformation` |
| Populated | a particle holding a non-placeholder `stc:Resource` with `@source` or inline `Content`, or a `stc:ResourceReference` (presence alone is not enough) |
| Life-cycle entry | one of `Drafted`/`Defined`/`Validated`/`Approved`/`Archived`/`Retracted` under a step's `LifeCycleInformation`; signed by a named role |
| Decision maker / simulation engineer | the two roles the framework keeps separate: the one who assigns the level and accepts the result vs. the one who does the task |
| Attestation (`externally-attested`) | an MTMD QA step satisfied by a signed life-cycle entry instead of locally populated evidence, for library models validated elsewhere |
| Ceiling | the highest credibility level a model's own evidence supports: `credibility.level` on an MTMD, `cou.credibility-ceiling` in a library declaration |
| Context-of-use declaration | an SRMD per exported library model (`org.credible-process.library-cou`): intended use, validity domain, excluded uses, ceiling, evidence — ASME VVUQ's COU at publication time |
| Adequacy | a task's level does not exceed the ceiling of the model it cites, nor a model's level the ceilings of its library models; checked across documents by `csp adequacy` |
| Fragment reference | `href="file#id"` addressing an element by its `id` attribute |
| Overlay | a downstream Schematron file run after this layer's, adding obligations |
