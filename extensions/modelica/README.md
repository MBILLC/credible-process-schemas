# Modelica-library extension of the credible-process layer

A downstream profile in the sense of `docs/09-building-on-this-layer.md`: it adds, never removes.
It exists because a Modelica *library* is not one simulation task. Its evidence lives in the
library itself, as `__CMP_*` annotations on the classes (the schema is `docs/02-annotation-schema.md`),
and its CMP records are one MTMD per *component family* plus a thin library-level MTMD
(`docs/03-granularity-and-signoff.md`). The level a family record states is the level its
evidence *supports*, not the level of any particular use (`docs/01-library-credibility-levels.md`).

```
vocabulary/Modelica_CMP_Evidence_Vocabulary.md   the org.credible-process.modelica keywords
profiles/modelica-vocabulary.sch    MODELICA-VOC   keyword validity, for every block of this type
profiles/modelica-cmp-overlay.sch   MODELICA-OVL   component-family MTMDs and task STMDs: what a
                                                   library's evidence must additionally carry
profiles/modelica-structural.sch    MODELICA-STR   role=structural records (connectors, partials, world)
profiles/modelica-library.sch       MODELICA-LIB   role=library records (the release)
fixtures/                           VALID/INVALID pairs per rule, exact expected ids (registry.json)
docs/                               01 levels for a library, 02 the annotation schema (generated), 03 granularity and sign-off
```

Check order for a record of a library, after the core's XSD → `stc-integrity.sch` →
`credible-process-core.sch` → `<record>-cl<n>.sch`: `modelica-vocabulary.sch`, then the one
overlay the record's `record.role` selects. The tooling is `csp modelica check` in
credible-process-tools (`credible_process.modelica`); the cross-document level rule between a task
and the family records it uses (`docs/01`, LEVEL-001..004) is that tooling's, not Schematron's.

The core profiles, matrices and fixtures are untouched by this extension; `csp fixtures` stays
core-only, and this extension's fixtures run through `csp modelica fixtures`.
