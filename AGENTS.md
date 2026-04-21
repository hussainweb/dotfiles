# Agent Rules

- **Source Control & Configuration:** Never add configuration files or directories (e.g., `.rtk`, `.config`) directly to the repository. Always use `chezmoi add ~/.<path>` to ensure they are tracked according to chezmoi's conventions and properly templated if necessary.
