## [6.0.0] - 2026-02-22

### Breaking Changes
- **BREAKING**: Renamed RSA encoding and digest enum values to lowerCamelCase.
  - Migration: `RSAEncoding.PKCS1` → `RSAEncoding.pkcs1`, `RSADigest.SHA256` → `RSADigest.sha256`, etc.

### Changed
- Renamed RSA and digest enum values to lowerCamelCase to satisfy the constant_identifier_names lint rule.
- Modernized all part-of directives to use URI syntax and updated the library directive to be unnamed.
- Applied use_super_parameters across IV, Key, RSA, and RSASigner classes.
- Bumped runtime_ci_tooling dev_dependency to ^0.9.0.

### Fixed
- Fixed 42 analyzer lint issues, including the use of null-aware assignment operators in Fernet and Key.stretch, and escaping angle brackets in doc comments.