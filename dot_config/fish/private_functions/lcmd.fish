function lcmd
    set sysinfo (uname -a)
    set q (string join ' ' -- $argv)
    llm --system "Return only the shell command with no explanations. System info: $sysinfo" "$q"
end
