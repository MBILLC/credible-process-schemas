# Changelog

## Unreleased

### extensions/modelica (2026-09-06)
- A downstream profile for Modelica component libraries (docs/09 applied): vocabulary
  `org.credible-process.modelica` (`record.role`, `family.id`, `credibility.assumptions-ref`,
  `task.external-evidence`, ...), overlays MODELICA-VOC/OVL/STR/LIB, fixtures, and three documents:
  the level a family record supports and the task-to-family level rule, the generated annotation
  schema, granularity and sign-off. Core profiles, matrices and fixtures unchanged.

## 0.1.0 — 2026-09-05 (initial extraction)

Obligation matrices confirmed 2026-09-05: cell values as extracted; justifications rewritten to
rest on the prostep CL definitions only (no NASA-STD-7009B reconciliation in this layer).

Extracted from the LOTAR 2026 work project as an industry-neutral layer. Contents: vendored
SSP-LS-Traceability process schemas (STMD/DTMD/MTMD/STC/SRMD), SIC Core and MIC Core; the
`org.credible-process.core` vocabulary (`credibility.level` CL1–CL4 and companions); obligation
matrices and the generated CL1–CL4 conformance profiles for STMD, DTMD, MTMD and SIC Core;
`stc-integrity.sch`; fixtures; the EV-range worked example; documentation.

### Documentation (unreleased)
- docs/08 matrices & fixtures reference, docs/09 building on this layer (overlay recipe, own vocabulary, API, CI pin), docs/10 corpus, glossary.
- templates/: twelve minimal conformant STMD/DTMD/MTMD templates per level, generated with credible-process-tools/examples/make_templates.py.
- README rewritten with quick starts and a documentation index.
