{{- /*
Shell snippet that reads an AWS config or credentials file on stdin and prints
it without the sections chezmoi manages: any section holding a
"# managed by chezmoi" line, and any section named in the argument (a
space-separated list of profile names), so a listed profile takes over a
hand-written one. Trailing blank lines are dropped.

Usage: existing=$({{ template "aws-strip-managed.sh" "work rmg" }})
*/ -}}
awk -v names={{ . | squote }} '
    function flush(    i) {
        if (!drop) for (i = 1; i <= m; i++) out[++n] = sec[i]
        m = 0; drop = 0
    }
    BEGIN { k = split(names, list, " "); for (i = 1; i <= k; i++) managed[list[i]] = 1 }
    /^[[:space:]]*\[/ {
        flush()
        name = $0
        sub(/^[[:space:]]*\[[[:space:]]*/, "", name)
        sub(/[[:space:]]*\][[:space:]]*$/, "", name)
        sub(/^profile[[:space:]]+/, "", name)
        drop = (name in managed)
    }
    /^[[:space:]]*# managed by chezmoi/ { drop = 1 }
    { sec[++m] = $0 }
    END {
        flush()
        while (n > 0 && out[n] ~ /^[[:space:]]*$/) n--
        for (i = 1; i <= n; i++) print out[i]
    }'
