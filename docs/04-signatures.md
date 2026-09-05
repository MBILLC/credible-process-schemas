# Signatures on life-cycle entries

`stc:LifeCycleEntryType` (via `ssc:GSignature` from SystemStructureCommon) gives every
`Drafted`/`Defined`/`Validated`/`Approved`/`Archived`/`Retracted` entry an optional
`ssc:Signature[@role][@type]/ssc:Content` slot; `Content` is mixed with `xs:any`, so it can hold
embedded XML. The schema gives the slot but not the format. This layer fills it with **XAdES**.

## Why XAdES rather than bare XML-DSig

XAdES (the ETSI/W3C profile of XML-DSig) adds a `SignedProperties` block — signing time, the signer's
claimed role, the signing certificate's identity — that is itself covered by the signature's hash.
Exactly the facts a process record needs ("who, in which role, when, signed this step") are therefore
standard, tool-independent XML, cryptographically bound to the signature they describe, instead of a
separate metadata record that can drift. Any XAdES-aware verifier can check it; the reference
implementation uses the BSD-licensed `signxml` library (`csp sign`, `csp verify`).

## Scope: the step, not the whole document

A record accumulates independent sign-offs over its life (a drafted analysis, an approved
requirement set, a validated setup, a final decision). Signing the *whole document* would make each
new signature invalidate every earlier one — verified by a tamper test during development: sign step
A, sign step B, re-check A, digest mismatch with no tampering at all. So each signature references the
**containing step** through a same-document `URI="#<id>"` (the step's `id` attribute, minted if
absent), with the enveloped-signature transform. Two consequences worth knowing:

- Changing anything inside a signed step (a resource path, a classification, another entry's date)
  invalidates that step's signatures — intended: the signature vouches for the step as recorded.
- Changing other steps does not.

Do not reformat a record after signing (pretty-printing changes whitespace inside signed steps).
`csp sign` reorders the signed entry's direct children to the schema's declared sequence *before*
signing and writes the file without further formatting; and it declares the `ssc` namespace on the
document root before signing — if that declaration first appears on the new `ssc:Signature` element
inside the signed step, the canonical form differs between signing and re-parsing and nothing verifies.

## Certificates

Any X.509 key/certificate pair works. `csp keys` makes a self-signed pair for development and
fixtures; production sign-offs need certificates from a CA the reading organisation trusts (public,
or an internal CA). `csp verify --ca-pem` names the trust anchors.

## Long-term validity

The signatures produced are XAdES-B. Over decades certificates expire and algorithms are deprecated;
XAdES-LTA (periodic re-timestamping with archive timestamps) addresses that and is **not
implemented**. Until it is, the plain-text fallback keywords `signature.method` and
`signature.validation-note` (`vocabulary/`) exist so a reader after the crypto stack has aged out
still knows how the entry was signed and who last verified it.
