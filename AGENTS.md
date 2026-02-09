# Repository Guidelines

## Project Structure & Module Organization
This repository is a Homebrew tap (`jiulongw/tap`). Keep formulae in `Formula/` using one file per package (for example, `Formula/mytool.rb`).

Current top-level items:
- `README.md`: tap usage and install examples.
- `.github/workflows/tests.yml`: CI syntax and formula validation with `brew test-bot`.
- `.github/workflows/publish.yml`: bottle publish flow via `brew pr-pull` label.

If `Formula/` does not exist yet, create it when adding the first formula.

## Build, Test, and Development Commands
Run from repository root:
- `brew style Formula/<name>.rb`: style check for a formula file.
- `brew audit --strict --new-formula Formula/<name>.rb`: strict audit for new formula submissions.
- `brew test-bot --only-tap-syntax`: run tap-level syntax checks (matches CI).
- `brew test-bot --only-formulae`: run formula checks/build steps (used in PR CI).

Use these before opening a PR to reduce CI failures.

## Coding Style & Naming Conventions
- Use standard Homebrew Ruby formula style and conventions.
- Formula class names: `CamelCase < Formula` (for example, `class Mytool < Formula`).
- Formula filenames: lowercase, typically matching the package name (for example, `mytool.rb`).
- Prefer minimal, deterministic dependencies and avoid unnecessary options.

## Testing Guidelines
- Every formula should include a meaningful `test do` block that verifies basic runtime behavior.
- Keep tests non-interactive and stable in CI.
- Validate locally with `brew test Formula/<name>.rb` when possible, then run `brew test-bot` checks.

## Commit & Pull Request Guidelines
- Follow concise, imperative commit messages. Existing history is short and action-oriented (for example, `Create jiulongw/tap tap`).
- Prefer one logical change per commit.
- PRs should include:
  - What formula(s) changed and why.
  - Upstream version/source URL context.
  - Local command results (`brew style`, `brew audit`, `brew test-bot`).
- Keep PRs focused; separate unrelated formula updates.

## Security & Configuration Tips
- Use trusted, stable source URLs and verify checksums.
- Do not commit secrets or tokens.
- Treat CI as the source of truth for cross-platform validation (Ubuntu and macOS runners).
