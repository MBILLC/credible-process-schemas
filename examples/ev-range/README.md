# EV-range worked example (CL3)

The Credible Decision / Simulation / Modeling Process records of an electric-vehicle range study,
adapted from the SSP-LS-Traceability `EVRangeExampleV3` example package (Modelica Association,
BSD 2-Clause). Files:

| File | Record | What it is |
|---|---|---|
| `DecisionTask.dtmd` | DTMD (CDP) | The Gate-2 range/efficiency decision; assigns `credibility.level = CL3` on `DefineResultQuality/Output`; `DefineSubTasks/Output` references the STMD; decision-maker steps signed |
| `SimulationTask.stmd` | STMD (CSP) | The 28-step simulation record; `GeneralInformation` references `DecisionTask.dtmd`, from which `csp check` resolves the level; fulfillment step signed by the simulation engineer |
| `ElectricRange_V2.mtmd`, `TorqueControl.mtmd` | MTMD (CMP) | One modeling record per model version; `model-validation.mode` on `GeneralInformation`; fulfillment signed |
| `Credibility-Assessment2024-10.srmd` | SRMD | Resource metadata carrying a full SIC Core block at CL3 |
| `dev-certs/` | | Self-signed DEVELOPMENT certificates the signatures above were made with (`csp keys`). Never use for real records. |

Reproduce the checks (from a checkout of credible-process-tools with this repository as sibling):

```
csp check DecisionTask.dtmd SimulationTask.stmd ElectricRange_V2.mtmd TorqueControl.mtmd
csp check Credibility-Assessment2024-10.srmd --level CL3
csp verify DecisionTask.dtmd --ca-pem dev-certs/trusted.pem
csp roles .            # Decision Maker "Dana Decider" vs Simulation Engineer "Sam Simulator": DISTINCT
```

Provenance: the process records were first filled in the LOTAR 2026 archival project (2026-08-07) and
were re-targeted to this layer's vocabulary on 2026-09-05; the `stc:Resource` files they point at
(`resources/...`, the `.md`/`.png`/`.pdf` evidence) are not copied here — only the records are.
