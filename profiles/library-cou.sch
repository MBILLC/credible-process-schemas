<?xml version="1.0" encoding="UTF-8"?>
<!--
  CP-LCOU — Library context-of-use declaration rules (hand-authored; not generated).

  A library of library models publishes, per exported model, an SRMD carrying one
  stc:Classification[@type='org.credible-process.library-cou'] block: what the model is designed for,
  the domain in which its evidence holds, what it is not for, the credibility ceiling its evidence
  supports, and where that evidence is. An index SRMD per library carries one
  stc:Classification[@type='org.credible-process.library-cou-index'] block listing the declared models.
  See ../vocabulary/Library_COU_Vocabulary.md and ../docs/11-library-context-of-use.md.

  What is checked here (single document): keyword validity, closed enumerations, non-repetition of
  the non-repeatable keywords, the mandatory keywords of a declaration and of an index, evidence-ref
  from CL2. Whether a task's level fits a ceiling, whether the declaration is findable from a record,
  and whether cou.model-id matches the file name are cross-document facts checked by `csp adequacy`.

  Conventions (shared by every .sch in this repository): queryBinding="xslt" (XPath 1.0),
  literal @type strings in context=, one rule per context per pattern, unique rule/assert ids.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>CP-LCOU: Library context-of-use declaration rules</title>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>
  <ns prefix="srmd" uri="http://ssp-standard.org/SSPTraceability1/SimulationResourceMetaData"/>

  <!-- ===== declaration block ===== -->
  <pattern id="cp-lcou-allowed-keywords">
    <let name="allowed" value="'|cou.model-id|cou.library|cou.library-version|cou.intended-use|cou.validity-domain|cou.excluded-use|cou.credibility-ceiling|cou.evidence-ref|cou.evidence-note|cou.declared-by|cou.declared-on|'"/>
    <rule context="//stc:Classification[@type='org.credible-process.library-cou']/stc:ClassificationEntry" id="CP-LCOU-001">
      <assert test="contains($allowed, concat('|', @keyword, '|'))" id="CP-LCOU-001a" role="error">
        Unknown org.credible-process.library-cou keyword '<value-of select="@keyword"/>'.
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-lcou-ceiling-value">
    <rule context="//stc:Classification[@type='org.credible-process.library-cou']/stc:ClassificationEntry[@keyword='cou.credibility-ceiling']" id="CP-LCOU-002">
      <assert test=". = 'CL1' or . = 'CL2' or . = 'CL3' or . = 'CL4'" id="CP-LCOU-002a" role="error">
        cou.credibility-ceiling must be one of CL1, CL2, CL3, CL4 (found '<value-of select="."/>').
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-lcou-non-repeatable">
    <rule context="//stc:Classification[@type='org.credible-process.library-cou']/stc:ClassificationEntry[@keyword!='cou.validity-domain' and @keyword!='cou.excluded-use' and @keyword!='cou.evidence-ref' and @keyword!='cou.evidence-note']" id="CP-LCOU-003">
      <assert test="count(preceding-sibling::stc:ClassificationEntry[@keyword = current()/@keyword]) = 0" id="CP-LCOU-003a" role="error">
        Keyword '<value-of select="@keyword"/>' occurs more than once in the same library-cou block; only
        cou.validity-domain, cou.excluded-use, cou.evidence-ref and cou.evidence-note are repeatable.
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-lcou-mandatory">
    <rule context="//stc:Classification[@type='org.credible-process.library-cou']" id="CP-LCOU-004">
      <assert test="stc:ClassificationEntry[@keyword='cou.model-id'][normalize-space(.)!='']" id="CP-LCOU-004a" role="error">
        A library-cou declaration must carry cou.model-id (the fully qualified name of the exported model).
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.library'][normalize-space(.)!='']" id="CP-LCOU-004b" role="error">
        A library-cou declaration must name its library (cou.library).
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.intended-use'][normalize-space(.)!='']" id="CP-LCOU-004c" role="error">
        A library-cou declaration must state cou.intended-use.
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.validity-domain'][normalize-space(.)!='']" id="CP-LCOU-004d" role="error">
        A library-cou declaration must state at least one cou.validity-domain line.
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.credibility-ceiling']" id="CP-LCOU-004e" role="error">
        A library-cou declaration must state cou.credibility-ceiling.
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.declared-by'][normalize-space(.)!=''] and stc:ClassificationEntry[@keyword='cou.declared-on'][normalize-space(.)!='']" id="CP-LCOU-004f" role="error">
        A library-cou declaration must record who declared it and when (cou.declared-by, cou.declared-on).
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='cou.credibility-ceiling'] = 'CL1' or stc:ClassificationEntry[@keyword='cou.evidence-ref'][normalize-space(.)!='']" id="CP-LCOU-004g" role="error">
        From CL2 a library-cou declaration must reference its evidence (cou.evidence-ref: the model's MTMD,
        validation report, or externally-attested attestation).
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-lcou-one-block-per-document">
    <rule context="/srmd:SimulationResourceMetaData[count(stc:Classification[@type='org.credible-process.library-cou']) &gt; 1]" id="CP-LCOU-005">
      <assert test="false()" id="CP-LCOU-005a" role="error">
        A declaration SRMD carries exactly one org.credible-process.library-cou block (one file per model).
      </assert>
    </rule>
  </pattern>

  <!-- ===== index block ===== -->
  <pattern id="cp-lcou-index-allowed-keywords">
    <let name="allowedidx" value="'|index.library|index.library-version|index.model|'"/>
    <rule context="//stc:Classification[@type='org.credible-process.library-cou-index']/stc:ClassificationEntry" id="CP-LCOU-010">
      <assert test="contains($allowedidx, concat('|', @keyword, '|'))" id="CP-LCOU-010a" role="error">
        Unknown org.credible-process.library-cou-index keyword '<value-of select="@keyword"/>'.
      </assert>
    </rule>
  </pattern>

  <pattern id="cp-lcou-index-mandatory">
    <rule context="//stc:Classification[@type='org.credible-process.library-cou-index']" id="CP-LCOU-011">
      <assert test="stc:ClassificationEntry[@keyword='index.library'][normalize-space(.)!='']" id="CP-LCOU-011a" role="error">
        A library-cou index must name its library (index.library).
      </assert>
      <assert test="stc:ClassificationEntry[@keyword='index.model'][normalize-space(.)!='']" id="CP-LCOU-011b" role="error">
        A library-cou index must list at least one declared model (index.model, repeatable; value = the
        fully qualified model name = the declaration's file stem).
      </assert>
      <assert test="count(stc:ClassificationEntry[@keyword='index.library']) = 1" id="CP-LCOU-011c" role="error">
        index.library occurs exactly once.
      </assert>
    </rule>
  </pattern>
</schema>
