# encrypt v7.0.4

> Maintenance release — 2026-02-24

This release focuses on strengthening our continuous integration pipeline. We have upgraded `runtime_ci_tooling` to `v0.13.0`, which splits the previously combined analysis and testing phases into separate jobs. Most notably, we have enabled a comprehensive 6-platform test matrix (Ubuntu x64/arm64, macOS x64/arm64, Windows x64/arm64) utilizing organization-managed runners to ensure robust cross-platform compatibility.

## Maintenance & CI

- **Upgrade CI Tooling** — Upgraded `runtime_ci_tooling` dev_dependency to `^0.13.0`.
- **Expanded Test Matrix** — Split `analyze-and-test` into separate jobs and enabled a 6-platform test matrix using org-managed runners for enhanced validation.

## Upgrade

```bash
dart pub upgrade encrypt
```

## Contributors

Thanks to everyone who contributed to this release:
- @tsavo-at-pieces
## Issues Addressed

No linked issues for this release.
## Full Changelog

[v7.0.3...v7.0.4](https://github.com/open-runtime/encrypt/compare/v7.0.3...v7.0.4)
