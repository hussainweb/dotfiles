# Agent Rules

- **Source Control & Configuration:** Never add configuration files or directories (e.g., `.rtk`, `.config`) directly to the repository. Always use `chezmoi add ~/.<path>` to ensure they are tracked according to chezmoi's conventions and properly templated if necessary.
- **Shell Consistency:** Always keep Zsh and Fish configurations in sync. When adding or updating paths, environment variables, or tool initializations in one shell, apply the equivalent change to the other.
- **Shell Functions:** Maintain shell functions as standalone scripts in their respective autoload directories (`dot_config/fish/private_functions/` and `dot_config/zsh/private_functions/`). Ensure the logic remains identical between both implementations.
