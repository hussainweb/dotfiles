function lcommit
    set diff (git diff --cached)
    if test -z "$diff"
        echo "No staged changes found."
        return 1
    end

    # Join any provided args into one context string
    set -l context (string join ' ' -- $argv)

    # Build the system prompt
    set -f system_prompt "Write a concise, conventional commit-style message describing these changes. Use the proper type: feat, fix, chore, ci, docs, refactor, style, or test. For example, if this is only dependency updates, use chore."
    if test -n "$context"
        set -f system_prompt "$system_prompt Additional context: $context"
    end

    echo $diff | llm --system "$system_prompt" | tee /dev/tty | pbcopy
end
