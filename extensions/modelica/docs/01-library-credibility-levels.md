# Credibility levels for a Modelica library

*Owner decisions of the RotorDynamics library, 2026-09-05/06, generalised. Part of the Modelica
extension; the core's definition of the levels is `docs/02-credibility-levels.md`.*

## A model in a library has no level of use

The core assigns the credibility level to a *decision* (CDP, `DefineResultQuality`) and lets the
simulation and modeling tasks it spawns inherit it. A component library is used in decisions it
knows nothing about: the same bearing model serves a trend study at CL1 and a design evaluation at
CL3. So a library's record cannot carry "the level of use". What it can carry is **the level its
evidence supports**: the `credibility.level` on a `component-family` record means *this family's
claims, checked as documented, meet the obligations of that level, assuming the claims' validity
domains and the declared limitations hold*. The assumptions are named by
`credibility.assumptions-ref` (vocabulary), a resource in the record that lists every claim's
domain and every limitation. A task that uses the family outside those domains is not covered,
whatever the level says.

The physics families of a library are checked against the core's `mtmd-cl<n>.sch` at the level
they state, exactly like any MTMD, plus `modelica-cmp-overlay.sch`.

## Structural records state a level of their own, and it constrains nothing

Connectors, partial models, enumerations and the world are structure: they carry no claims, except
a connector's single claim that it transfers the complete cut set (see `docs/03`). Their family
record (`record.role = structural`) states its own level, usually low, and is checked at it
(`modelica-structural.sch`). But **a structural record's level never bounds a simulation task**:
a partial model is never simulated by itself, a connector is tested implicitly by every model that
connects it, and the physics those classes participate in is claimed on the concrete models. The
simulation model's level overrides theirs (LEVEL-003 below).

## The rule between a task and the families it uses

A simulation task (an STMD with `record.role = task`) at level CLn draws its credibility from the
library's evidence. Two cases, decided by `task.external-evidence` on the task's `GeneralInformation`:

- **`none`** (the default) -- the task adds no evidence against measured data of its own. Then every
  `component-family` record the task references must support at least CLn: **LEVEL-001**, enforced
  by `csp modelica levels`. A task cannot be more credible than the models it is made of.
- **`calibration` or `validation`** -- the task brings its own evidence (a model calibrated or
  validated against real measurement data, with its own separate evidence, named by
  `task.external-evidence-ref`). Then the task's level may exceed the levels of the library models
  it uses: the additional data allows it. LEVEL-001 is reported as information, naming the evidence,
  not as a failure.

The rule is cross-document, so it is the tooling's, not Schematron's (`docs/09` §4):

| id | rule | severity |
| --- | --- | --- |
| LEVEL-001 | every `component-family` record a task references supports at least the task's level, unless the task declares external evidence | FAIL / INFO |
| LEVEL-002 | every physics family whose effects a task's QOIs need is referenced from the task's `ImplementModel/Input` | FAIL |
| LEVEL-003 | a `structural` record reached from a task (referenced, or through a family's classes) is reported whatever its level; it is excluded from LEVEL-001 and from the library record's level | INFO |
| LEVEL-004 | the `library` record's `DerivationChain` names every family record's current GUID, and its level is the minimum over the physics families | FAIL |

## What a level costs a family record

The core's obligations apply unchanged: at CL1 the record needs `GeneralInformation`, the analysis
and a signed `DecideModelingObjectiveFulfillment`; at CL2 also `VerifyAnalysis`, the model and
test-case requirements, the implemented model and test cases, `IntegrateSimulation`, with Input and
Procedure populated on every mandatory step; at CL3 all requirement, design and implementation
steps with rationale and signed life-cycle entries. The generator (`csp modelica emit records`)
populates everything that is gathered evidence; the `Verify*`, `Derive*` and `Decide*` steps are
a person's and are signed (`csp modelica signoff`). Generated steps carry no life-cycle entries at
all: the integrity layer (`STC-INT-100`) demands a signature on every entry, and an unsigned
"Drafted" by a generator is an attribution to nobody.
