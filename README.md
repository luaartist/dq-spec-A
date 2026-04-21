## DRAFT / REQUEST FOR COMMENTS (RFC)

This is an active work-in-progress draft of the DynamicQuant Attestation Specification. 
It is currently shared for community feedback and peer review. 
This is not a final release.
A permanent, immutable version will be published to Zenodo once the v1 spec is frozen.
## Layout

```
paper/         IEEE-format LaTeX source (main.tex, references.bib, figures/)
schemas/       JSON Schema for manifest.toml / ATTESTATION.json
test-vectors/  Golden input → expected-output vectors for deworm + verifier
scripts/       Build helpers (latexmk, deworm-scan, hash-manifest)
docs/          CLAIMS.md, THREAT_MODEL.md, RELEASE_CHECKLIST.md
```

## Build

```
make paper          # runs dq-deworm scan on *.tex, then latexmk -> PDF
make scan           # scan-only (deworm over all .tex, .md, .bib)
make clean
```

The paper build **fails closed** if `dq-deworm` reports any GlassWorm-class
bytes in the LaTeX source. See `scripts/scan.sh`.

## Status

- [x] Paper skeleton drafted
- [x] Threat model drafted
- [x] Claims document drafted
- [x] Manifest JSON schema v1 frozen
- [x] Test vectors v1 frozen
- [ ] Zenodo metadata confirmed
- [x] OpenTimestamps anchoring plan confirmed

## License

**All Rights Reserved — pending v1 release**
