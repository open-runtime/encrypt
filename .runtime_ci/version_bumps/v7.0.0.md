# Version Bump Rationale

**Decision**: major

## Key Changes
- **Security**: Added constant-time XOR comparison in Fernet HMAC verification and RSA signature verification to prevent timing side-channel attacks.
- **Security**: Raised the default PBKDF2 iteration count in `Key.stretch` from 100 to 600,000 to align with OWASP recommendations.
- **Security**: Added strict validation for AES key lengths (16, 24, or 32 bytes) and IV lengths (12 bytes for GCM, 16 bytes for others).
- **Deprecation**: Deprecated `AESMode.ecb` as it is insecure and leaks plaintext patterns.
- **CI**: Updated CI workflows to run auto-formatting and handle bot commits more cleanly.

## Breaking Changes
- The default `iterationCount` for `Key.stretch` has been changed from `100` to `600000`. This is a breaking change because calling `Key.stretch` without specifying the iteration count will now produce a different derived key. Users relying on the old default to decrypt existing data must update their code to explicitly pass `iterationCount: 100`.
- Stricter validation for AES key and IV lengths will now throw an `ArgumentError` immediately if an invalid length is provided, whereas previously it might have failed later or produced undefined behavior.

## New Features
- Added `SecureRandom.base64Url` getter for URL-safe base64 encoding.

## References
- PR #16: fix(security): 4 CRITICAL vulnerability fixes + test update
- PR #18: fix(security): AES key/IV validation, SecureRandom.base64Url, GCM docs + tests
