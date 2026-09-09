<?xml version="1.0" encoding="UTF-8"?>
<!--
  MODELICA-VOC: org.credible-process.modelica vocabulary rules (hand-authored; extension, see
  extensions/modelica/README.md). Applies to every stc:Classification[@type='org.credible-process.modelica']
  block in an STMD or MTMD. Same conventions as credible-process-core.sch: queryBinding="xslt",
  literal @type in context=, one rule per context per pattern, unique ids.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>MODELICA-VOC: Modelica CMP evidence vocabulary rules</title>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <pattern id="modelica-voc-allowed-keywords">
    <let name="allowed" value="'|record.role|family.id|library.name|library.version|credibility.assumptions-ref|evidence.schema|evidence.generator|task.source-hash|task.external-evidence|task.external-evidence-ref|'"/>
    <rule context="//stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry" id="MODELICA-VOC-001">
      <assert test="contains($allowed, concat('|', @keyword, '|'))" id="MODELICA-VOC-001a" role="error">
        Unknown org.credible-process.modelica keyword '<value-of select="@keyword"/>'.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-voc-role-value">
    <rule context="//stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='record.role']" id="MODELICA-VOC-002">
      <assert test=". = 'component-family' or . = 'structural' or . = 'library' or . = 'task'" id="MODELICA-VOC-002a" role="error">
        record.role must be component-family, structural, library or task (found '<value-of select="."/>').
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-voc-external-evidence-value">
    <rule context="//stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry[@keyword='task.external-evidence']" id="MODELICA-VOC-003">
      <assert test=". = 'none' or . = 'calibration' or . = 'validation'" id="MODELICA-VOC-003a" role="error">
        task.external-evidence must be none, calibration or validation (found '<value-of select="."/>').
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-voc-non-repeatable">
    <rule context="//stc:Classification[@type='org.credible-process.modelica']/stc:ClassificationEntry" id="MODELICA-VOC-004">
      <assert test="count(preceding-sibling::stc:ClassificationEntry[@keyword = current()/@keyword]) = 0" id="MODELICA-VOC-004a" role="error">
        Keyword '<value-of select="@keyword"/>' occurs more than once in the same org.credible-process.modelica block.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-voc-one-block-per-element">
    <rule context="*[count(stc:Classification[@type='org.credible-process.modelica']) &gt; 1]" id="MODELICA-VOC-005">
      <assert test="false()" id="MODELICA-VOC-005a" role="error">
        More than one org.credible-process.modelica Classification block on the same element.
      </assert>
    </rule>
  </pattern>

  <pattern id="modelica-voc-block-shape">
    <rule context="//stc:Classification[@type='org.credible-process.modelica']" id="MODELICA-VOC-006">
      <assert test="stc:ClassificationEntry[@keyword='record.role']" id="MODELICA-VOC-006a" role="error">
        An org.credible-process.modelica block must state record.role.
      </assert>
      <assert test="local-name(..) = 'GeneralInformation'" id="MODELICA-VOC-007a" role="error">
        An org.credible-process.modelica block sits on GeneralInformation, not on '<value-of select="local-name(..)"/>'.
      </assert>
      <assert test="not(stc:ClassificationEntry[@keyword='task.external-evidence'][. != 'none']) or stc:ClassificationEntry[@keyword='task.external-evidence-ref']" id="MODELICA-VOC-008a" role="error">
        task.external-evidence other than 'none' needs task.external-evidence-ref naming the evidence resource.
      </assert>
    </rule>
  </pattern>
</schema>
