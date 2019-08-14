#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fish)"

info "Setting up fish shell..."

substep_info "Creating fish config folders..."
mkdir -p "$DESTINATION/functions"
mkdir -p "$DESTINATION/completions"

find * -name "*.fish" -o -name "fishfile" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

set_fish_shell() {
    if grep --quiet fish <<< "$SHELL"; then
        success "Fish shell is already set up."
    else
        substep_info "Adding fish executable to /etc/shells"
        if grep --fixed-strings --line-regexp --quiet "/usr/local/bin/fish" /etc/shells; then
            substep_success "Fish executable already exists in /etc/shells."
        else
            if sudo bash -c "echo /usr/local/bin/fish >> /etc/shells"; then
                substep_success "Fish executable added to /etc/shells."
            else
                substep_error "Failed adding Fish executable to /etc/shells."
                return 1
            fi
        fi
        substep_info "Changing shell to fish"
        if sudo chsh -s /usr/local/bin/fish; then
            substep_success "Changed shell to fish"
        else
            substep_error "Failed changing shell to fish"
            return 2
        fi
        substep_info "Running fish initial setup"
        fish -c "setup"

        substep_info "Installing fisher"
        curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
        fisher

        substep_info "Installing oh-my-fish"
        # OMF installer spawns a new fish shell at the end.
        # Run it in noninteractive mode to avoid that.
        curl -L https://get.oh-my.fish > install
        fish install -y --noninteractive
        rm install

        substep_info "Installing oh-my-fish plugins and themes"
        omf install
        omf install brew cd fonts powerline
        omf install artisan blt
        omf install bobthefish
        omf theme bobthefish
        omf reload
    fi
}

if set_fish_shell; then
    success "Successfully set up fish shell."
else
    error "Failed setting up fish shell."
fi
