# AGENTS.md

Instructions for coding agents working in this repository.

## Agent setup: do this before any work

Run this from the repo root in every new clone or worktree, before you edit anything:

```bash
npm install    # installs dependencies and activates the husky hooks (`prepare` script)
```

Check that the hooks are active: `git config core.hooksPath` must print `.husky/_`. If it doesn't
(e.g. `npm install` ran with `--ignore-scripts`), run `npx husky`.

### Commit rules

- **Branch:** `main`, `feature/<name>`, `fix/<name>` or `chore/<name>`.
- **Commit messages:** [Conventional Commits](https://www.conventionalcommits.org): `<type>(<optional scope>)!: <description>`,
  with type one of `feat`, `fix`, `chore`, `build`, `ci`, `docs`, `perf`, `refactor`, `revert`, `style`, `test`.
- **PR title:** same format as a commit message. A squash merge uses it as the commit message on `main`.
- Never bypass the hooks with `--no-verify`.

The local hooks only check agents that installed them. If you skip the setup, nothing stops a bad
commit locally, but the required `conventions` check on the PR fails any non-conforming branch name,
PR title or commit message. Fixing it at that point means rewriting your commits.
