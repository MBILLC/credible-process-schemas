# Library context-of-use vocabulary

*Classification types `org.credible-process.library-cou` (one block per exported library model) and
`org.credible-process.library-cou-index` (one block per library). Working names — same ownership
caveat as `org.credible-process.core` (docs/07-conformance.md). Part of credible-process-schemas,
BSD 2-Clause. Rules: `profiles/library-cou.sch` (CP-LCOU). Rationale and folder conventions:
docs/11-library-context-of-use.md.*

A credibility level is a property of a *task*, not of a model: the same library model may serve a
CL1 trend study and a CL4 virtual-product-V&V task. What a library *can* state, once, at the point
where it publishes a model for reuse, is the model's **design context of use** (ASME VVUQ 1-2022's
COU): what it is designed for, the domain in which its evidence holds, what it is not for, the
credibility ceiling its evidence supports, and where the evidence is. An end-user MTMD that builds
on library models references these declarations from its `DefineModelRequirements` step, and
`csp adequacy` checks the task's level against every ceiling on the way.

## Declaration block — `org.credible-process.library-cou`

One SRMD per exported model, exactly one block, file name `<cou.model-id>.srmd`.

| Keyword | Values | Obligation | Meaning |
| --- | --- | --- | --- |
| `cou.model-id` | fully qualified model name (Modelica: `Lib.Sub.Model`; FMU: the `modelName`) | **Mandatory** | The exported model this declaration covers; equals the declaration's file stem, so a declaration is addressable knowing only the model name. |
| `cou.library` | library name | **Mandatory** | The publishing library (`<Library>` in the folder conventions). |
| `cou.library-version` | free text | Recommended | The library release the declaration belongs to. |
| `cou.intended-use` | free text | **Mandatory** | What the model is designed to predict, for what class of question. |
| `cou.validity-domain` | free text, or a structured line `quantity: min..max unit`; **repeatable** | **Mandatory** (≥ 1) | The domain over which the evidence behind the ceiling holds. Reported by `csp adequacy` next to the task; not machine-compared in this release (plan OD-A6). |
| `cou.excluded-use` | free text; **repeatable** | Recommended | Known misuses the author rules out explicitly. |
| `cou.credibility-ceiling` | `CL1` \| `CL2` \| `CL3` \| `CL4` | **Mandatory** | The level the model's own evidence supports inside the validity domain. An MTMD that builds on this model cannot claim more without a signed `credibility.adequacy-override`. |
| `cou.evidence-ref` | relative reference (a path or URI) to the model's MTMD, a validation report, or the `externally-attested` attestation; **repeatable** | **Mandatory from CL2** | Where the evidence behind the ceiling is — always something a tool can resolve. For a vendor library this is the attestation that also satisfies `model-validation.mode = externally-attested` (plan OD-A3). |
| `cou.evidence-note` | free text, `<claim id>: <where to look>`; **repeatable** | Recommended | What a human should read for each claim (a report section, a test model, a cited source) — prose, kept apart from `cou.evidence-ref` so a reference stays resolvable and a note stays readable. |
| `cou.declared-by` | person / role in the library's organisation | **Mandatory** | Who declared it. |
| `cou.declared-on` | ISO date | **Mandatory** | When. |

## Index block — `org.credible-process.library-cou-index`

One SRMD per library, `library-cou-index.srmd`, next to the declarations.

| Keyword | Values | Obligation | Meaning |
| --- | --- | --- | --- |
| `index.library` | library name | **Mandatory**, once | The library. |
| `index.library-version` | free text | Recommended | Its release. |
| `index.model` | a `cou.model-id`; **repeatable** | **Mandatory** (≥ 1) | Every declared model, so a tool can enumerate declarations without a directory walk. |

## Where the files live

| Artefact | Root | Path |
|---|---|---|
| Modelica library | the library's standardized `Resources` folder | `<Library>/Resources/credible-process/<cou.model-id>.srmd`, `<Library>/Resources/credible-process/library-cou-index.srmd` |
| FMU / SSP | the package's top-level `extra/` | `extra/org.credible-process.library-cou/<Library>/<cou.model-id>.srmd`, `.../<Library>/library-cou-index.srmd` |

Compiling a Modelica model to an FMU moves the declarations of every library model it uses into
the FMU's `extra/`; an SSP carries the union over its components at its own top level. The
declarations travel with the artefact, so the archive is self-contained and a reader of the
FMU alone sees which library models it depends on and what they were built for.

## Rules (machine-checkable)

`profiles/library-cou.sch` (conformance id CP-LCOU): keyword validity (CP-LCOU-001/010), the
ceiling enumeration (002), non-repetition of the non-repeatable keywords (003), the mandatory
keywords of a declaration (004a–f) and evidence-ref from CL2 (004g), one declaration block per
file (005), the mandatory keywords of an index (011). `csp check` runs it on any SRMD carrying either
block. Findability, `cou.model-id` = file stem, and the level comparison itself are cross-document
and belong to `csp adequacy`.
