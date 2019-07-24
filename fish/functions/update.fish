# Get OS X Software Updates, and update installed fisher plugins,
# omf plugins, Composer dependencies, Homebrew, npm,
# and their installed packages
function update --description 'Get OS X Software Updates and update Homebrew, mas, and npm packages'
    sudo softwareupdate -i -a

    brew update
    brew upgrade --force --all
    brew cleanup

    mas upgrade

    fisher up
    omf update

    npm install npm -g
    npm update -g

    composer global update
end
