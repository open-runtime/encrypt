# Migration Guide: v6.0.2 → v7.0.0

## Table of Contents
- [PBKDF2 Iteration Count](#pbkdf2-iteration-count)
- [AES Key/IV Length Validation](#aes-keyiv-length-validation)

---

## PBKDF2 Iteration Count

### Summary
The default iteration count for `Key.stretch` has been increased from 100 to 600,000.

### Background
This change aligns with OWASP recommendations for PBKDF2-HMAC-SHA1 to provide stronger resistance against brute-force attacks.

### Migration

**Before:**
```dart
  Key stretch(int desiredKeyLength, {int iterationCount = 100, Uint8List? salt}) {
```

**After:**
```dart
  Key stretch(int desiredKeyLength, {int iterationCount = 600000, Uint8List? salt}) {
```

If your application relies on the previous default to decrypt existing data, explicitly set `iterationCount: 100` when deriving keys.

### References
- PR: [#16](https://github.com/open-runtime/encrypt/pull/16)

---

## AES Key/IV Length Validation

### Summary
Strict validation for AES key and IV lengths has been added, throwing an `ArgumentError` for invalid lengths.

### Background
To prevent cryptographic misuse and undefined behavior, AES keys and IVs must now be of standard lengths.

### Migration

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

Ensure your AES keys are exactly 16, 24, or 32 bytes, and your IVs are 12 bytes for GCM mode and 16 bytes for other modes. Provide valid length keys and IVs to prevent `ArgumentError`.

### References
- PR: [#18](https://github.com/open-runtime/encrypt/pull/18)
