function lcommit
    set diff (git diff --cached)
    if test -z "$diff"
        echo "No staged changes found."
        return 1
    end

    # Join any provided args into one context string
    set -l context (string join ' ' -- $argv)

    # Build the system prompt
    if test -n "$context"
        set -f system_prompt "Write a concise, conventional commit-style message describing these changes. Additional context: $context"
    else
        set -f system_prompt "Write a concise, conventional commit-style message describing these changes."
    end

    set -l commit_message (echo $diff | llm --system "$system_prompt")
    echo $commit_message
    echo $commit_message | pbcopy
end
