# Building a profile on this layer — a concrete recipe

You are an industry standard, a company, or a project that wants stricter or additional rules
for credible-process records without forking this layer. Four pieces, all additive.

## 1. Your own vocabulary block

Pick a reverse-domain `@type` you own and define keywords under it. A record then carries your
block next to this layer's on the same element:

```xml
<stc:Output>
  <stc:Resource kind="document" type="text/markdown" source="resources/level-assessment.md"/>
  <stc:Classification type="org.credible-process.core">
    <stc:ClassificationEntry keyword="credibility.level">CL3</stc:ClassificationEntry>
  </stc:Classification>
  <stc:Classification type="com.example.acme.simulation-governance">
    <stc:ClassificationEntry keyword="governance.review-board">Powertrain SRB</stc:ClassificationEntry>
    <stc:ClassificationEntry keyword="governance.ticket">SRB-2026-117</stc:ClassificationEntry>
  </stc:Classification>
</stc:Output>
```

Write the keyword rules as a standalone Schematron (`queryBinding="xslt"`, literal `@type` in
`context=`, one rule per context per pattern — see `profiles/credible-process-core.sch` as the model).

## 2. Your own overlay rules

A separate `.sch` file run *after* this layer's. Example — a company requires the execution step to
be fully populated even at CL1, and every record to name its cost centre:

```xml
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt">
  <title>ACME-CSP-OVERLAY</title>
  <ns prefix="stmd" uri="http://ssp-standard.org/SSPTraceability1/SimulationTaskMetaData"/>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>
  <pattern id="acme-execute-fully-populated">
    <rule context="//stmd:SimulationTaskMetaData//stmd:ExecuteSimulation" id="ACME-001">
      <assert test="stc:Input[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]" id="ACME-001a">
        ExecuteSimulation must carry populated Input at every level (company rule).</assert>
      <assert test="stc:Procedure[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]" id="ACME-001b">
        ExecuteSimulation must carry populated Procedure at every level (company rule).</assert>
    </rule>
  </pattern>
  <pattern id="acme-cost-centre">
    <rule context="/stmd:SimulationTaskMetaData/stmd:GeneralInformation" id="ACME-002">
      <assert test="stc:Classification[@type='com.example.acme.simulation-governance']/stc:ClassificationEntry[@keyword='governance.cost-centre']" id="ACME-002a">
        GeneralInformation must name the cost centre.</assert>
    </rule>
  </pattern>
</schema>
```

Never edit this layer's profiles to get there: obligations only tighten downstream, and your
conformance statement stays "conforms to CSP-STMD-CL3 of credible-process-schemas x.y plus
ACME-CSP-OVERLAY 1.0".

## 3. Your tooling on top of `credible_process`

```python
from credible_process.runner import check_record, load_sch, failed_asserts
from lxml import etree

def acme_check(path, level=None):
    res = check_record(path, level=level)          # XSD + STC-INT + CP-CORE + CLn
    doc = etree.parse(str(path))
    overlay = failed_asserts(load_sch("acme-csp-overlay.sch"), doc)
    return res.ok and not overlay, res, overlay
```

If you have your own XML documents that sit next to the process records (a manifest, a report
index), register them with the form builder so the same editor handles them:

```python
from credible_process.forms import SchemaEntry, register_schema
register_schema(SchemaEntry(id="acme-manifest", label="ACME simulation manifest",
                            xsd_path=Path("schemas/acme-manifest.xsd"),
                            locate_sibling=lambda d: sorted(d.glob("ACME_Manifest.xml")),
                            schematron_paths=(Path("acme-manifest.sch"),)))
```

## 4. Pointing into your documents from a record

Give the elements you want to address an `id` attribute and use the fragment convention:
`<stc:ResourceReference xlink:href="ACME_Manifest.xml#run-2026-117"/>`. Same-document fragments are
checked by STC-INT-110/111; cross-document ones by your tooling (this layer's runner resolves the
`.dtmd` reference from `GeneralInformation`; extend `detect_level`/your checker for others).

## 5. CI

```yaml
- run: pip install "credible-process-tools @ git+https://github.com/MBILLC/credible-process-tools@v0.1.0"
- run: git clone --depth 1 --branch v0.1.0 https://github.com/MBILLC/credible-process-schemas ../credible-process-schemas
- run: csp check records/*.stmd records/*.dtmd && python acme_check.py records/
```

Pin both by tag; see `07-conformance.md` for what a MAJOR bump means.
