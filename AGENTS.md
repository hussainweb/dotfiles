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
- **1Password Sessions:** chezmoi's `onepassword.command` points at `.chezmoi-op`, which caches each account's session token in `$XDG_RUNTIME_DIR/chezmoi-op` (tmpfs, 0700) until 1Password expires it, so templates and run scripts share one sign-in per account. Run scripts must get their session with `eval "$({{ joinPath .chezmoi.sourceDir ".chezmoi-op" | quote }} session-env <account>)"` and never call `op signin` themselves, or they prompt for the password a second time. The `.install-1password.sh` pre-hook installs the CLI and adds missing accounts; the accounts come from `.chezmoi.toml.tmpl`.

## Beads

This project tracks its work with beads (`bd`). Before doing anything with issues, read the
`beads` skill at `.agents/skills/beads/SKILL.md` and follow it; it begins with `bd prime`,
which prints the current commands, the session-close protocol and this project's persistent
memories. Track tasks in beads, not in TODO lists, plan files or memory files.
