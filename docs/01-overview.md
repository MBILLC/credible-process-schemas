# Credible-process layer — overview

This repository is the industry-neutral conformance layer for the three credible processes of the
prostep ivip SmartSE credibility framework, recorded in the Modelica Association's
SSP-LS-Traceability formats:

| Process | Record | Upstream schema | Phases / steps |
|---|---|---|---|
| Credible Decision Process (CDP) | DTMD `DecisionTaskMetaData` | `schemas/upstream/DTMD.xsd` | 5 / 10 |
| Credible Simulation Process (CSP) | STMD `SimulationTaskMetaData` | `schemas/upstream/STMD.xsd` | 7 / 28 |
| Credible Modeling Process (CMP) | MTMD `ModelingTaskMetaData` | `schemas/upstream/MTMD.xsd` (branch `feat/CMP`) | 5 / 24 |

Every phase and step in those schemas is optional (`minOccurs="0"`): an empty record is
schema-valid. What this layer adds is *which* steps must be present and populated at *which*
credibility level, as ISO Schematron profiles generated from a matrix, plus the small vocabulary
needed to write the assigned level into a record, the integrity rules that make life-cycle entries
and references trustworthy, fixtures that pin the behaviour, and a worked example.

```
schemas/upstream/        vendored SSP-LS-Traceability, SIC Core, MIC Core (never edited)
schemas/                 SRMDCredibleProcessCore.xsd — CredibilityLevelType, ModelValidationModeType
vocabulary/              the five org.credible-process.core keywords
matrices/                the source of truth: step, particle and SIC Core obligations per level
profiles/                GENERATED: stmd-cl1..4, dtmd-cl1..4, mtmd-cl1..4, sic-core-cl1..4;
                         hand-authored: stc-integrity.sch, credible-process-core.sch; profiles.json
fixtures/                VALID/INVALID pairs per profile, with the exact expected assert ids
examples/ev-range/       a CL3 decision + simulation + two modeling records, signed
docs/                    this documentation
```

How a record is checked (the order `csp check` uses): the upstream XSD (XSD 1.1, offline) → `stc-integrity.sch` →
`credible-process-core.sch` → the level profile for the record type (`sic-core-cl*.sch` for an SRMD
carrying a SIC Core block). The level is read from the record: a DTMD states it on
`DefineResultQuality/Output`; an STMD or MTMD either states it on its `GeneralInformation` or
references its governing DTMD from there.

Design rule for what belongs here: **if a rule is equally valid for an automotive, aerospace or
medical-device record, it is this layer's.** Anything that exists only because a record will sit in a
long-term archive — file sizes, URI containment, fixity of referenced files, disposal — belongs to a
profile built on top (see `07-conformance.md`).

Licence: BSD 2-Clause for everything here; the tooling that generates and checks these profiles is a
separate package (`credible-process-tools`).
