# Credibility-level adequacy and the library context of use

`docs/02-credibility-levels.md` explains how a level turns into obligations *on one record*. This
page is about the level of what a record **references**: a task may not rely on a model whose own
evidence supports less than the task was assigned, and a model may not claim more than the library
models it is built from support. Neither fact is visible from one document, so both are checked by
a tool, `csp adequacy`, in the same way role separation is (`05-role-separation.md`).

## 1. A level belongs to a task, not to a model

The decision maker assigns a credibility level to a simulation (sub-)task from product and
development risk. A model is a different kind of thing: it is built once and reused. The identical
library model — a journal bearing, a battery cell, a controller block — can sit under a CL1 trend
study this quarter and a CL4 virtual-product-V&V task next year, and *both are legitimate uses*
provided the model's own evidence covers what each task needs. Forcing one level onto the model
would be wrong in both directions: too low and it cannot be cited by the CL4 task even if its
evidence is excellent; too high and the CL1 task inherits obligations it does not need.

What a model *can* carry is a **ceiling**: the highest level its own evidence supports. On an
MTMD that is `credibility.level` on `GeneralInformation` (the same keyword; on an MTMD it means
"documented to this level", not "used at this level"). On a library model published for reuse it
is `cou.credibility-ceiling` in the library's context-of-use declaration (§3).

## 2. The adequacy check

`csp adequacy <package>` walks a package (directory, or `.ssp`/`.fmu`/zip) and checks two kinds of
edge:

| Edge | Reference followed | Adequate iff |
|---|---|---|
| STMD → MTMD | `stc:ResourceReference` to an `.mtmd` under the STMD's `ImplementModel/Output` | level(task) ≤ effective level(model) |
| MTMD → library model | `stc:ResourceReference` to a declaration `.srmd` under the MTMD's `DefineModelRequirements` | level(model) ≤ `cou.credibility-ceiling` |

The **effective level** of an MTMD is the minimum of its own level and every library ceiling it
references — the weakest link. A model documented to CL3 that is built on a CL2 library bearing is,
for any task that cites it, a CL2 model.

Verdicts, per edge:

- **ADEQUATE** — the inequality holds.
- **INADEQUATE** — it does not. Exit code 1. This is the finding the single-document profiles cannot
  produce: every record may conform at its own level and the *combination* still be wrong.
- **OVERRIDDEN** — it does not hold, but the citing step (the STMD's `ImplementModel`, the MTMD's
  `DefineModelRequirements`) carries `credibility.adequacy-override` = `<task level>><model level>`
  in its own `org.credible-process.core` block *and* a signed `Approved`/`Validated` life-cycle
  entry. A deliberate, reviewed risk acceptance is allowed; a silent one is not. Exit 0, always
  printed, never counted as ADEQUATE. Pair it with `credibility.assessment-ref` pointing at the
  acceptance.
- **UNRESOLVABLE** — a level or a target could not be determined (see the fan-in rule below,
  missing declarations, a `cou.model-id` that does not match its file). A warning by default;
  `--strict` makes it fail.

**Fan-in rule.** An MTMD's level may be inherited from the governing DTMD its `GeneralInformation`
references — but only while exactly one task lineage uses it. The moment a second STMD (under a
different DTMD) cites the same MTMD, "its governing DTMD" no longer means anything, and resolving
through whichever `.dtmd` reference happens to be present would silently give every caller one
task's level. So a fanned-in MTMD **must** self-state `credibility.level`; otherwise every edge into
it is UNRESOLVABLE. In practice a reusable model self-states its ceiling once, at publication.

The domain lines of a library declaration (`cou.validity-domain`, `cou.excluded-use`) are printed
next to each MTMD → library edge. The tool does not compare them with the task's own requirements:
whether a bearing validated for 20–90 °C oil is adequate for a −30 °C cold-start study is the
engineer's judgement — the point of printing the declaration is that the judgement is made against
the library author's stated domain, and is auditable.

## 3. The library context-of-use declaration

A library of library models publishes, for every model it exports, an SRMD carrying one
`org.credible-process.library-cou` block (vocabulary: `vocabulary/Library_COU_Vocabulary.md`):
what the model is designed for (`cou.intended-use`), the domain over which its evidence holds
(`cou.validity-domain`, repeatable), what it is not for (`cou.excluded-use`), the ceiling
(`cou.credibility-ceiling`), where the evidence is (`cou.evidence-ref`, mandatory from CL2), and who
declared it when. This is ASME VVUQ 1-2022's *context of use*, written down at the point where a
model is published for reuse rather than reconstructed by every user from source code and a
changelog.

Two requirements on libraries follow, and are the point rather than a side effect:

1. **Documentation level.** An exported model without a declaration is UNRESOLVABLE for every task
   that uses it — never silently adequate. A library that wants its models used in credible-process
   work documents them to the vocabulary's minimum.
2. **Findability.** The declarations sit in a well-known place with a well-known name, addressable
   from a record by a plain `stc:ResourceReference`, without reading library source:

| Artefact | Path |
|---|---|
| Modelica library | `<Library>/Resources/credible-process/<FullyQualifiedClassName>.srmd` and `<Library>/Resources/credible-process/library-cou-index.srmd` |
| FMU / SSP | `extra/org.credible-process.library-cou/<Library>/<FullyQualifiedClassName>.srmd` and `.../<Library>/library-cou-index.srmd` |

The file name *is* the model identity (`cou.model-id` must equal the file stem), so a declaration is
addressable knowing only the class name and names never collide across libraries. Compiling a
Modelica model to an FMU **moves the declarations of every library model it uses** into the FMU's
`extra/`; an SSP carries the union over its components at its own top level. The declarations
travel with the artefact: the archive is self-contained, and a reader of the FMU alone sees which
library models it depends on and what they were built for. `csp library-cou list <root>`
enumerates the declarations under either root; `csp adequacy` resolves a reference relative to the
citing record first and under the roots second, so the same MTMD works before and after compilation.

The end-user MTMD references declarations from **`DefineModelRequirements`** (any particle;
`Input` is the natural one): the library's declared context of use is an input to what the model
must satisfy, and `VerifyRequirements` is where that requirement set is then checked — the adequacy
judgement belongs at requirements time, not at implementation time.

## 4. Relationship to the rest of the layer

- `model-validation.mode = externally-attested` (an MTMD's own QA steps) says *how* a library
  model's evidence is vouched for; the declaration says *what the evidence covers*. For a vendor
  library the attestation that satisfies the one is what `cou.evidence-ref` points at for the other.
- MIC Core identifies the model; `cou.model-id` reuses that identity. SIC Core describes the *task*
  context and is untouched — the declaration is its library-side counterpart.
- `csp roles` and `csp adequacy` are the layer's two cross-document checks; `csp verify` checks the
  signatures both rely on. Single-document rules for the new keywords: `CP-CORE-006`
  (`credibility.adequacy-override` well-formed, on a step with a sign-off) and `CP-LCOU`
  (`profiles/library-cou.sch`).

## 4a. The Modelica extension

`extensions/modelica` reached the same conclusions from the library side first (its `docs/01`):
a component-family record's `credibility.level` is the level its evidence *supports*; a task at
CLn rests on family records at ≥ CLn (LEVEL-001) unless it brings its own calibration or
validation evidence; structural records never constrain a task (LEVEL-003); the family record's
`credibility.assumptions-ref` lists every claim's validity domain and limitation. `csp modelica
levels` enforces LEVEL-001..004 for a configured library. `csp adequacy` is the generic,
configuration-free counterpart over any package, and reads exactly one thing from the extension's
vocabulary: on a task STMD, `task.external-evidence` = `calibration`/`validation` with its
`task.external-evidence-ref` is accepted as the attested exception (OVERRIDDEN) **if the step
holding that resource carries a signed Approved/Validated entry** — a declared but unsigned
exception stays INADEQUATE, which is stricter than LEVEL-001's INFO and is what OD-A1 asks for;
and a record with `record.role` = `structural` or `library` is INFO, never gating. Family records
are referenced from `ImplementModel/Input`, and `csp adequacy` follows `Input` and `Output` alike.

The library context-of-use declaration (§3) is the extension's evidence *published for a compiled
artefact*: `csp modelica emit cou` writes one declaration per class that carries a `__CMP_Evidence`
annotation into `<Library>/Resources/credible-process/`, with the ceiling from the class's family
(`families.yaml`), the validity domains from its effects and claims, the excluded uses from its
`limitations`, `cou.evidence-ref` pointing at the family record and `cou.evidence-note` carrying each claim's
"where to look" — so an FMU compiled from the
library can carry, under `extra/`, what its models were built for without the source.

## 5. Fixtures

`fixtures/adequacy/<case>/` holds fifteen small packages with their expected verdict counts in
`fixtures/adequacy/registry.json`; `csp fixtures` runs them as step 4. They are generated by
`credible-process-tools/examples/make_adequacy_fixtures.py`, which also writes the single-document
`library-cou-*` and `stmd-cl3-adequacy-override-*` fixtures. Cases: adequate and inadequate direct
edges, an inherited level in a single lineage, fan-in with and without self-statement, the
weakest-link library case, a signed and an unsigned override, a missing declaration, a declaration
found under the Modelica root by name, a `cou.model-id` that does not match its file, and the Modelica
extension's idioms (a family record under `ImplementModel/Input`, signed and unsigned external
evidence, a structural record).
