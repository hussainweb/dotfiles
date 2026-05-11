# My Dotfiles

My dotfiles and setup script managed with [chezmoi](https://chezmoi.io/).

## Prerequisites

Before running the installation script, you must manually install and configure **1Password**. 

There is a script that installs the 1Password CLI automatically, but the main application needs to be installed and available first to provide access to secrets during the chezmoi apply process.

## Installation

You can install these dotfiles by running the included `install.sh` script.

The installation script will automatically:
1. Install Homebrew (if on macOS and not already installed).
2. Install `chezmoi` via Homebrew.
3. Initialize and apply the dotfiles repository.

Run the following command:

```bash
./install.sh
```

Alternatively, if you are setting up a new machine and want to run it directly via curl using chezmoi's one-liner (assuming you push this to a repository):

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply hussainweb
```
*(Replace `hussainweb` with your GitHub username if applicable)*

## Package Management

This repository uses a structured approach to manage packages via `.chezmoidata/packages.yaml`. Packages are categorized to provide flexibility:

* **Homebrew Brews**: Categorized into `minimal` (essential tools), `development` (languages and dev workflows), `standard` (modern CLI suite), and `macos` (OS-specific tools).
* **Homebrew Casks**: Organized into `cli` (as casks), `fonts`, and various GUI categories (`minimal`, `standard`, `development`, `personal`, `large_apps`).
* **Machine-Specific**: Supports targeted cask installations for specific machines (e.g., `the-good-machine`).
* **Cross-Platform Support**: Includes `npm` and `apt` package lists for fallback or Linux environments.

## Configured Tools

These dotfiles include custom configurations and scripts for the following tools:

* **[Fish Shell](https://fishshell.com/)**: Primary shell with custom functions, abbreviations, and fisher plugins.
* **[Starship](https://starship.rs/)**: Cross-shell customizable prompt.
* **[Ghostty](https://ghostty.org/)**: Terminal emulator.
* **[Atuin](https://atuin.sh/)**: Magical shell history synchronization.
* **Git**: Custom gitconfig and abbreviations.
* **GnuPG**: GPG agent configuration.
* **Linode CLI**: Configuration template.
* **Python**: `.pypirc` for package publishing.

## GPG Key Setup

The git configuration expects a GPG secret key with ID `E1CE98447E2C7887` to be present for commit signing. This key is not automatically managed by chezmoi and must be imported manually.

### Importing an existing key

If you already have this key on another machine, you can export it and import it here:

1. **On the machine with the key:**
   ```bash
   gpg --export-secret-keys E1CE98447E2C7887 > private.key
   ```
2. **Transfer `private.key` to the new machine.**
3. **On the new machine:**
   ```bash
   gpg --import private.key
   # You may also need to trust the key
   gpg --edit-key E1CE98447E2C7887 trust
   ```

Once imported, you can verify it with:
```bash
gpg --list-secret-keys E1CE98447E2C7887
```

## Repository Structure

* `install.sh`: Bootstrap script to install Homebrew, chezmoi, and apply the dotfiles.
* `.chezmoidata/packages.yaml`: Defines categorized Homebrew taps, brews, casks, npm, and apt packages.
* `dot_config/`: Configurations for applications typically found in `~/.config/` (Fish, Starship, Ghostty, Atuin, etc.).
* `run_once_*` / `run_onchange_*`: chezmoi scripts executed during the apply phase to install packages and configure the system.
