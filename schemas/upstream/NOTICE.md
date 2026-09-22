# Upstream schemas — provenance and licences

Nothing in this directory is edited. Each file is a verbatim copy of its upstream source (apart
from a provenance comment prepended at vendoring time and, where noted in that comment, a
`schemaLocation` rewritten from an absolute URL to a same-directory relative path so the schema
graph resolves offline). The `*_header.txt` sidecars record the exact upstream commit.

| File | Upstream | Licence |
|---|---|---|
| `STC.xsd`, `SRMD.xsd`, `STMD.xsd`, `DTMD.xsd` | github.com/modelica/ssp-ls-traceability, `main`, tag `v1.0`, commit `5bfa7c2` (2025-08-29) | BSD 2-Clause (Modelica Association). The specification *text* of SSP-LS-Traceability is CC-BY-SA; only the schemas are copied here. |
| `MTMD.xsd` | same repository, branch `feat/CMP`, commit `1a5908e` (2026-08-04) — unmerged upstream, in production use | BSD 2-Clause |
| `ssp-standard/schema/SystemStructureCommon.xsd` | github.com/modelica/ssp-standard, SSP 2.0.1 | BSD 2-Clause (Modelica Association) |
| `SRMDSICCore.xsd` (SIC Core), `SRMDMICCore.xsd` (MIC Core) | prostep ivip SmartSE (SIC Core ratified by prostep ivip, not yet by IRT SystemX) | Published as open standards with no licence stated; copied on that basis (decision 2026-09-05). |
| `xlink.xsd` | minimal reconstruction of the XLink attribute declarations STC/STMD import from https://www.w3.org/XML/2008/06/xlink.xsd | W3C Software and Document Licence (for the original); the reconstruction is BSD 2-Clause like the rest of this repository |

The reconstructed `xlink.xsd` exists so the graph compiles without network access; validators that
can fetch the W3C original may use it instead.
