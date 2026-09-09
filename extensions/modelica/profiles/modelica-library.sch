<?xml version="1.0" encoding="UTF-8"?>
<!--
  MODELICA-LIB: the thin library-level record (record.role = library): the release. Its
  GeneralInformation names every family record in its DerivationChain (the cross-check that the
  chain is complete and current is the tooling's, LEVEL-004 in docs/01); its level is the minimum
  over the physics families (also the tooling's to check); every modeling step it carries at that
  level is populated by reference to the family records, never by content of its own.
  Hand-authored; extension, see extensions/modelica/README.md.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>MODELICA-LIB: library record rules</title>
  <ns prefix="mtmd" uri="http://ssp-standard.org/SSPTraceability1/ModelingTaskMetaData"/>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <pattern id="modelica-lib-root">
    <rule context="//mtmd:ModelingTaskMetaData[mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'library']" id="MODELICA-LIB-root">
      <assert test="mtmd:GeneralInformation/stc:DerivationChain/stc:DerivationChainEntry" id="MODELICA-LIB-001" role="error">
        A library record's DerivationChain names the family records it is the release of.
      </assert>
      <assert test="mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='credibility.level']" id="MODELICA-LIB-002" role="error">
        A library record states its level: the minimum over its physics families.
      </assert>
      <assert test="not(.//mtmd:ImplementTestCase/stc:Output/stc:Resource) and not(.//mtmd:ImplementModel/stc:Output/stc:Resource)" id="MODELICA-LIB-003" role="error">
        A library record has no models or test cases of its own: its ImplementModel and ImplementTestCase outputs are references to the family records.
      </assert>
    </rule>
  </pattern>
</schema>
