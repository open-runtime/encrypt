# Migration Guide: v5.1.11 → v6.0.0

## Table of Contents
- [Renamed RSA and Digest Enum Values](#renamed-rsa-and-digest-enum-values)

---

## Renamed RSA and Digest Enum Values

### Summary
RSA encoding and digest enum values have been renamed to `lowerCamelCase`.

### Background
This change satisfies the `constant_identifier_names` lint rule in Dart, bringing the `encrypt` package in line with modern Dart style conventions.

### Migration

Update your code to reference the newly lowercased enum values.

**Before:**
```dart
  encrypter = Encrypter(
    RSA(
      publicKey: publicKey,
      privateKey: privKey,
      encoding: RSAEncoding.OAEP,
      digest: RSADigest.SHA256,
    )
  );
```

**After:**
```dart
  encrypter = Encrypter(
    RSA(
      publicKey: publicKey,
      privateKey: privKey,
      encoding: RSAEncoding.oaep,
      digest: RSADigest.sha256,
    )
  );
```

### References
- Commit: 449f220 chore: fix all analyzer lint issues (42 -> 0)
