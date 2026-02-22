# encrypt v6.0.0

> This major release modernizes the `encrypt` package and resolves all analyzer lint issues to ensure a cleaner and more stable codebase. As part of this effort, RSA encoding and digest enum values have been renamed to `lowerCamelCase` to comply with Dart's `constant_identifier_names` lint rule, necessitating a major version bump.

## Highlights

- **Standardized Constants** — RSA encoding and digest enum values now use `lowerCamelCase` for compliance with Dart lint rules.
- **Modernized Directives** — Updated all `part of` directives to use URI syntax and removed the named library directive.
- **Codebase Cleanliness** — Resolved 42 analyzer lint issues across the package, enhancing overall reliability and maintainability.

## Breaking Changes

> **1 breaking change** in this release.
> See the full [Migration Guide](migration_guide.md) for step-by-step instructions.

| Change | Quick Fix |
|--------|-----------|
| Renamed RSA and digest enum values | Replace uppercase enum usages like `RSAEncoding.PKCS1` with `RSAEncoding.pkcs1` |

### Breaking Change 1: Renamed RSA and Digest Enum Values

**What changed:** `RSAEncoding`, `RSADigest`, and `RSASignDigest` enum values were renamed from uppercase to `lowerCamelCase`.

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

**Migration:** Update all references to these enum values throughout your codebase to match the new `lowerCamelCase` formats (e.g., replace `RSAEncoding.PKCS1` with `RSAEncoding.pkcs1`).

## What's New

### Modernized Dart Syntax and Directives
The library has been updated to take advantage of modern Dart syntax, such as `use_super_parameters` across constructors (`IV`, `Key`, `RSA`, and `RSASigner`) and null-aware assignment operators (`??=`) in the `Fernet` algorithm and `Key.stretch`. Furthermore, `part of` directives now use URI syntax instead of named libraries.

## Bug Fixes

- **Codebase Lint Errors** — Fixed 42 analyzer lint issues across the library, including correcting unintentionally parsed HTML in documentation comments and proper usage of null-aware assignment operators.

## Issues Addressed

No linked issues for this release.
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

[v5.1.11...v6.0.0](https://github.com/open-runtime/encrypt/compare/v5.1.11...v6.0.0)
