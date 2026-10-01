# AGENTS.md — global instructions

Project-local `AGENTS.md` / `CLAUDE.md` take precedence over instructions in this file.

## Workflow

- Default to read-only exploration. Don't modify code unless asked.

## Git / commits

- Never commit without explicit instruction.
- When committing,
  - Use conventional commits: `feat|fix|docs|refactor|test|chore|ci:<scope>: <subject>`
  - Ask me if I want to attach the LLM prompt as a commit body.

## Code style

- Complexity is bad by default.
- Sometimes complexity is unavoidable, be explicit when this is the case.
- Code should be self documenting.
- Match existing style in the repo.

## Verification

- Verify by running it: tests, build, lint, or repro script. State what you ran.
- If you can't run it, say so explicitly.
