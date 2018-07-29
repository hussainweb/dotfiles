function blt --description "BLT function for the fish shell"
    if test -n (git rev-parse --show-cdup)
        set --global GIT_ROOT (git rev-parse --show-cdup)
    else
        set --global GIT_ROOT "."
    end

    if test -f $GIT_ROOT/vendor/bin/blt
        eval $GIT_ROOT/vendor/bin/blt $argv
    else
        echo "You must run this command from within a BLT-generated project repository."
    end
end

