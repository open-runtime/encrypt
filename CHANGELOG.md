# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

## [5.1.6](https://github.com/pieces-app/encrypt/compare/v5.1.5...v5.1.6) (2025-11-30)

### 🚀 Release Highlights

This release improves the reliability of the automated release workflow by ensuring proper version detection and tag handling. The fix prevents workflow failures when managing releases, resulting in more stable and predictable release automation for the encrypt library.

### 🐛 Bug Fixes

* run handle-untagged-releases before Release Please to prevent abort ([62c8541](https://github.com/pieces-app/encrypt/commit/62c854168d815085b51fd3f4918b5187012b1503))
* run handle-untagged-releases before Release Please to prevent abort ([#12](https://github.com/pieces-app/encrypt/issues/12)) ([0ba0ea5](https://github.com/pieces-app/encrypt/commit/0ba0ea53ae8f89e85f112e8ac614d7670e2cf9ae))

## [5.1.5](https://github.com/pieces-app/encrypt/compare/v5.1.4...v5.1.5) (2025-11-30)

### 🚀 Release Highlights

This release focuses on improving developer experience and workflow reliability with enhanced CI/CD automation. Key improvements include better version detection for release management and comprehensive documentation of the automated workflows that ensure code quality and streamlined releases.

### 🐛 Bug Fixes

* add workflow_dispatch trigger to enhance-release-pr workflow ([a83d6ab](https://github.com/pieces-app/encrypt/commit/a83d6ab29a4e49eeea07d5cb0ed64e56afcc6316))
* replace grep -oP with portable sed commands and fix YAML lint errors ([257301f](https://github.com/pieces-app/encrypt/commit/257301f4a58182c7945a0e819d618913b9342732))
* update manifest to match latest actual release (5.1.4) ([22f656a](https://github.com/pieces-app/encrypt/commit/22f656a7d7e9301302d10d986734bcb2372b82f2))
* Use base branch manifest and GitHub releases for previous version detection ([829d65b](https://github.com/pieces-app/encrypt/commit/829d65bfbb68562bf8a9b8ee3bbce68993e7d3ff))


### 📚 Documentation

* Add AI-enhanced release highlights for v5.1.5 ([65e0041](https://github.com/pieces-app/encrypt/commit/65e0041f969b1d5f3f2015047178d6232b803a25))
* add clarifying comment to version detection workflow ([3c61131](https://github.com/pieces-app/encrypt/commit/3c611312e1f70026a92c426535df140c5cad79ef))
* add comprehensive CI/CD workflows documentation ([daaa506](https://github.com/pieces-app/encrypt/commit/daaa506bf80ca9b9d4530daa0adc091c0eab9ed3))
* add comprehensive CI/CD workflows documentation ([#6](https://github.com/pieces-app/encrypt/issues/6)) ([b44f758](https://github.com/pieces-app/encrypt/commit/b44f7587dfa3e8ecc2cb100db9abe4323e31efad))
* apply Copilot AI review suggestions to workflows README ([f933a92](https://github.com/pieces-app/encrypt/commit/f933a920c94882c5fcda4c06b1d5749dff48107f))
* fix Copilot AI review suggestions in workflows README ([547788b](https://github.com/pieces-app/encrypt/commit/547788b27a84176d5ebf191b108ea4dcfbff5fa4))
* fix Copilot AI review suggestions in workflows README ([a213efc](https://github.com/pieces-app/encrypt/commit/a213efc38e520be6f6b25e4f4ddf5646bcad7775))


### 🔧 Chores

* release 5.1.5 ([fde8f54](https://github.com/pieces-app/encrypt/commit/fde8f546a297d6794153d69c0dbaa12f7a7f37fc))
* release 5.1.5 ([803ac26](https://github.com/pieces-app/encrypt/commit/803ac2631509e34fc87a01358d183ab0d84a130c))
* update workflows to use main branch instead of 5.x ([fa9a025](https://github.com/pieces-app/encrypt/commit/fa9a02582ef8fece47ac43fb2fb0e54ee3027023))

## [5.1.5](https://github.com/pieces-app/encrypt/compare/v5.1.4...v5.1.5) (2025-11-30)

### 🚀 Release Highlights

This release enhances developer experience with comprehensive CI/CD workflows documentation, making it easier to understand and contribute to the library's automated testing and release processes. The documentation improvements help teams integrate the encrypt library more confidently into their production environments.

### 📚 Documentation

* add comprehensive CI/CD workflows documentation ([#6](https://github.com/pieces-app/encrypt/issues/6)) ([b44f758](https://github.com/pieces-app/encrypt/commit/b44f7587dfa3e8ecc2cb100db9abe4323e31efad))

## [5.1.4](https://github.com/pieces-app/encrypt/compare/v5.1.3...v5.1.4) (2025-11-30)


### 🐛 Bug Fixes

* resolve dart analyze lint errors ([6b2e2a7](https://github.com/pieces-app/encrypt/commit/6b2e2a79eb86f45b89c206d47225d4bcb60dd1d9))

## [5.1.3](https://github.com/pieces-app/encrypt/compare/v5.1.2...v5.1.3) (2025-11-30)


### 🐛 Bug Fixes

* ensure verify-release runs when fallback job creates releases ([ba07afe](https://github.com/pieces-app/encrypt/commit/ba07afec25b5d2947fb7bf691d10c0601c9b0ca3))

## [5.1.2](https://github.com/pieces-app/encrypt/compare/v5.1.1...v5.1.2) (2025-11-30)


### 🐛 Bug Fixes

* use github.event.pull_request.head.ref instead of github.head_ref ([369e899](https://github.com/pieces-app/encrypt/commit/369e8997889a2ec4c5ab880b4b72ecde07897a07))


### 📚 Documentation

* add release highlights for v5.1.0 and v5.1.1 ([d04ff34](https://github.com/pieces-app/encrypt/commit/d04ff34a8fb626ac05d81ab4eccea51fc877a92c))

## [5.1.1](https://github.com/pieces-app/encrypt/compare/v5.1.0...v5.1.1) (2025-11-30)


### 🔧 Chores

* disable pub.dev publishing ([e364c12](https://github.com/pieces-app/encrypt/commit/e364c128fb447467ed407c8630d72c14f620ab70))

## [5.1.0](https://github.com/pieces-app/encrypt/compare/v5.0.4...v5.1.0) (2025-11-30)


### ✨ Features

* add support for OAEP SHA256 ([#263](https://github.com/pieces-app/encrypt/issues/263)) ([e95fbf4](https://github.com/pieces-app/encrypt/commit/e95fbf47b9c5843c902d4c5b20dcc6a5ff6b9141))
* null safety ([#195](https://github.com/pieces-app/encrypt/issues/195)) ([1c9aa8f](https://github.com/pieces-app/encrypt/commit/1c9aa8f12e8dbe57f9b5e561239f6ec0dbe6988a))
* optional padding (default pkcs7) ([3f86652](https://github.com/pieces-app/encrypt/commit/3f8665296bd1d157bce84547e72ae72cc7f7d987))
* optional padding (default pkcs7) ([6d4c12b](https://github.com/pieces-app/encrypt/commit/6d4c12b528023747aae746b270c703cd05619c79))


### 🐛 Bug Fixes

* 32 ([32d2091](https://github.com/pieces-app/encrypt/commit/32d20914adefa4b45e75948133a6dc5d6f7f3012))
* Could not parse version "~3.6.2" ([#315](https://github.com/pieces-app/encrypt/issues/315)) ([f92c4f1](https://github.com/pieces-app/encrypt/commit/f92c4f18c5b775a50a949da1e86c2f6e924edd89))


### ♻️ Refactoring

* remove deprecated author attr ([f409383](https://github.com/pieces-app/encrypt/commit/f409383c92892d7302afa52b3d6f860ddca74b5d))


### 🔧 Chores

* add CI/CD setup completion marker ([07bf815](https://github.com/pieces-app/encrypt/commit/07bf815cb1163eb5f418ea14df9e3ba87dec33ae))
* **deps:** bump ([8430a34](https://github.com/pieces-app/encrypt/commit/8430a34b5b62fef07cfa9e185a5b2fab1ce9b749))
* **docs:** add 5.0.0-beta.1 to changelog ([def73f6](https://github.com/pieces-app/encrypt/commit/def73f6a42f88d6b609b18fca7be87ee369838c8))
* **docs:** changelog ([bc2a3f4](https://github.com/pieces-app/encrypt/commit/bc2a3f44339574edb5c374b991b6386c495a1bbb))
* update pointy castle dep ([fcf1fe0](https://github.com/pieces-app/encrypt/commit/fcf1fe0c474262e121292f7d3eacb6319ac7bf1b))
* version bump, closes [#200](https://github.com/pieces-app/encrypt/issues/200) ([267e516](https://github.com/pieces-app/encrypt/commit/267e516367eb05896787d5f461dc2a7dd564c044))

## 5.0.4

- Force Pointycastle version

## 5.0.3

- Fixed tests failing with AES ECB with padding by @JimWuerch in #312
- fix: Could not parse version "~3.6.2" by @Marc-R2 in #315

## 5.0.2

- Update pointycastle version to support AES-GCM with Flutter Web
- Support AES-GCM
- Fixed null safety related warnings from `package:asnlib`.

## 5.0.1

- Fix web support

## 5.0.0

- Null safety support stable (sdk: ">=2.12.0 <3.0.0")

## 5.0.0-beta.1

- Preview/prerelase null safety support

## 4.1.0

- PointyCastle v2

## 4.0.3

- Fix UTF-8 conversion on Fernet keys.

## 4.0.2

- Fix streamble AES modes without padding.

## 4.0.1

- Upgrade dependencies.

## 4.0.0

- Digital signatures signing and verification.

## 3.3.1

- Move I/O helper to another lib

## 3.3.0

- Added the Fernet algorithm, thanks to [@timfeirg](https://github.com/timfeirg)
- Moved the secure random logic to the lib
- Added key stretching

## 3.2.0

- Fix wrong casting.
- Add decryptBytes, avoids UTF-8 high coupling.
- Add public decryption and private encryption for digital signature verification.

## 3.1.0

- Add support for CRLF PEM keys.
- Fix AES without padding.
- Add `encryptBytes` method.

## 3.0.0

- Enforce IV uniqueness.

## 2.2.0

- AES padding is now optional with defaults to PKCS7.

## 2.1.0

- `secure-random` command-line tool.

## 2.0.0

- All new API

## 1.0.1

- RSA

## 1.0.0

- Stable and documented API

## 0.2.0+2

- Remove unnecessary `new`s
- Improve static typing
- Add examples index (README)

## 0.2.0+1

- Refresh dependencies, make sure it works on Dart 2

[6.0.0]: https://github.com/open-runtime/encrypt/compare/v5.1.6...v6.0.0
[5.1.6]: https://github.com/open-runtime/encrypt/compare/v5.1.5...v5.1.6
[5.1.5]: https://github.com/open-runtime/encrypt/compare/v5.1.5...v5.1.5
[5.1.5]: https://github.com/open-runtime/encrypt/compare/v5.1.4...v5.1.5
[5.1.4]: https://github.com/open-runtime/encrypt/compare/v5.1.3...v5.1.4
[5.1.3]: https://github.com/open-runtime/encrypt/compare/v5.1.2...v5.1.3
[5.1.2]: https://github.com/open-runtime/encrypt/compare/v5.1.1...v5.1.2
[5.1.1]: https://github.com/open-runtime/encrypt/compare/v5.1.0...v5.1.1
[5.1.0]: https://github.com/open-runtime/encrypt/releases/tag/v5.1.0
