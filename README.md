# credible-process-schemas

Industry-neutral conformance layer for the **Credible Decision / Simulation / Modeling Processes**
(prostep ivip SmartSE credibility framework) recorded in the Modelica Association's
**SSP-LS-Traceability** formats (DTMD / STMD / MTMD / SRMD): the vocabulary that writes the assigned
credibility level into a record, ISO Schematron profiles that say which steps must be populated at
CL1–CL4, the integrity rules for signed life-cycle entries and references, fixtures, and a worked
example. Schemas, profiles, matrices, fixtures and docs — no code.

- Start with `docs/01-overview.md`; `docs/06-user-walkthrough.md` if you have a simulation to record.
- Validate with any XSD 1.1 + ISO Schematron processor, in this order: `schemas/upstream/<Record>.xsd`
  → `profiles/stc-integrity.sch` → `profiles/credible-process-core.sch` → `profiles/<record>-cl<n>.sch`.
- Or use the companion toolchain `credible-process-tools` (`csp check`, `csp sign`, `csp verify`,
  `csp roles`, `csp generate`), which also regenerates `profiles/` from `matrices/`.

Licence: BSD 2-Clause (see `LICENSE`; upstream provenance and licences in `schemas/upstream/NOTICE.md`).
Version: see `VERSION` / `CHANGELOG.md`.
