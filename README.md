# Dotfiles

These are some of my dotfiles and configuration. The scripts and code are based on [rkalis/dotfiles](https://github.com/rkalis/dotfiles).

## Background and additional information

I started my dotfiles repository with the intention to just document my configuration in form of dotfiles and other checklists of extensions, applications, etc that I use. I wanted to do this from a long time and finally kicked in action after the episode on [dotfiles on syntax.fm podcast](https://syntax.fm/show/057/hasty-treat-dot-files).

While looking around, I found [rkalis/dotfiles](https://github.com/rkalis/dotfiles) which was awesome. I can keep my dotfiles neatly in different directories and even have shell scripts to automate it. That's the power of open source and open community!

Since this repository is based on [rkalis/dotfiles](https://github.com/rkalis/dotfiles), the instructions in that repository apply here. Do check it out.

## Usage

I suggest using this repository as a base to form your own dotfiles collection or just as a reference to see what I use. What works for me probably won't work for you and what works for you probably won't work for me. In other words, everyone's different. I don't see why you would use these dotfiles without any changes at all.

Just follow these instructions to use this repo as is. If you are creating your own repository, don't forget to change the git URL in step 3.

1. Restore your safely backed up ssh keys to `~/.ssh/`
    1. Alternatively, generate new ssh keys, and add these to your GitHub account
1. [Install Homebrew](https://brew.sh/) and git

   ```bash
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   brew install git
   ```

1. Clone this repository (or the one you created)

   ```bash
   git clone git@github.com:hussainweb/dotfiles.git
   ```

1. Run the `bootstrap.sh` script
    1. Alternatively, only run the `setup.sh` scripts in specific subfolders if you don't need everything
1. (Optional) Install missing applications from the internet

## Customisation

I strongly encourage you to play around with the configurations, and add or remove features.
If you would like to use these dotfiles for yourself, I'd recommend changing at least the following:

### Git

* The .gitconfig file includes my [user] config, replace these with your own user name and email

### OSX (todo)

* At the top of the setup.sh file, my computer name is set, replace this with your own computer name

### Packages

This folder is a collection of the programs and utilities I use frequently. These lists can easily be amended to your liking.

### Repos

This folder is a collection of my own repos, some of which are even private. The existing lists can easily be edited or replaced by custom lists.

## Credits

Thanks [@raklis](https://github.com/rkalis), [@wesbos](https://github.com/wesbos), and many others for the inspiration.
