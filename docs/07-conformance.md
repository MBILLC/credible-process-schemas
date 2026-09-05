# Conformance, identifiers, references, and building on this layer

## Conformance identifiers

| Identifier | File | Applies to |
|---|---|---|
| `STC-INT` | `profiles/stc-integrity.sch` | every STMD/DTMD/MTMD/SRMD |
| `CP-CORE` | `profiles/credible-process-core.sch` | every document carrying an `org.credible-process.core` block |
| `CSP-STMD-CLn` | `profiles/stmd-cln.sch` | STMD at level n |
| `CDP-DTMD-CLn` | `profiles/dtmd-cln.sch` | DTMD at level n |
| `CMP-MTMD-CLn` | `profiles/mtmd-cln.sch` | MTMD at level n |
| `SIC-CLn` | `profiles/sic-core-cln.sch` | SRMD with a SIC Core block, at level n |

A record **conforms at level n** if it validates against its upstream XSD and produces no failed
assert from `STC-INT`, `CP-CORE` and its record type's `CLn` profile. `profiles/profiles.json` is
the machine-readable index (file, id, record, level, mandatory steps, schema version). Every
generated file carries the repository `VERSION` in its header.

## Namespace and ownership

The classification type `org.credible-process.core` is a working name. The natural long-term owners
are the organisations that own the underlying artefacts — prostep ivip (CSP, SIC Core) or the Modelica
Association's SSP-LS-Traceability project (STC/STMD/DTMD/MTMD). Renaming the type is one line in
`matrices/profile-config.json` plus `csp generate`; `credible-process-core.sch` and the vocabulary
document carry it literally and are edited by hand.

## References and fragments

Records link to files and to one another with `stc:ResourceReference/@xlink:href`. This layer fixes
one convention for addressing *part* of a document: a fragment identifier `#<id>` names the element
whose `id` attribute (from `ssc:ABaseElement`, present on every step, particle, life-cycle entry and
resource) equals `<id>`. Same-document fragments must resolve (`STC-INT-110`); any fragment must be a
plain id, not a path or XPointer (`STC-INT-111`). Cross-document fragments are resolved by tools.

Two idioms use it: the DTMD → STMD/MTMD linkage (`stc:ResourceReference` inside the spawning step's
`Output`: `DefineSubTasks/Output` → the STMD, `ImplementModel/Output` → the MTMD; the STMD's
`GeneralInformation` references the DTMD back), and pointing a step's `Output` at one item inside a
downstream manifest — e.g. an STMD's `ImplementTestCase/Output` at `Manifest.xml#<test-case-id>` —
which requires the downstream schema to give that item an `id` attribute.

## Building a profile on top

An industry or company profile adds, never removes:

- its own `stc:Classification[@type]` vocabulary (administrative, legal, archival keywords) — the
  co-resident-blocks mechanism of SSP-LS-Traceability means several vocabularies sit side by side on
  one element with no schema extension;
- further Schematron files run *after* this layer's (fixity, containment, sizes, repeatability of the
  execution step at low levels, and so on) — Schematron composes by running more files, so this
  layer's profiles are never edited downstream;
- tighter obligations by re-promoting a step in its own overlay, not by editing the matrices here;
- tooling that wraps `credible-process-tools` (`csp check` per record, then its own checks).

The same layering answers what a downstream standard cites: "conforms to `CSP-STMD-CL3` of
credible-process-schemas x.y" is a citable, versioned statement independent of that standard.

## Versioning

Semantic versions. MAJOR: an obligation became stricter, a keyword was renamed, or a conformance id
changed meaning. MINOR: new optional keyword, new fixture, relaxed obligation, documentation. PATCH:
corrections that change no generated profile.
