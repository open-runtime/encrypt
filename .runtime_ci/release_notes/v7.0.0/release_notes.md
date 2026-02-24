# encrypt v7.0.0

> This major release introduces critical security enhancements to protect against timing side-channel attacks and brute-force vulnerabilities. It also adds strict validation for cryptographic primitives and introduces a helpful base64 URL-safe encoding utility.

## Highlights

- **CRITICAL Security Fixes** — Mitigates timing side-channel attacks in Fernet HMAC verification and RSA signature verification using constant-time comparison.
- **Enhanced PBKDF2 Defaults** — Drastically improves resistance to brute-force attacks by raising the default `Key.stretch` iterations from 100 to 600,000 to align with OWASP recommendations.
- **Strict Key/IV Validation** — Prevents cryptographic misuse by strictly enforcing standard key lengths (16, 24, or 32 bytes) and IV lengths (12 bytes for GCM, 16 bytes for others) in AES algorithms.

## Breaking Changes

> **2 breaking changes** in this release.
> See the full [Migration Guide](migration_guide.md) for step-by-step instructions.

| Change | Quick Fix |
|--------|-----------|
| PBKDF2 iteration count increased from 100 to 600,000 by default | `iterationCount: 100` |
| Strict validation for AES key and IV lengths has been added | Ensure valid lengths |

### Breaking Change 1: PBKDF2 Iteration Count

**What changed:** The default iteration count for `Key.stretch` has been changed from `100` to `600000`. This is a breaking change because calling `Key.stretch` without specifying the iteration count will now produce a different derived key.

**Before:**
```dart
  Key stretch(int desiredKeyLength, {int iterationCount = 100, Uint8List? salt}) {
```

**After:**
```dart
  Key stretch(int desiredKeyLength, {int iterationCount = 600000, Uint8List? salt}) {
```

**Migration:** If your application relies on the previous default of 100 iterations to decrypt existing data, you must explicitly set `iterationCount: 100` when calling `Key.stretch()`.

### Breaking Change 2: AES Key/IV Length Validation

**What changed:** Stricter validation for AES key and IV lengths will now throw an `ArgumentError` immediately if an invalid length is provided, whereas previously it might have failed later or produced undefined behavior.

**Before:**
```dart
  AES(this.key, {this.mode = AESMode.sic, this.padding = 'PKCS7'})
    : _streamCipher = padding == null && _streamable.contains(mode) ? StreamCipher('AES/${_modes[mode]}') : null {
```

**After:**
```dart
  AES(this.key, {this.mode = AESMode.sic, this.padding = 'PKCS7'})
    : _streamCipher = padding == null && _streamable.contains(mode) ? StreamCipher('AES/${_modes[mode]}') : null {
    if (key.bytes.length != 16 && key.bytes.length != 24 && key.bytes.length != 32) {
      throw ArgumentError(
        'AES key must be 16, 24, or 32 bytes (128, 192, or 256 bits). '
        'Got ${key.bytes.length} bytes.',
      );
    }
```

**Migration:** Ensure your AES keys are exactly 16, 24, or 32 bytes long, and your IVs are 12 bytes for GCM mode and 16 bytes for other modes. Provide valid length keys and IVs to prevent `ArgumentError`.

## What's New

### SecureRandom.base64Url
Added `base64Url` getter to `SecureRandom` for URL-safe base64 encoding without relying on external dependencies or manual conversions.
```dart
final random = SecureRandom(32);
print(random.base64Url);
```

## Bug Fixes

- **AES Validation** — Validated AES key lengths (16/24/32 bytes) and IV lengths (12 bytes for GCM, 16 for others) to prevent misuse ([#18](https://github.com/open-runtime/encrypt/pull/18), fixes [#18](https://github.com/open-runtime/encrypt/issues/18))
- **Fernet Timing Attack** — Implemented constant-time XOR-accumulation comparison for Fernet HMAC verification to fix timing side-channel attacks ([#16](https://github.com/open-runtime/encrypt/pull/16), fixes [#16](https://github.com/open-runtime/encrypt/issues/16))
- **RSA Timing Attack** — Used constant-time XOR comparison for equal-length RSA signature verification to fix timing side-channel attacks ([#16](https://github.com/open-runtime/encrypt/pull/16), fixes [#16](https://github.com/open-runtime/encrypt/issues/16))

## Issues Addressed

- [#18](https://github.com/open-runtime/encrypt/issues/18) — fix(security): AES key/IV validation, SecureRandom.base64Url, GCM docs + tests (confidence: 100%)
- [#16](https://github.com/open-runtime/encrypt/issues/16) — fix(security): 4 CRITICAL vulnerability fixes (confidence: 100%)
## Deprecations

- `AESMode.ecb` is deprecated — use `AESMode.gcm` or `AESMode.cbc` instead. Will be removed in v8.0.0.

## Upgrade

```bash
dart pub upgrade encrypt
dart fix --apply  # Automated fixes for breaking changes
```

Then follow the [Migration Guide](migration_guide.md) for any remaining manual changes.

## Contributors

Thanks to everyone who contributed to this release:
- @tsavo-at-pieces
## Full Changelog

[v6.0.2...v7.0.0](https://github.com/open-runtime/encrypt/compare/v6.0.2...v7.0.0)
