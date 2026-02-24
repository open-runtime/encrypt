## [7.0.0] - 2026-02-24

### Breaking Changes
- **BREAKING**: PBKDF2 iteration count increased from 100 to 600,000 by default (#16) (fixes #16)
  - Migration: Default `Key.stretch` behavior → explicitly set `iterationCount: 100` for legacy derivation
- **BREAKING**: Strict validation for AES key and IV lengths has been added (#18) (fixes #18)
  - Migration: Unvalidated AES keys/IVs → keys must be 16, 24, or 32 bytes; IVs 12 bytes (GCM) or 16 bytes (others)

### Added
- Added `base64Url` getter to `SecureRandom` for URL-safe encoding (#18) (fixes #18)
- Added auto-format job to CI workflow and updated config (#16) (fixes #16)

### Changed
- Raised `Key.stretch` (PBKDF2) default iterations from 100 to 600,000 per OWASP recommendations (#16) (fixes #16)
- Updated `runtime_ci_tooling` dependency to `^0.11.0`

### Deprecated
- Deprecated insecure AES ECB mode that leaks plaintext patterns -- will be removed in v8.0.0 (#16) (fixes #16)

### Fixed
- Validated AES key lengths (16/24/32 bytes) and IV lengths (12 bytes for GCM, 16 for others) to prevent misuse (#18) (fixes #18)

### Security
- Implemented constant-time XOR-accumulation comparison for Fernet HMAC verification to fix timing side-channel attacks (#16) (fixes #16)
- Used constant-time XOR comparison for equal-length RSA signature verification to fix timing side-channel attacks (#16) (fixes #16)