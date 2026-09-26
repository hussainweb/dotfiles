function lcommit
    set diff (git diff --cached)
    if test -z "$diff"
        echo "No staged changes found."
        return 1
    end

    # Join any provided args into one context string
    set -l context (string join ' ' -- $argv)

    # Build the system prompt
    set -f system_prompt 'Write a concise, conventional commit-style message describing these changes. Use the proper type: feat, fix, chore, ci, docs, refactor, style, or test.

For example:
- use chore for dependency updates.
- use ci for changes to GitHub Actions or other pipelines.
- and so on.
'

    if test -n "$context"
        set -f system_prompt "$system_prompt
Additional context: $context"
    end

    set -l msg (echo $diff | llm --system "$system_prompt" | string collect)
    printf "%s\n" (string trim -r "$msg")

    set -l copied 0
    if test -z "$SSH_TTY" -a -z "$SSH_CLIENT" -a -z "$SSH_CONNECTION"
        if command -sq pbcopy
            printf "%s" "$msg" | pbcopy
            set copied 1
        else if command -sq wl-copy
            printf "%s" "$msg" | wl-copy
            set copied 1
        else if command -sq xclip
            printf "%s" "$msg" | xclip -selection clipboard
            set copied 1
        else if command -sq xsel
            printf "%s" "$msg" | xsel --clipboard --input
            set copied 1
        end
    end

    if test $copied -eq 0
        set -l b64 (printf "%s" "$msg" | base64 | tr -d '\r\n')
        if test -n "$TMUX"
            printf "\033Ptmux;\033\033]52;c;%s\a\033\\" "$b64" > /dev/tty 2>/dev/null; or printf "\033Ptmux;\033\033]52;c;%s\a\033\\" "$b64"
        else
            printf "\033]52;c;%s\a" "$b64" > /dev/tty 2>/dev/null; or printf "\033]52;c;%s\a" "$b64"
        end
    end
end
