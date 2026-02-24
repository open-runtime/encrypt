# encrypt v7.0.1

> Bug fix release — 2026-02-24

## Bug Fixes

- **CI pipeline stability** — Bumps the `runtime_ci_tooling` dev dependency to `^0.12.0` (picking up `v0.12.1`). This fixes an issue where `create-release pull --rebase` would fail during the automated release process if previous pipeline steps left unstaged changes.

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

[v7.0.0...v7.0.1](https://github.com/open-runtime/encrypt/compare/v7.0.0...v7.0.1)
