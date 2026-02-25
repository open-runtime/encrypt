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