# encrypt v7.0.2

> Bug fix release — 2026-02-24

## Bug Fixes

- **Prevent upstream leakage during issue triage** — Added shell-level organization guards (`open-runtime` and `pieces-app`) and explicit `--repo` arguments to the `.gemini/commands/triage.toml` tool command. This prevents `gh` commands from resolving to upstream repositories when executed within fork contexts and adds duplicate checking logic to prevent redundant triage comments.

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

[v7.0.1...v7.0.2](https://github.com/open-runtime/encrypt/compare/v7.0.1...v7.0.2)
