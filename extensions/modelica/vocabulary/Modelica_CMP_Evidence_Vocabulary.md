# Modelica CMP evidence vocabulary

*Classification type `org.credible-process.modelica` (working name, like the core's). Part of
credible-process-schemas, BSD 2-Clause. Attaches on the `GeneralInformation` of an MTMD or STMD,
beside the core block `org.credible-process.core`, never instead of it.*

| Keyword | Values | Obligation | Meaning |
| --- | --- | --- | --- |
| `record.role` | `component-family` \| `structural` \| `library` \| `task` | **Mandatory** in every block of this type | Which kind of record this is, and therefore which overlay applies (`profiles/`). A *component-family* MTMD holds the claims of one family of a library's classes; a *structural* MTMD holds a family of connectors, partial models, enumerations and the world, whose one claim is the connectors' cut set; the *library* MTMD is the release; a *task* STMD is a simulation task that uses the library. |
| `family.id` | slug | Mandatory for `component-family` and `structural` | The key of the family in the library's `families.yaml`. |
| `library.name` | text | Recommended | The Modelica library (top-level package) the record belongs to. |
| `library.version` | text | Recommended | Its version, as the package's `version` annotation states it. |
| `credibility.assumptions-ref` | a resource id in this record | Recommended for `component-family` | The resource listing every claim's validity domain and every declared limitation: the assumptions under which the stated `credibility.level` (core block) is the level this evidence supports. See `docs/01`. |
| `evidence.schema` | `0.1` \| `0.2` | Optional | The `__CMP_*` annotation schema version the record was generated from (`docs/02`). |
| `evidence.generator` | text | Optional | Which tool versions generated the record. |
| `task.source-hash` | sha256 hex | Recommended for `task` | The hash of the task's projection (context of use and QOI list), the same value the `__CMP_Task` annotation on the model carries, so the source, the annotation and the STMD can be told apart when one moves. |
| `task.external-evidence` | `none` \| `calibration` \| `validation` | Optional for `task`, default `none` | Whether the task brings its own evidence against measured data beyond what the library's records carry. With `calibration` or `validation` the task's level is not bounded by the levels of the family records it uses (LEVEL-001 in `docs/01`), because the additional data allows a higher level; `task.external-evidence-ref` then names the evidence. |
| `task.external-evidence-ref` | a resource id in this record | Mandatory when `task.external-evidence` is not `none` | The resource (in `EvaluateSimulationResults` or `AssureSimulationQuality`) that carries the calibration or validation against measured data. |

## Rules (machine-checkable)

`profiles/modelica-vocabulary.sch` (MODELICA-VOC): only the keywords above appear (001), the two
enumerations hold (002 `record.role`, 003 `task.external-evidence`), no keyword repeats in a block
(004), no element carries two blocks of this type (005), every block carries `record.role` (006)
and sits on a `GeneralInformation` (007), and `task.external-evidence-ref` accompanies any
external evidence (008). What each role must then carry is in the role's overlay.
