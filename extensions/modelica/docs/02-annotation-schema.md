# The `__CMP_Evidence` schema

**Generated from `credible_process.modelica.schema` by `csp modelica schema-doc`. Do not edit by hand** — the plan's §5 names two sources of truth as the default failure, and a schema documented beside its implementation rather than from it is exactly that.

## Referent classes

What a claim was checked *against*. Aggregating claims without this overclaims the moment anyone counts them.

| class | meaning | |
|---|---|---|
| `closed-form` | an analytic expression evaluated in the check | verification |
| `conservation` | a balance the model must satisfy identically (power, momentum, Newton III) | verification |
| `cross-model` | a second, independently-written implementation, ideally from a second source | verification |
| `published-analytical` | a formula or table from a cited source | verification |
| `published-experiment` | measured data from a publication | **validation** |
| `measured` | measurement made for this library | **validation** |

## Records

### `__CMP_Evidence`

*any class that makes claims about its own physics (§2.1)*

| field | kind | required | meaning |
|---|---|---|---|
| `schema` | one of `0.1`, `0.2` | yes | schema version this record is written against |
| `updated` | iso8601 | yes | when the evidence was last RE-ESTABLISHED, not when the text was last touched |
| `semanticHash` | hash | yes | §2.5 staleness key: sha256 of the class with annotations, comments and description strings stripped |
| `effects` | list:__CMP_Effect | yes | the physical effects this class represents |
| `limitations` | strlist | no | what this class deliberately does not represent |

### `__CMP_Effect`

*nested inside __CMP_Evidence*

| field | kind | required | meaning |
|---|---|---|---|
| `id` | id | yes | stable, dotted slug, e.g. 'hypoid.lengthwise-sliding' |
| `provides` | strlist | yes | OFFERED QUANTITIES -- the key variables this effect produces. Not QOIs: nothing here is 'of interest' until a task takes an interest (§1.1) |
| `domain` | str | no | validity domain shared by this effect's claims |
| `claims` | list:__CMP_Claim | yes | what is established about this effect |

### `__CMP_Claim`

*nested inside __CMP_Effect*

| field | kind | required | meaning |
|---|---|---|---|
| `id` | claim-id | yes | '<effect-id>/<slug>'. IDS ARE FOREVER -- renaming one orphans its evidence, so the validator fails on an unknown id rather than skipping it (§5) |
| `referent` | one of `closed-form`, `conservation`, `cross-model`, `published-analytical`, `published-experiment`, `measured` | yes | what the claim was checked AGAINST (§1.2) |
| `statement` | str | yes | what is claimed, in one sentence |
| `tolerance` | str | yes | the bound the claim was ACCEPTED AT. This, not the measured value, is what belongs in a record: a tolerance is a static property of the check and is verifiable from the source, whereas a measured number is regenerated on every run |
| `measured` | str | no | DELIBERATELY UNUSED for live results. A measured value frozen in an annotation is the drift this project already fixed once, when nine .mo files carried stale numbers and one had silently diverged. semanticHash does not protect it, because re-running the report changes the number without changing the class. Use it only for a value that is itself static, such as a figure quoted from a source |
| `domain` | str | no | conditions THIS claim holds under; overrides the effect's domain. One of the two must be present |
| `evidence` | str | yes | where to look: test model, report section, source |

### `__CMP_Establishes`

*a TestModels class -- the link that makes the registry live (§2.2)*

| field | kind | required | meaning |
|---|---|---|---|
| `schema` | one of `0.1`, `0.2` | yes |  |
| `claims` | strlist | yes | claim ids this check establishes. Every one must resolve |

### `__CMP_Connector`

*a CONNECTOR -- the one structural class that carries a claim (owner, 2026-09-05): that it transfers every quantity the library's components need across it, each potential with its power-conjugate flow. No test model establishes it: the validator checks the record against the connector's own declarations and the conjugacy of its pairs, and every model that connects it tests it implicitly*

| field | kind | required | meaning |
|---|---|---|---|
| `schema` | one of `0.1`, `0.2` | yes |  |
| `carries` | strlist | yes | the potential (across) variables, as 'name[dims]:unit', e.g. 'r[2]:m' -- must match the connector's declarations exactly |
| `conjugate` | strlist | yes | the flow variables, as 'name[dims]:unit', e.g. 'f[2]:N' -- one per potential, with the power-conjugate unit (m<->N, rad<->N.m) |
| `statement` | str | yes | the claim: what a connection here transfers, and for which components that is the complete set |

### `__CMP_Structural`

*a model or block that is STRUCTURE by intent, not physics -- a guard, a world, a carrier -- and therefore carries no claims. Records, enumerations, functions, packages and partial models are structural by their keyword and need no marker; the validator refuses a __CMP_Evidence record on any of them. A connector carries __CMP_Connector instead (its one claim, see there)*

| field | kind | required | meaning |
|---|---|---|---|
| `schema` | one of `0.1`, `0.2` | yes |  |
| `reason` | str | yes | why this class has no physics of its own to claim, and where the physics it participates in IS claimed |

### `__CMP_Task`

*an Examples or user model -- the thing with a decision attached (§2.3)*

| field | kind | required | meaning |
|---|---|---|---|
| `schema` | one of `0.1`, `0.2` | yes |  |
| `contextOfUse` | str | yes | the decision this model exists to support |
| `taskSource` | str | no | schema 0.2: repo-relative path of the task_records.py this record is a PROJECTION of. Absent = a lightweight task: gap report only, no completeness check |
| `sourceHash` | hash | no | schema 0.2: sha256 of the canonical projection recomputed from taskSource -- stale when the QOI list or the context of use changes there, fresh when a requirement is merely reworded. Required with taskSource |
| `qoi` | list:__CMP_QOI | yes |  |

### `__CMP_QOI`

*nested inside __CMP_Task*

| field | kind | required | meaning |
|---|---|---|---|
| `id` | id | yes |  |
| `selects` | strlist | yes | variables selected from the OFFERED UNION. A selection outside it is not producible at all, catchable before any simulation runs (§2.4) |
| `needsEffects` | strlist | yes | effect ids this QOI depends on |
| `accuracyNeeded` | str | no |  |
| `operatingDomain` | str | no | where the task actually runs -- compared against each claim's validity domain to find evidence that exists but does not apply |
| `requirements` | strlist | no | schema 0.2: ids of the upstream requirements this QOI is derived from; every one must exist in taskSource. A QOI is not a primitive -- its completeness is only checkable against these |

## Copyright

Copyright © 2026 Model Based Innovation LLC. All rights reserved.
