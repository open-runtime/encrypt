# encrypt v7.0.5

- **Decision**: patch
- **Key Changes**:
  - Fix: Updated the GCM example to correctly use a 12-byte IV.
  - Fix: Added explicit detection of encrypted PEM private keys in `RSAKeyParser`, throwing an actionable `FormatException` instead of failing with cryptic ASN.1 parsing errors.
  - Docs: Overhauled README with more accurate documentation on secure random keys/IVs, IV persistence, GCM usage, and platform notes.
  - Tests: Added "battle tests" for CBC IV persistence and GCM IV enforcement.
  - Chore: Formatted code to 120 line length.
- **Breaking Changes**: None.
- **New Features**: None.
- **References**:
  - `fix(security): GCM example IV, encrypted PEM detection, README overhaul`


## Changelog

## [7.0.5] - 2026-02-24

### Added
- Added actionable error messages when attempting to parse passphrase-encrypted PEM private keys
- Added extensive README updates covering secure random IVs, IV persistence, GCM mode, and platform compliance notes
- Added battle tests for CBC IV persistence and GCM IV enforcement

### Changed
- Applied dart format with 120 line length across modified files

### Fixed
- Fixed AES-GCM example to correctly use a 12-byte IV instead of 16-byte

### Security
- Enforced correct IV usage in GCM examples and clarified IV persistence in documentation to prevent nonce-reuse vulnerabilities

---
[Full Changelog](https://github.com/open-runtime/encrypt/compare/v7.0.4...v7.0.5)
