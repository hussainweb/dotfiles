function pubkey
    set -l file ~/.ssh/id_rsa.pub
    if not test -f $file
        set file ~/.ssh/id_ed25519.pub
    end

    if test -f $file
        if command -sq pbcopy
            cat $file | pbcopy
        else if command -sq xclip
            cat $file | xclip -selection clipboard
        else if command -sq xsel
            cat $file | xsel --clipboard --input
        else if command -sq wl-copy
            cat $file | wl-copy
        end
        echo "=> Public key ($file) copied to clipboard."
    else
        echo "Error: No public key found at ~/.ssh/id_rsa.pub or ~/.ssh/id_ed25519.pub"
        return 1
    end
end
