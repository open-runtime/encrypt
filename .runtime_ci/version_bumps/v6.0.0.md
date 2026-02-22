# Version Bump Rationale

**Decision**: major

This release includes breaking changes to the public API by renaming enum values to comply with Dart's lint rules.

## Key Changes
- Modernized the library directive from `library encrypt;` to `library;`
- Modernized `part of` directives to use URI syntax instead of library names
- Applied `use_super_parameters` in `IV`, `Key`, `RSA`, and `RSASigner` constructors
- Utilized null-aware assignment (`??=`) operators in `Fernet` and `Key.stretch`
- Fixed unintentionally parsed HTML in doc comments
- Bumped `runtime_ci_tooling` dependency to `^0.9.0`
- Chore: fixed all analyzer lint issues (42 -> 0)

## Breaking Changes
- Renamed `RSAEncoding` enum values from uppercase (`PKCS1`, `OAEP`) to lowerCamelCase (`pkcs1`, `oaep`)
- Renamed `RSADigest` enum values from uppercase (`SHA1`, `SHA256`, `SHA512`) to lowerCamelCase (`sha1`, `sha256`, `sha512`)
- Renamed `RSASignDigest` enum values from uppercase (`SHA256`, `SHA512`) to lowerCamelCase (`sha256`, `sha512`)

## New Features
- None.

## References
- Commit: chore: fix all analyzer lint issues (42 -> 0)
