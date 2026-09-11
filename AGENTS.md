# Agent Rules

- **Declarative Configuration (Chezmoi):** This system is managed by Chezmoi. Unless explicitly asked to make a one-off system-level change directly, always modify the Chezmoi configuration rather than the host directly. Never run manual installation, setup, or configuration commands (such as `agy install` or manual profile updates) directly on the host. All packages, environment variables, paths, and initializations must be configured declaratively in the Chezmoi source repository (e.g., `.chezmoidata/packages.yaml` and the `.tmpl` files). Only run `chezmoi apply` if explicitly requested or needed to verify the change.
- **Adding Packages & Tools:**
  - **Default to Homebrew:** Assume CLI tools are standard Homebrew formulas under `packages.brews.<target>` in `.chezmoidata/packages.yaml`, and GUI applications are casks under `packages.casks.<target>`. Maintain alphabetical order.
  - **Target Profile Mapping:**
    - "all machines" / base → `brews.base`
    - "development machines" → `brews.development` (or `casks.development` for GUI)
    - "container machines" → `brews.container`
    - "workstations" → `casks.workstation`
    - "personal machines" → `casks.personal`
  - **Ask, Don't Research:** Do not perform external web searches, inspect formula code, check background services, or explore shell completions/integrations. If the package name, tap, or install mechanism is ambiguous, ask the user directly for clarification or the exact install command.
  - **No Unnecessary `apply` or Diffs:** Do not run `chezmoi diff` (which can trigger 1Password secret resolution) or `chezmoi apply` unless explicitly asked. Updating `.chezmoidata/packages.yaml` and committing the change is usually sufficient.
- **Source Control & Configuration:** Never add configuration files or directories (e.g., `.rtk`, `.config`) directly to the repository. Always use `chezmoi add ~/.<path>` to ensure they are tracked according to chezmoi's conventions and properly templated if necessary.
- **Shell Consistency:** Always keep Zsh and Fish configurations in sync. When adding or updating paths, environment variables, or tool initializations in one shell, apply the equivalent change to the other.
- **Shell Functions:** Maintain shell functions as standalone scripts in their respective autoload directories (`dot_config/fish/private_functions/` and `dot_config/zsh/private_functions/`). Ensure the logic remains identical between both implementations.
- **1Password Session Management (Linux / Headless):** On headless Linux environments, `op` CLI commands and Chezmoi templates require pre-authenticated session tokens:
  - **Chezmoi Go Templates:** Chezmoi translates account domains to account UUIDs and checks `OP_SESSION_<account_uuid>`.
  - **1Password CLI in Post-Run Scripts:** The CLI looks for `OP_SESSION_<shorthand>`. If the account shorthand is a domain (e.g. `my.1password.com`), the variable contains literal dots (`OP_SESSION_my.1password.com`).
  - **Shell Identifier Restrictions:** Unix shells (Bash, Zsh, Fish) reject dots in variable names (`export: not valid in this context`). Therefore, tokens must be captured via `op signin --raw` (never shell `eval $(op signin)`), and dotted variables must be passed directly to the `chezmoi` process table via `/usr/bin/env`.
  - **Autoloaded Wrappers:** The wrapper functions in `dot_config/zsh/private_functions/chezmoi.tmpl` and `dot_config/fish/private_functions/private_chezmoi.fish.tmpl` maintain this isolation and environment propagation. Keep them synchronized whenever modifying authentication or secret workflows.

