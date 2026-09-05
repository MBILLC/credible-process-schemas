<?xml version="1.0" encoding="UTF-8"?>
<!--
  STC-INT — base integrity rules for any SSP-LS-Traceability process record (STMD, DTMD, MTMD)
  and SRMD. Hand-authored (not generated). Part of credible-process-schemas (BSD 2-Clause).

  These rules are level-independent and industry-independent: they say what makes a life-cycle
  entry, a derivation-chain entry and a cross-document reference trustworthy at all. Everything
  that exists only because a record will sit in a long-term archive (file sizes, URI containment,
  fixity of referenced files) is NOT here — that belongs to an archival overlay built on this layer.

  Run order: upstream XSD -> this file -> credible-process-core.sch -> the level profile.

  Rule ids: STC-INT-100 life-cycle entries are signed; STC-INT-101 derivation-chain entries carry
  author/fileversion/generationDateAndTime; STC-INT-110 same-document fragment references resolve;
  STC-INT-111 fragment references use the id attribute convention.

  Conventions: queryBinding="xslt" (XPath 1.0); one rule per context per pattern; no current() in
  context=; unique ids.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">
  <title>STC-INT: SSP-LS-Traceability record integrity</title>
  <ns prefix="stc" uri="http://ssp-standard.org/SSPTraceability1/SSPTraceabilityCommon"/>
  <ns prefix="ssc" uri="http://ssp-standard.org/SSP1/SystemStructureCommon"/>
  <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

  <!-- 100: every recorded life-cycle state is a signed statement, not a bare flag. The credible
       processes hinge on WHO declared a step Drafted/Defined/Validated/Approved/Archived/Retracted;
       an unsigned state is unattributable. Applies to all six states (not only Approved). The
       signature format itself (XAdES per-entry, scoped by the entry's id) is described in
       docs/04-signatures.md and produced/verified by the tools; presence is what a single-document
       rule can check. -->
  <pattern id="stc-int-lifecycle-signed">
    <rule context="//stc:LifeCycleInformation/stc:Drafted
                  | //stc:LifeCycleInformation/stc:Defined
                  | //stc:LifeCycleInformation/stc:Validated
                  | //stc:LifeCycleInformation/stc:Approved
                  | //stc:LifeCycleInformation/stc:Archived
                  | //stc:LifeCycleInformation/stc:Retracted" id="STC-INT-100">
      <assert test="*[local-name()='Signature']" id="STC-INT-100a" role="error">
        Every LifeCycleInformation entry (Drafted/Defined/Validated/Approved/Archived/Retracted) must
        carry a Signature: a life-cycle state is a signed statement by a named role.
      </assert>
    </rule>
  </pattern>

  <!-- 101: a derivation-chain entry records a transformation of the record; who did it, which
       version resulted, and when, are the minimum for the chain to mean anything. @generatingTool
       is left optional here: which tool wrote a record is a provenance fact that profiles built on
       this layer typically carry once, as a Classification keyword, not per chain entry. -->
  <pattern id="stc-int-derivationchain-fields">
    <rule context="//stc:DerivationChain/stc:DerivationChainEntry" id="STC-INT-101">
      <assert test="@author" id="STC-INT-101a" role="error">DerivationChainEntry/@author is required.</assert>
      <assert test="@fileversion" id="STC-INT-101b" role="error">DerivationChainEntry/@fileversion is required.</assert>
      <assert test="@generationDateAndTime" id="STC-INT-101c" role="error">DerivationChainEntry/@generationDateAndTime is required.</assert>
    </rule>
  </pattern>

  <!-- 110/111: the fragment-reference convention. SSP-LS-Traceability links records to one another
       and to resources through stc:ResourceReference/@xlink:href. This layer fixes the convention
       for addressing a PART of a document: a fragment identifier '#<id>' names the element whose
       'id' attribute (ssc:ABaseElement's id, present on every step, step particle, life-cycle entry
       and resource) equals <id>. The same convention is used for the DTMD -> STMD/MTMD linkage
       (ResourceReference inside the spawning step's Output) and for pointing a step's Output at
       one scenario or test case inside a downstream manifest whose elements carry an id attribute.
       A same-document fragment (href starting with '#') must resolve within this document (110);
       any fragment must be a plain id, not a path or an XPointer expression (111). Cross-document
       fragments are resolved by the tools (csp check resolves them when the target file is
       reachable), not by Schematron. -->
  <pattern id="stc-int-fragment-same-document">
    <rule context="//stc:ResourceReference[starts-with(@xlink:href, '#')]" id="STC-INT-110">
      <assert test="//*[@id = substring-after(current()/@xlink:href, '#')]" id="STC-INT-110a" role="error">
        Same-document reference '<value-of select="@xlink:href"/>' does not resolve: no element in this
        document carries id='<value-of select="substring-after(@xlink:href, '#')"/>'.
      </assert>
    </rule>
  </pattern>
  <pattern id="stc-int-fragment-syntax">
    <rule context="//stc:ResourceReference[contains(@xlink:href, '#')]" id="STC-INT-111">
      <assert test="not(contains(substring-after(@xlink:href, '#'), '/')) and not(contains(substring-after(@xlink:href, '#'), '(')) and string-length(substring-after(@xlink:href, '#')) &gt; 0" id="STC-INT-111a" role="error">
        Fragment identifier in '<value-of select="@xlink:href"/>' must be a plain element id (the value
        of the target element's id attribute), not a path or an XPointer expression, and not empty.
      </assert>
    </rule>
  </pattern>
</schema>
