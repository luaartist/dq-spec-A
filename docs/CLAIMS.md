# CLAIMS.md — what DQA does and does not assert

**Status:** DRAFT (Request for Comments). 
This is the proposed authoritative list of engineering claims the author intends to defend. 
During this RFC phase, community scrutiny, edge-case testing, and counter-examples are explicitly invited. 
Anything outside this list is **not** claimed.

## What DQA claims (each falsifiable by test)

1. **Byte-level Unicode hygiene.** The reference `dq-deworm` filter
   rejects every byte in the pinned `WORM_BYTES` table and every
   code point in the pinned `RULE_RANGES` list at the boundary
   specified in Section III of the paper. This is a *hygiene* claim
   (what the filter does to bytes), not a *security* claim (what the
   filter guarantees about adversary behavior).
2. **Strict RFC 3629 conformance.** The reference decoder rejects
   overlong encodings, UTF-8 encodings of surrogates
   (U+D800–U+DFFF), and encodings of code points above U+10FFFF.
3. **Pinned fingerprint tamper evidence.** The compile-time
   constants `DEWORM_BITMAP_VERSION`, `CODEPOINT_RULES_VERSION`,
   `FSM_RULES_VERSION`, `PIPELINE_RULES_VERSION`, and the combined
   `DEWORM_FINGERPRINT_V2` change if and only if the underlying
   rule tables change.
4. **Manifest binding under joint unforgeability.** A manifest
   accepted by a conforming verifier uniquely determines the signed
   fields under the joint Ed25519 + ML-DSA-65 unforgeability
   assumption.
5. **Independent reimplementability.** Any implementation that
   reproduces each expected decision in `test-vectors/` byte-for-byte
   is conformant for the purposes of this specification. *(Note: Test vectors are currently WIP for v1).*

## What DQA explicitly does NOT claim

1. **No novelty claim.** We do not assert that this specification
   advances the state of the art. The filter, the manifest, the
   hybrid signing scheme, and the anchor mechanisms are each built
   from publicly available components predating this work.
2. **No "cure," "immunity," or "elimination"** of GlassWorm,
   Trojan Source, or any other vulnerability class.
3. **No semantic model-poisoning detection.** DQA verifies
   provenance of bytes, not behavior of models.
4. **No malware detection.** DQA does not execute, sandbox, or
   behaviorally analyze any artifact.
5. **No protection against runtime compromise** of the verifier
   host.
6. **No protection against key theft.** An attacker with an
   authorized Ed25519 *and* an authorized ML-DSA-65 private key can
   produce valid manifests; the hybrid construction does not help
   against simultaneous theft of both.
7. **No claim of detection beyond the invisible-character and
   provenance-swap sub-classes.**
8. **No endorsement of any specific quantization mathematics.**
9. **No completeness claim** with respect to future Unicode
   standards or newly discovered invisible-character techniques.

## Forbidden marketing language

The following terms MUST NOT appear in any paper, README, release
note, blog post, or social-media statement authored under the
DynamicQuant project without explicit review:

- "cure" / "cured" / "cures"
- "immune" / "immunity"
- "unbreakable"
- "guaranteed safe"
- "zero-risk"
- "AI safety" (as a property of DQA)
- "novel" / "first" / "state of the art" (the paper explicitly
  declines novelty claims)
- "CVE for X" where X is a vendor (libel risk)# CLAIMS.md — what DQA does and does not assert

**Status:** DRAFT. Authoritative list of engineering claims
the author is willing to defend. Anything outside this list is **not**
claimed.

## What DQA claims (each falsifiable by test)

1. **Byte-level Unicode hygiene.** The reference `dq-deworm` filter
   rejects every byte in the pinned `WORM_BYTES` table and every
   code point in the pinned `RULE_RANGES` list at the boundary
   specified in Section III of the paper. This is a *hygiene* claim
   (what the filter does to bytes), not a *security* claim (what the
   filter guarantees about adversary behavior).
2. **Strict RFC 3629 conformance.** The reference decoder rejects
   overlong encodings, UTF-8 encodings of surrogates
   (U+D800–U+DFFF), and encodings of code points above U+10FFFF.
3. **Pinned fingerprint tamper evidence.** The compile-time
   constants `DEWORM_BITMAP_VERSION`, `CODEPOINT_RULES_VERSION`,
   `FSM_RULES_VERSION`, `PIPELINE_RULES_VERSION`, and the combined
   `DEWORM_FINGERPRINT_V2` change if and only if the underlying
   rule tables change.
4. **Manifest binding under joint unforgeability.** A manifest
   accepted by a conforming verifier uniquely determines the signed
   fields under the joint Ed25519 + ML-DSA-65 unforgeability
   assumption.
5. **Independent reimplementability.** Any implementation that
   reproduces each expected decision in `test-vectors/` byte-for-byte
   is conformant for the purposes of this specification.

## What DQA explicitly does NOT claim

1. **No novelty claim.** We do not assert that this specification
   advances the state of the art. The filter, the manifest, the
   hybrid signing scheme, and the anchor mechanisms are each built
   from publicly available components predating this work.
2. **No "cure," "immunity," or "elimination"** of GlassWorm,
   Trojan Source, or any other vulnerability class.
3. **No semantic model-poisoning detection.** DQA verifies
   provenance of bytes, not behavior of models.
4. **No malware detection.** DQA does not execute, sandbox, or
   behaviorally analyze any artifact.
5. **No protection against runtime compromise** of the verifier
   host.
6. **No protection against key theft.** An attacker with an
   authorized Ed25519 *and* an authorized ML-DSA-65 private key can
   produce valid manifests; the hybrid construction does not help
   against simultaneous theft of both.
7. **No claim of detection beyond the invisible-character and
   provenance-swap sub-classes.**
8. **No endorsement of any specific quantization mathematics.**
9. **No completeness claim** with respect to future Unicode
   standards or newly discovered invisible-character techniques.

## Forbidden marketing language

The following terms MUST NOT appear in any paper, README, release
note, blog post, or social-media statement authored under the
DynamicQuant project without explicit review:

- "cure" / "cured" / "cures"
- "immune" / "immunity"
- "unbreakable"
- "guaranteed safe"
- "zero-risk"
- "AI safety" (as a property of DQA)
- "novel" / "first" / "state of the art" (the paper explicitly
  declines novelty claims)
- "CVE for X" where X is a vendor (libel risk)
