function emptytrash
    if test (uname) = Darwin
        # Empty the Trash on all mounted volumes and the main HDD.
        # Also, clear Apple’s System Logs to improve shell startup speed.
        # Finally, clear download history from quarantine. https://mths.be/bum
        sudo rm -rfv /Volumes/*/.Trashes
        sudo rm -rfv ~/.Trash
        sudo rm -rfv /private/var/log/asl/*.asl
        sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
    else
        # Linux / Freedesktop
        if test -d ~/.local/share/Trash
            rm -rfv ~/.local/share/Trash/*
            echo "=> Linux Trash emptied."
        else
            echo "=> No standard Trash directory found."
        end
    end
end
