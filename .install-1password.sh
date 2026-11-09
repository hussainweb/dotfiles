#!/bin/sh

# Install the 1Password CLI and register the accounts this machine needs.
# Usage: .install-1password.sh [account-address ...]
# Runs as chezmoi's read-source-state.pre hook, before templates call
# onepasswordRead. It cannot hand a session back to chezmoi; once an account
# is registered, chezmoi prompts for its password itself.

set -eu

if ! type op >/dev/null 2>&1; then
    case "$(uname -s)" in
    Darwin)
        brew install 1password-cli
        ;;
    Linux)
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/1password-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --yes --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
        sudo apt update && sudo apt install -y 1password-cli
        ;;
    *)
        echo "unsupported OS"
        exit 1
        ;;
    esac
fi

for account in "$@"; do
    if op account list 2>/dev/null | grep -qF "$account"; then
        continue
    fi

    if ! { true </dev/tty; } 2>/dev/null; then
        echo "1Password account $account is not set up and no terminal is available." >&2
        echo "Run: op account add --address $account" >&2
        exit 1
    fi

    echo "Adding 1Password account $account (email, Secret Key and password)..." >&2
    op account add --address "$account" </dev/tty >/dev/tty 2>&1
done
