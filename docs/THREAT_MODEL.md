# THREAT_MODEL.md — DQA v1 (Request for Comments)

**Status:** DRAFT (RFC). This document defines the assumed assets, adversary capabilities, and security boundaries for DQA v1. 
Community peer review—especially regarding missing threat vectors, unstated assumptions, or cryptographic misalignments—is actively requested.

## Assets

- **A1.** Released quantized model weights.
- **A2.** Quantization engine binary.
- **A3.** `dq-deworm` filter rules (pinned fingerprints).
- **A4.** Private quantization mathematics (out-of-tree).
- **A5.** Private rare-script oracle data (out-of-tree).
- **A6.** Signing keys (Ed25519 classical + ML-DSA-65 post-quantum),
  hardware-backed where possible.
- **A7.** Release manifests and optional freshness anchors.
- **A8.** Reputation / priority of the specification.

## Adversaries

- **T1. Supply-chain worm.** Injects invisible Unicode into source,
  configs, or tokenizer metadata, in the sub-class characterized
  by Trojan Source and observed in the GlassWorm-family npm worms.
- **T2. Provenance-swap attacker.** Replaces a released artifact
  with a look-alike between publication and user load.
- **T3. Freshness-rollback attacker.** Forges or rolls back release
  timestamps on a single anchor ledger.
- **T4. Coerced maintainer.** Legal or physical coercion of the
  author forces a signed malicious release.
- **T5. Classical-key-theft attacker.** Steals the Ed25519 signing
  key.
- **T6. Quantum-key-break attacker.** Breaks Ed25519 via a
  sufficiently capable quantum computer while ML-DSA-65 remains
  unbroken.
- **T7. Central-service disruptor.** DDoS / takedown of any central
  manifest-hosting or anchor service.
- **T8. Defamatory flooder.** Submits false poisoning reports to
  discredit legitimate models.
- **T9. Semantic poisoner.** Ships bytes-valid weights that produce
  harmful outputs.

## In-scope defenses

| Threat | Defense |
|---|---|
| T1 | `dq-deworm` strict UTF-8 + pinned byte LUT + pinned code-point rule ranges at every ingestion boundary. |
| T2 | Manifest binds `(engine, deworm, weights)` under joint Ed25519 + ML-DSA-65 signatures. Verifier refuses mismatches. |
| T3 | Optional freshness anchors (NIST Beacon v2, OpenTimestamps, Rekor); verifier policy determines which are required. |
| T6 | Hybrid Ed25519 + ML-DSA-65 signing; forging a manifest requires breaking both schemes. |
| T7 | Content-addressed distribution; any surviving mirror (IPFS, Arweave, Software Heritage, Git mirror) satisfies retrieval. |
| T8 | Signed reports only; per-key rate limits; public transparency log makes flooding visible. |

## Out-of-scope (explicitly NOT defended)

| Threat | Why out of scope |
|---|---|
| T4 | Coercion is an operational / legal matter; see `REVOCATION.md` *(planned/TBD)* for the pre-published tombstone mechanism, which is a hedge rather than a cryptographic defense. |
| T5 | Classical key theft is mitigated by hardware-backed keys and operational key rotation; simultaneous theft of both the Ed25519 and ML-DSA-65 keys defeats the hybrid. |
| T9 | Semantic model poisoning is orthogonal to byte provenance. |
| Runtime host compromise | If the verifier host is compromised, no signature scheme helps. |
| Side channels on the quantizer | Not modeled. |
| Legal / jurisdictional attacks | Not technical. |

## Revocation (sketch, not specified here)

A signed tombstone statement, pre-generated at key-ceremony time
and stored on independent mirrors, may be used to invalidate all
manifests signed after a stated cutoff time. The cryptographic
protocol (message format, binding to manifest timestamps, replay
protection) is not specified in DQA-1 and will be the subject of a
separate document. *(Note: Feedback on whether to formalize this in v1 or keep it deferred is welcome).*

## Security-boundary summary

DQA is a **provenance** system with a **Unicode hygiene pre-flight**
and a **post-quantum hybrid signing envelope**. It is not an
antivirus, not a behavioral analyzer, not an AI-safety tool, and
not a replacement for SLSA, in-toto, Sigstore, or TUF; it applies
these existing ideas to ML-artifact bytes at the Unicode and
manifest layers.