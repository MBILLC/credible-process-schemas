# Obligation rationale, step by step

*Generated from `matrices/process-profile-matrix.csv` — regenerate this file when the matrix changes (the table is a rendering of the CSV; `csp generate` does not rewrite it). M = mandatory, O = optional.*

## Credible Decision Process (DTMD)

| Phase | Step | CL1 | CL2 | CL3 | CL4 | Rationale |
|---|---|---|---|---|---|---|
| - | `GeneralInformation` | M | M | M | M | File identity (GUID, name, version) and derivation chain; foundational, not level-dependent. Mandatory at every level (spine of the decision record). |
| Analysis | `AnalyzeDecisionTask` | M | M | M | M | Entry step of the CDP: the decision to be taken and its criticality inputs. Mandatory at every level (spine of the decision record). |
| Analysis | `VerifyAnalysis` | O | O | M | M | QA sub-step: the task/decision analysis is itself checked. Optional at CL1/CL2; mandatory from CL3, where the decision rests on documented verification and validation of its sub-tasks. |
| Definition | `DefineSubTasks` | M | M | M | M | The simulation (and modeling) sub-tasks spawned by the decision; references each STMD/MTMD. Mandatory at every level (spine of the decision record). |
| Definition | `DefineResultQuality` | M | M | M | M | Assign specific credibilities: the credibility level required of each sub-task (credibility.level). Mandatory at every level (spine of the decision record). |
| Definition | `VerifySubTasks` | O | O | M | M | QA sub-step: the sub-task definitions are checked. Optional at CL1/CL2; mandatory from CL3, where the decision rests on documented verification and validation of its sub-tasks. |
| Execution | `PerformSubTasks` | M | M | M | M | Execution/monitoring of the sub-tasks. Mandatory at every level (spine of the decision record). |
| Evaluation | `EvaluateResults` | M | M | M | M | Evaluation of the sub-task results against the decision-task requirements. Mandatory at every level (spine of the decision record). |
| Evaluation | `AssureResultQuality` | O | O | M | M | Assurance that the results reach the assigned credibility. Optional at CL1/CL2; mandatory from CL3, where the decision rests on documented verification and validation of its sub-tasks. |
| Evaluation | `DeriveResultQualityVerdict` | O | O | M | M | The verdict on result quality. Optional at CL1/CL2; mandatory from CL3, where the decision rests on documented verification and validation of its sub-tasks. |
| Fulfillment | `DecideObjectiveFulfillment` | M | M | M | M | The decision itself, signed by the decision maker. Mandatory at every level (spine of the decision record). |

## Credible Simulation Process (STMD)

| Phase | Step | CL1 | CL2 | CL3 | CL4 | Rationale |
|---|---|---|---|---|---|---|
| - | `GeneralInformation` | M | M | M | M | File identity (GUID, name, version) and derivation chain; foundational, not level-dependent. Mandatory at every level (spine of the record). |
| Analysis | `AnalyzeSimulationTaskAndObjectives` | M | M | M | M | Entry step of the CSP: what was asked and why. Mandatory at every level (spine of the record). |
| Analysis | `VerifyAnalysis` | O | M | M | M | QA sub-step: the task/decision analysis is itself checked. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Requirements | `DefineModelRequirements` | O | M | M | M | Model requirements, including the accuracy requirement a quantitative prediction needs. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Requirements | `DefineParameterRequirements` | O | O | M | M | Parameter requirements (sources, ranges, provenance). Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Requirements | `DefineSimulationEnvironmentRequirements` | O | O | M | M | Requirements on tool, solver and execution environment. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Requirements | `DefineSimulationIntegrationRequirements` | O | O | M | M | Requirements on how the model is integrated into the simulation. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Requirements | `DefineTestCaseRequirements` | O | M | M | M | Acceptance criteria: which quantities are checked, against what, how closely. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Requirements | `DefineQualityAssuranceRequirements` | O | O | M | M | Requirements on the QA procedure itself. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Requirements | `VerifyRequirements` | O | O | M | M | QA sub-step: the requirement set is checked for completeness and consistency. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Design | `DefineModelDesignSpecification` | O | O | M | M | Concrete model design (structure, physics, fidelity) chosen to meet the requirements. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Design | `DefineParameterDesignSpecification` | O | O | O | M | Concrete parameter set and its derivation. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). |
| Design | `DefineSimulationEnvironmentDesignSpecification` | O | O | O | M | Concrete tool/solver/environment choice. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). |
| Design | `DefineSimulationIntegrationDesignSpecification` | O | O | O | M | Concrete integration design. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). |
| Design | `DefineTestCaseDesignSpecification` | O | O | M | M | Concrete experiment definition: algorithm, communication points, start/stop, tolerances. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Design | `DefineQualityAssuranceDesignSpecification` | O | O | O | M | Concrete QA procedure. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). |
| Design | `VerifyDesignSpecification` | O | O | O | M | QA sub-step: the design specifications are checked against the requirements. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). |
| Implementation | `ImplementModel` | O | M | M | M | The implemented model artefact. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Implementation | `ImplementParameter` | O | O | M | M | The populated parameter set. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Implementation | `ImplementSimulationEnvironment` | O | O | M | M | The built execution environment. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Implementation | `ImplementTestCase` | O | M | M | M | The realized test case with reference variables, tolerances and reference results. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Implementation | `IntegrateSimulation` | O | M | M | M | The integrated, runnable simulation setup. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Implementation | `AssureSimulationSetupQuality` | O | O | M | M | Verification of the implemented setup (code/calculation verification, user-error analysis). Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Implementation | `DeriveSimulationSetupQualityVerdict` | O | O | M | M | The verdict on setup quality derived from the assurance step. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Execution | `ExecuteSimulation` | M | M | M | M | What was run, with which inputs and procedure, producing which outputs. Mandatory at every level (spine of the record). |
| Evaluation | `EvaluateSimulationResults` | M | M | M | M | Evaluation of results against the task objectives. Mandatory at every level (spine of the record). |
| Evaluation | `AssureSimulationQuality` | O | O | M | M | Validation and uncertainty assessment of the results. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). |
| Evaluation | `DeriveSimulationQualityVerdict` | O | M | M | M | The verdict on result quality. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). |
| Fulfillment | `DecideSimulationObjectiveFulfillment` | M | M | M | M | Signed statement whether the simulation objective was met; hand-off to the decision maker. Mandatory at every level (spine of the record). |

## Credible Modeling Process (MTMD)

| Phase | Step | CL1 | CL2 | CL3 | CL4 | Rationale |
|---|---|---|---|---|---|---|
| - | `GeneralInformation` | M | M | M | M | File identity (GUID, name, version) and derivation chain; foundational, not level-dependent. Mandatory at every level (spine of the record). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Analysis | `AnalyzeModelingTaskAndObjectives` | M | M | M | M | Entry step of the CMP: what the model is for and why. Mandatory at every level (spine of the record). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Analysis | `VerifyAnalysis` | O | M | M | M | QA sub-step: the task/decision analysis is itself checked. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineModelRequirements` | O | M | M | M | Model requirements, including the accuracy requirement a quantitative prediction needs. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineParameterRequirements` | O | O | M | M | Parameter requirements (sources, ranges, provenance). Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineSimulationEnvironmentRequirements` | O | O | M | M | Requirements on tool, solver and execution environment. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineSimulationIntegrationRequirements` | O | O | M | M | Requirements on how the model is integrated into the simulation. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineTestCaseRequirements` | O | M | M | M | Acceptance criteria: which quantities are checked, against what, how closely. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `DefineQualityAssuranceRequirements` | O | O | M | M | Requirements on the QA procedure itself. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Requirements | `VerifyRequirements` | O | O | M | M | QA sub-step: the requirement set is checked for completeness and consistency. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineModelDesignSpecification` | O | O | M | M | Concrete model design (structure, physics, fidelity) chosen to meet the requirements. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineParameterDesignSpecification` | O | O | O | M | Concrete parameter set and its derivation. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineSimulationEnvironmentDesignSpecification` | O | O | O | M | Concrete tool/solver/environment choice. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineSimulationIntegrationDesignSpecification` | O | O | O | M | Concrete integration design. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineTestCaseDesignSpecification` | O | O | M | M | Concrete experiment definition: algorithm, communication points, start/stop, tolerances. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `DefineQualityAssuranceDesignSpecification` | O | O | O | M | Concrete QA procedure. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Design | `VerifyDesignSpecification` | O | O | O | M | QA sub-step: the design specifications are checked against the requirements. Mandatory at CL4 only (Virtual Product V&V: full working range, uncertainty quantification, full traceability). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `ImplementModel` | O | M | M | M | The implemented model artefact. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `ImplementParameter` | O | O | M | M | The populated parameter set. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `ImplementSimulationEnvironment` | O | O | M | M | The built execution environment. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `ImplementTestCase` | O | M | M | M | The realized test case with reference variables, tolerances and reference results. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `IntegrateSimulation` | O | M | M | M | The integrated, runnable simulation setup. Mandatory from CL2 (Quantitative Predictions: a specified accuracy requirement, checked against an implemented model and test case). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `AssureSimulationSetupQuality` | O | O | M | M | Verification of the implemented setup (code/calculation verification, user-error analysis). Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Implementation | `DeriveSimulationSetupQualityVerdict` | O | O | M | M | The verdict on setup quality derived from the assurance step. Mandatory from CL3 (Design Evaluation: formal V&V plan, documented verification, statistical validation). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |
| Fulfillment | `DecideModelingObjectiveFulfillment` | M | M | M | M | Signed statement whether the modeling objective was met. Mandatory at every level (spine of the record). CL1/CL2 columns inherit the CSP (STMD) obligation of the same-named step; CL3/CL4 as derived for the CMP. |

## Particles of a mandatory step

| Particle | CL1 | CL2 | CL3 | CL4 | Populated means |
|---|---|---|---|---|---|
| `Input` | O | M | M | M | resource-or-reference |
| `Procedure` | O | M | M | M | resource-or-reference |
| `Output` | M | M | M | M | resource-or-reference-nonplaceholder |
| `Rationale` | O | O | M | M | resource-or-reference |
| `Links` | O | O | O | M | links-schema-forces-populated |
| `LifeCycleInformation` | O | O | M | M | lifecycle-state-present |
