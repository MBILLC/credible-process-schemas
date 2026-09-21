# Role separation: decision maker vs. simulation engineer

The credible processes distinguish the **decision maker**, who owns the decision task, assigns the
required credibility and accepts (or rejects) the result, from the **simulation engineer**, who
performs the simulation (and modeling) task. The white paper's credibility assessment rests on the
assigner of the level not being the person who then declares it met.

This layer operationalises that in three places:

1. `dtmd-cl*.sch`: `DefineResultQuality` and `DecideObjectiveFulfillment` carry a signed life-cycle
   entry at every level.
2. `stc-integrity.sch` STC-INT-100: every life-cycle entry is signed, so the sign-offs on the STMD
   side are attributable too.
3. `csp roles`: a cross-document check (Schematron sees one document at a time) that walks a package,
   extracts the signing certificate's Subject DN and the XAdES claimed role from the decision maker's
   entries in every DTMD and the engineer's entries in every STMD, and reports `DISTINCT`, `MATCH`
   (violation: same signer), or `UNRESOLVABLE` (no signature to compare — itself a STC-INT-100 finding,
   not a role violation). The comparison is at person level (certificate identity), not at
   claimed-role level: two roles claimed by one certificate is exactly the case to catch.

`csp adequacy` (`11-library-context-of-use.md`) is the layer's second cross-document check and follows
the same linkage.

The linkage the check follows is the one the records themselves carry: a DTMD's `DefineSubTasks/Output`
references the STMD(s) it spawned (`stc:ResourceReference`), and the STMD's `GeneralInformation`
references its governing DTMD back. The MTMD is reached from `ImplementModel/Output` in the same way.
