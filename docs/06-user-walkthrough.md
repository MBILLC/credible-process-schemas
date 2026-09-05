# From a decision to a checked record — walkthrough

For the engineer who has (or is about to run) a simulation and needs to know what to write down.
Non-normative; the profiles in `profiles/` are what is checked.

## 1. Record the decision that justifies the work (DTMD)

Someone decided that a simulation is needed. That decision is the root of everything else: create a
`DecisionTaskMetaData` record (`schemas/upstream/DTMD.xsd`), fill `AnalyzeDecisionTask` (what is to be
decided, what is at stake), `DefineSubTasks` (the simulation and modeling tasks this spawns — each
one a `stc:ResourceReference` in `Output` pointing at the STMD/MTMD file you will create), and
`DefineResultQuality`: the credibility level required of each sub-task. Write it as
`credibility.level` in a `stc:Classification[@type='org.credible-process.core']` on that step's
`Output`, with `credibility.assessment-ref` pointing at whatever risk assessment produced it. The
decision maker signs both `DefineResultQuality` and, at the end, `DecideObjectiveFulfillment`
(`csp sign ... --claimed-role "Decision Maker"`).

If there is no decision record in your organisation yet, an STMD can state its own level on its
`GeneralInformation`; the DTMD is the better place because it is where the level is decided.

## 2. Look up what the level demands

`docs/03-obligation-rationale.md` (or `profiles/profiles.json`) lists, per record type and level,
which steps are mandatory. At CL1 that is the spine; at CL3 nearly everything, including rationale
and signed life-cycle entries; at CL4 also the deepest design steps and explicit `Links`.

## 3. Run the simulation task and record it (STMD)

Create a `SimulationTaskMetaData` record. Its `GeneralInformation` carries a `stc:ResourceReference`
to the DTMD (`csp check` reads the level from there). Then fill the phases as you go: Analysis
(what is asked and why), Requirements (model, parameters, environment, integration, test cases, QA),
Design (the concrete specifications), Implementation (the artefacts), Execution (what was run),
Evaluation (what came out, how good it is), Fulfillment (the engineer's signed statement). For each
mandatory step, the particles the level requires must be *populated*: a `stc:Resource` with a
`@source` (a file next to the record) or inline `Content`, or a `stc:ResourceReference` — a
placeholder does not count. To point at part of another document, use a fragment: `href="file.xml#<id>"`
where `<id>` is the target element's `id` attribute (`07-conformance.md`).

## 4. If the model itself needs a record (MTMD)

At CL3 and CL4, and whenever a model is new, the model's own Credible Modeling Process is recorded in
a `ModelingTaskMetaData` per model version. Library-sourced models: state on `GeneralInformation`
whether V&V evidence is `internal`, `copied-in`, or `externally-attested` (`model-validation.mode`);
in the last case the engineer's signed `Approved`/`Validated` entry on the QA steps stands in for
locally populated content.

## 5. Check before you call it done

```
csp check SimulationTask.stmd DecisionTask.dtmd Model.mtmd     # XSD + integrity + core + level profile
csp verify SimulationTask.stmd --ca-pem trusted.pem            # signatures
csp roles .                                                    # decision maker ≠ simulation engineer
```

`csp reorder --apply` fixes element order to the schema's sequence (do it *before* signing).
