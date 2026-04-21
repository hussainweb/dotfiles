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
* **DigitalOcean CLI (`doctl`)**: Application support configuration.
* **Linode CLI**: Configuration template.
* **Python**: `.pypirc` for package publishing.

## Repository Structure

* `install.sh`: Bootstrap script to install Homebrew, chezmoi, and apply the dotfiles.
* `.chezmoidata/packages.yaml`: Defines categorized Homebrew taps, brews, casks, npm, and apt packages.
* `dot_config/`: Configurations for applications typically found in `~/.config/` (Fish, Starship, Ghostty, Atuin, etc.).
* `run_once_*` / `run_onchange_*`: chezmoi scripts executed during the apply phase to install packages and configure the system.
