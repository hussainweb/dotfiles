#!/usr/bin/env fish

if ! command -v asdf &> /dev/null
  echo "asdf not installed. Skipping installing plugins..."
  exit
end

asdf completion fish > ~/.config/fish/completions/asdf.fish

asdf plugin add php || true
asdf plugin add python || true
asdf plugin add golang || true
asdf plugin add rust || true

asdf install python latest
asdf set -u python latest
