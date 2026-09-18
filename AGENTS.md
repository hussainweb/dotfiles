# Agent Rules

- **Declarative Configuration (Chezmoi):** This system is managed by Chezmoi. Unless explicitly asked to make a one-off system-level change directly, always modify the Chezmoi configuration rather than the host directly. Never run manual installation, setup, or configuration commands (such as `agy install` or manual profile updates) directly on the host. All packages, environment variables, paths, and initializations must be configured declaratively in the Chezmoi source repository (e.g., `.chezmoidata/packages.yaml` and the `.tmpl` files). Only run `chezmoi apply` if explicitly requested or needed to verify the change.
- **Adding Packages & Tools:**
  - **Default to Homebrew & Verify Type:** Assume tools are distributed via Homebrew. Run a quick `brew info <name>` to verify availability and whether it is a formula (`brews.<target>`) or a cask (`casks.<target>` or `casks.cli`). Note that certain CLI tools (e.g. `claude-code`, `entire`) are packaged as casks. Maintain alphabetical order in lists.
  - **Target Profile Mapping:**
    - "all machines" / base → `brews.base`
    - "development machines" → `brews.development` (or `casks.development` for GUI)
    - "container machines" → `brews.container`
    - "workstations" → `casks.workstation`
    - "personal machines" → `casks.personal`
  - **Ask, Don't Research:** If `brew info` fails, requires an unknown tap, or is ambiguous, ask the user directly for clarification or the exact install command. Do not perform external web searches, inspect formula source code, check background services, or explore shell completions/integrations.
  - **No Unnecessary `apply` or Diffs:** Do not run `chezmoi diff` (which can trigger 1Password secret resolution) or `chezmoi apply` unless explicitly asked. Updating `.chezmoidata/packages.yaml` and committing the change is usually sufficient.
- **Source Control & Configuration:** Never add configuration files or directories (e.g., `.rtk`, `.config`) directly to the repository. Always use `chezmoi add ~/.<path>` to ensure they are tracked according to chezmoi's conventions and properly templated if necessary.
- **Shell Consistency:** Always keep Zsh and Fish configurations in sync. When adding or updating paths, environment variables, or tool initializations in one shell, apply the equivalent change to the other.
- **Shell Functions:** Maintain shell functions as standalone scripts in their respective autoload directories (`dot_config/fish/private_functions/` and `dot_config/zsh/private_functions/`). Ensure the logic remains identical between both implementations.
- **1Password Session Management (Linux / Headless):** On headless Linux environments, `op` CLI commands and Chezmoi templates require pre-authenticated session tokens:
  - **Chezmoi Go Templates:** Chezmoi translates account domains to account UUIDs and checks `OP_SESSION_<account_uuid>`.
  - **1Password CLI in Post-Run Scripts:** The CLI looks for `OP_SESSION_<shorthand>`. If the account shorthand is a domain (e.g. `my.1password.com`), the variable contains literal dots (`OP_SESSION_my.1password.com`).
  - **Shell Identifier Restrictions:** Unix shells (Bash, Zsh, Fish) reject dots in variable names (`export: not valid in this context`). Therefore, tokens must be captured via `op signin --raw` (never shell `eval $(op signin)`), and dotted variables must be passed directly to the `chezmoi` process table via `/usr/bin/env`.
  - **Autoloaded Wrappers:** The wrapper functions in `dot_config/zsh/private_functions/chezmoi.tmpl` and `dot_config/fish/private_functions/private_chezmoi.fish.tmpl` maintain this isolation and environment propagation. Keep them synchronized whenever modifying authentication or secret workflows.


<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:46cd31e7 -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.

## Agent Context Profiles

The managed Beads block is task-tracking guidance, not permission to override repository, user, or orchestrator instructions.

- **Conservative (default)**: Use `bd` for task tracking. Do not run git commits, git pushes, or Dolt remote sync unless explicitly asked. At handoff, report changed files, validation, and suggested next commands.
- **Minimal**: Keep tool instruction files as pointers to `bd prime`; use the same conservative git policy unless active instructions say otherwise.
- **Team-maintainer**: Only when the repository explicitly opts in, agents may close beads, run quality gates, commit, and push as part of session close. A current "do not commit" or "do not push" instruction still wins.

## Session Completion

This protocol applies when ending a Beads implementation workflow. It is subordinate to explicit user, repository, and orchestrator instructions.

1. **File issues for remaining work** - Create beads for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **Handle git/sync by active profile**:
   ```bash
   # Conservative/minimal/default: report status and proposed commands; wait for approval.
   git status

   # Team-maintainer opt-in only, unless current instructions forbid it:
   git pull --rebase
   bd dolt push
   git push
   git status
   ```
5. **Hand off** - Summarize changes, validation, issue status, and any blocked sync/commit/push step

**Critical rules:**
- Explicit user or orchestrator instructions override this Beads block.
- Do not commit or push without clear authority from the active profile or the current user request.
- If a required sync or push is blocked, stop and report the exact command and error.
<!-- END BEADS INTEGRATION -->

<!-- BEGIN BEADS CODEX SETUP: generated by bd setup codex -->
## Beads Issue Tracker

Use Beads (`bd`) for durable task tracking in repositories that include it. Use the `beads` skill at `.agents/skills/beads/SKILL.md` (project install) or `~/.agents/skills/beads/SKILL.md` (global install) for Beads workflow guidance, then use the `bd` CLI for issue operations.

### Quick Reference

```bash
bd ready                # Find available work
bd show <id>            # View issue details
bd update <id> --claim  # Claim work
bd close <id>           # Complete work
bd prime                # Refresh Beads context
```

### Rules

- Use `bd` for all task tracking; do not create markdown TODO lists.
- Run `bd prime` when Beads context is missing or stale. Codex 0.129.0+ can load Beads context automatically through native hooks; use `/hooks` to inspect or toggle them.
- Keep persistent project memory in Beads via `bd remember`; do not create ad hoc memory files.

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.
<!-- END BEADS CODEX SETUP -->
