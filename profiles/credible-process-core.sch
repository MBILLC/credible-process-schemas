<?xml version="1.0" encoding="UTF-8"?>
<!--
  CP-CORE — Credible-Process Core vocabulary rules (hand-authored; not generated).
  Applies to any SSP-LS-Traceability document (SRMD, STMD, DTMD, MTMD): every
  stc:Classification[@type='org.credible-process.core'] block, wherever it sits (a document root, a phase, a step,
  a step particle), is checked for keyword validity, closed-enum values and non-repetition.
  Presence/mandatoriness of credibility.level is NOT checked here — it is level- and
  record-specific and lives in the generated dtmd-cl*.sch profiles.

  Conventions (shared by every .sch in this repository): queryBinding="xslt" (XPath 1.0),
  namespace-prefixed contexts, literal @type strings in context= (sch:let is not usable there under
  libxslt), each rule whose context overlaps another's in its own pattern (ISO Schematron fires only
  the first matching rule per pattern), no current() in context=, unique rule/assert ids.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>CP-CORE: Credible-Process Core Classification rules</title>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>

  <pattern id="cp-core-allowed-keywords">
    <let name="allowed" value="'|credibility.level|credibility.assessment-ref|model-validation.mode|signature.method|signature.validation-note|'"/>
    <rule context="//stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry" id="CP-CORE-001">
      <assert test="contains($allowed, concat('|', @keyword, '|'))" id="CP-CORE-001a" role="error">
        Unknown org.credible-process.core keyword '<value-of select="@keyword"/>'. Allowed: credibility.level,
        credibility.assessment-ref, model-validation.mode, signature.method, signature.validation-note.
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-core-level-value">
    <rule context="//stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='credibility.level']" id="CP-CORE-002">
      <assert test=". = 'CL1' or . = 'CL2' or . = 'CL3' or . = 'CL4'" id="CP-CORE-002a" role="error">
        credibility.level must be one of CL1, CL2, CL3, CL4 (found '<value-of select="."/>').
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-core-validation-mode-value">
    <rule context="//stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry[@keyword='model-validation.mode']" id="CP-CORE-003">
      <assert test=". = 'internal' or . = 'copied-in' or . = 'externally-attested'" id="CP-CORE-003a" role="error">
        model-validation.mode must be internal, copied-in or externally-attested (found '<value-of select="."/>').
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-core-non-repeatable">
    <rule context="//stc:Classification[@type='org.credible-process.core']/stc:ClassificationEntry" id="CP-CORE-004">
      <assert test="count(preceding-sibling::stc:ClassificationEntry[@keyword = current()/@keyword]) = 0" id="CP-CORE-004a" role="error">
        Keyword '<value-of select="@keyword"/>' occurs more than once in the same org.credible-process.core block; none of its keywords is repeatable.
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-core-one-block-per-element">
    <rule context="*[count(stc:Classification[@type='org.credible-process.core']) &gt; 1]" id="CP-CORE-005">
      <assert test="false()" id="CP-CORE-005a" role="error">
        More than one org.credible-process.core Classification block on the same element.
      </assert>
    </rule>
  </pattern>
</schema>
