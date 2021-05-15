set PATH ~/.composer/vendor/bin ~/tools/flutter/bin ~/.cargo/bin ~/.platformsh/bin $PATH
set -g fish_user_paths "/opt/homebrew/bin" "/opt/homebrew/sbin" $fish_user_paths

set -x GPG_TTY (tty)
set -x fish_emoji_width 2

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
starship init fish | source
