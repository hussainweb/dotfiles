#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

# Install Homebrew if not present
if [ ! "$(command -v brew)" ]; then
	echo 'Installing Homebrew...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	
	# Load Homebrew for the current session so the rest of this script can use it
	if [ -d /home/linuxbrew/.linuxbrew ]; then
		# Linux
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	elif [ -d /opt/homebrew ]; then
		# macOS (Apple Silicon)
		eval "$(/opt/homebrew/bin/brew shellenv)"
	else
		# macOS (Intel)
		eval "$(/usr/local/bin/brew shellenv)"
	fi
	
	echo '==================='
	echo 'Homebrew installed and loaded.'
	echo '==================='
fi

if ! chezmoi="$(command -v chezmoi)"; then
	echo "Installing chezmoi..." >&2
	brew install chezmoi
	chezmoi="$(command -v chezmoi)"
fi

# POSIX way to get script's dir
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
exec "$chezmoi" "$@"
