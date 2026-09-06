<?xml version="1.0" encoding="UTF-8"?>
<!--
  MODELICA-OVL: what a Modelica library's evidence records carry beyond the core CL profiles
  (hand-authored; extension, see extensions/modelica/README.md). Applies to MTMDs whose
  record.role is component-family and to STMDs whose record.role is task. Re-promotions only,
  per docs/09: the core profiles are never edited downstream.

  OVL-level:    a component-family record states the level its evidence supports (the core makes
                credibility.level optional on an MTMD; for a family record it is the whole point).
  OVL-DefineParameterRequirements: a library's evidence is claimed under validity domains written
                on the parameters, so the parameter requirements step is present and populated at
                every level, for family records and for tasks.
  OVL-DefineTestCaseDesignSpecification: one test-case design per claim is what the evidence
                layer IS; a family record carries it at every level.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>MODELICA-OVL: Modelica library overlay for component-family and task records</title>
  <ns prefix="mtmd" uri="http://ssp-standard.org/SSPTraceability1/ModelingTaskMetaData"/>
  <ns prefix="stmd" uri="http://ssp-standard.org/SSPTraceability1/SimulationTaskMetaData"/>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <pattern id="modelica-ovl-family-root">
    <rule context="//mtmd:ModelingTaskMetaData[mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'component-family']" id="MODELICA-OVL-family">
      <assert test="mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='credibility.level']" id="MODELICA-OVL-level-present" role="error">
        A component-family record states the credibility level its evidence supports (core block, credibility.level, on GeneralInformation).
      </assert>
      <assert test=".//mtmd:DefineParameterRequirements" id="MODELICA-OVL-DefineParameterRequirements-present" role="error">
        A component-family record carries DefineParameterRequirements: the claims are valid under domains written on the parameters.
      </assert>
      <assert test=".//mtmd:DefineTestCaseDesignSpecification" id="MODELICA-OVL-DefineTestCaseDesignSpecification-present" role="error">
        A component-family record carries DefineTestCaseDesignSpecification: one test-case design per claim.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-ovl-family-parameter-requirements">
    <rule context="//mtmd:ModelingTaskMetaData[mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'component-family']//mtmd:DefineParameterRequirements" id="MODELICA-OVL-family-DefineParameterRequirements">
      <assert test="stc:Output[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]" id="MODELICA-OVL-DefineParameterRequirements-Output-populated" role="error">
        DefineParameterRequirements must carry a populated Output particle.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-ovl-family-testcase-design">
    <rule context="//mtmd:ModelingTaskMetaData[mtmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'component-family']//mtmd:DefineTestCaseDesignSpecification" id="MODELICA-OVL-family-DefineTestCaseDesignSpecification">
      <assert test="stc:Output[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]" id="MODELICA-OVL-DefineTestCaseDesignSpecification-Output-populated" role="error">
        DefineTestCaseDesignSpecification must carry a populated Output particle.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-ovl-task-root">
    <rule context="//stmd:SimulationTaskMetaData[stmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'task']" id="MODELICA-OVL-task">
      <assert test=".//stmd:DefineParameterRequirements" id="MODELICA-OVL-task-DefineParameterRequirements-present" role="error">
        A task using a Modelica library carries DefineParameterRequirements: the operating domain of every QOI is a parameter requirement.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-ovl-task-parameter-requirements">
    <rule context="//stmd:SimulationTaskMetaData[stmd:GeneralInformation/stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role'] = 'task']//stmd:DefineParameterRequirements" id="MODELICA-OVL-task-DefineParameterRequirements">
      <assert test="stc:Output[stc:Resource[not(@placeholder='true') and (@source or stc:Content)] or stc:ResourceReference]" id="MODELICA-OVL-task-DefineParameterRequirements-Output-populated" role="error">
        DefineParameterRequirements must carry a populated Output particle.
      </assert>
    </rule>
  </pattern>
</schema>
