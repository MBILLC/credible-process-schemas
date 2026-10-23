# Granularity of a library's records, the rules of the evidence layer, and the sign-off

*Decided for the RotorDynamics library 2026-09-05, generalised. Part of the Modelica extension.*

## One MTMD per component family, plus a thin library record

An MTMD is the record of one Credible Modeling Process run: one modeling task with one set of
requirements, one design, one quality verdict and one decision, signed off as a unit and re-opened
as a unit. For a library that unit is neither the whole library (one signature over a hundred
claims is a rubber stamp, and a change to one bearing would re-open the gear meshes' verdict) nor
the single class (a shaft segment has two claims and no requirements of its own). It is the
**component family**: the classes that were planned, built and verified together, and that a user
asks about together ("is the bearing model credible for my case").

- `families.yaml` in the library's repository partitions every class outside its example, test
  and documentation packages into exactly one family, with a `role` (`physics` or `structural`) and,
  for a physics family, the `level` its evidence supports (`docs/01`). `csp modelica families --lint`
  refuses a class in no family, in two, a family naming a class that does not exist, and a class
  with claims inside a structural family.
- Each family gets one MTMD (`record.role = component-family` or `structural`), generated from the
  library's `__CMP_*` annotations (`docs/02`), its classes' documentation and the credibility
  report's sections that the family's claims cite. Sections no claim cites are assigned in
  `step-map.yaml`, or belong to the library. **The Modelica source is the authority:** a model
  requirement is an effect (`__CMP_Effect`: what the class shall provide over its validity domain,
  with the effect's id), a test-case requirement is a claim's tolerance, the analysis is the
  classes' documentation, and a document is cited through the class whose documentation links it.
  Planning documents are not record content.
- The **library record** (`record.role = library`) is the release: it holds the library-wide
  resources (domain of applicability, environment, calculation verification, the release gate) and
  names every family record in its `DerivationChain`. Its decision means *the release*.

## Rules of the evidence layer

1. **Structure carries no claims.** A connector, record, enumeration, function, package or partial
   model is structural by its keyword; a model that is structure by intent (a guard, the world) says
   so with `__CMP_Structural(reason = ...)`. The validator refuses a `__CMP_Evidence` or
   `__CMP_Establishes` on any of them; their physics is claimed where it is used, on the concrete
   models. A structural family's record has no test cases (`modelica-structural.sch`).
2. **The one exception: a connector carries one claim** -- that it transfers every quantity the
   library's components need, each potential with its power-conjugate flow. Written as
   `__CMP_Connector(carries, conjugate, statement)`, it has no test model: the validator checks the
   record against the connector's own declarations (`extends` followed), the conjugacy of its pairs
   (m with N, rad with N.m, same shape), and that some class uses it; every class that connects it is
   the implicit test. The generator turns each into a design specification and an implementation
   output, and the report shows them as a "Connectors: the cut set each carries" table.
3. **Generated steps carry no life-cycle entries.** Only a person's entries exist, and they are
   always signed (`STC-INT-100`). `Verify*`, `Assure*`, `Derive*` and `Decide*` are a person's.
4. **The Output of an `Assure*` step is gathered evidence, never a verdict.** The verdict is the
   `Derive*` step, a person's.
5. **A signed record is re-versioned, never frozen.** Regenerating a record with signed steps mints
   a new GUID and a `DerivationChain` entry naming the previous version (author, file version, date:
   `STC-INT-101`); the previous file is archived verbatim and stays verifiable; signed steps whose
   content did not change are carried forward byte for byte (an XAdES signature covers its step
   element only), the others are re-signed.
6. **Claim ids are forever.** A renamed claim orphans its establishing test model; the validator
   fails rather than skips.

## The sign-off

`csp modelica emit reports` renders one Markdown page per record with an "Open decisions" table:
one row per human step the record's level still needs, with an *output* and a *rationale* cell.
The owner fills the cells and runs `csp modelica decisions reports/<record>.md`, which writes the
Output and Rationale resources, the life-cycle entry (`Verify*`/`Assure*` to `Validated`,
`Derive*`/`Decide*` to `Approved`) and the XAdES signature into the record, then regenerates the
reports so the row leaves the table. `csp modelica unmet` lists what a level still needs, per
record; `csp modelica signatures` verifies every signature against the certificates kept beside
the records.

## Requests and deliveries: the hand-off between a task and the library

A simulation task can ask for what the library cannot yet give. When its gap report finds a QOI
that selects a quantity no instantiated class offers under an effect (*not producible*) or needs an
effect no class offers (*not established*), `csp modelica request` writes one request per such QOI
under `tasks/<Task>/requests/`: which STMD asks (its GUID), which QOI and requirement ids, which
instance, class and variable, which effect, over which operating domain and at which accuracy -- the
last two are what hand the modeling side its validity-domain axes. The task's STMD carries the
request as a `request` resource of `ImplementModel`; the family record of the class named consumes
it as the Input of its analysis and derives a model and a test-case requirement from it.

`csp modelica deliver` closes the loop once the class offers every requested effect with claims a
test model establishes: `<id>.delivery.json` names the claim ids, the establishing test models and
the family record's GUID; the STMD takes it as an `ImplementModel` Input (`delivery`) and its
DerivationChain gains the family record's GUID. `csp modelica requests` is the acceptance: every
request complete and bound to its STMD, every delivery's claims resolving, and the gap report
backing the QOI -- or reporting it *outside domain*, which is a legitimate outcome, never hidden.
