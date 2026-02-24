# Version Bump Rationale

**Decision**: patch

The recent changes since `v7.0.1` are entirely constrained to internal CLI and tooling configuration (`.gemini/commands/triage.toml`), modifying how issue triage processes execute GitHub (`gh`) commands. As this does not affect the public API surface of the Dart package, introduce new library features, or contain any breaking changes, it strictly warrants a patch bump as a choreography/maintenance update.

**Key Changes**:
- Added the `--repo` flag and an organization allowlist (`open-runtime`, `pieces-app`) to the `.gemini/commands/triage.toml` tool command.
- Added logic to verify repository ownership to prevent upstream command execution leakage in fork contexts.
- Added duplicate checking logic by reviewing existing issue comments prior to posting.

**Breaking Changes**:
- None.

**New Features**:
- None.

**References**:
- Commit `HEAD` (fix(triage): add --repo + org allowlist to triage.toml to prevent upstream leakage)
