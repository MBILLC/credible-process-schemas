<?xml version="1.0" encoding="UTF-8"?>
<!--
  MODELICA-STR: a structural family record (record.role = structural): connectors, partial models,
  enumerations and the world. Structure carries no claims - except a connector's one claim, its
  cut set, which needs no test model - so the record states its own level (checked by the core
  at that level) and carries no test cases. Its level never constrains a simulation task
  (docs/01, LEVEL-003). Hand-authored; extension, see extensions/modelica/README.md.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>MODELICA-STR: structural family record rules</title>
  <ns prefix="mtmd" uri="http://ssp-standard.org/SSPTraceability1/ModelingTaskMetaData"/>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <pattern id="modelica-str-root">
    <rule context="//mtmd:ModelingTaskMetaData[mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'structural']" id="MODELICA-STR-root">
      <assert test="mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='credibility.level']" id="MODELICA-STR-001" role="error">
        A structural record states its own credibility level (core block on GeneralInformation); it is checked at that level and never constrains a task's.
      </assert>
      <assert test="not(.//mtmd:ImplementTestCase)" id="MODELICA-STR-002" role="error">
        Structure carries no claims: a structural record has no ImplementTestCase.
      </assert>
      <assert test="not(.//mtmd:DefineTestCaseDesignSpecification)" id="MODELICA-STR-003" role="error">
        Structure carries no claims: a structural record has no DefineTestCaseDesignSpecification.
      </assert>
    </rule>
  </pattern>
</schema>
