#!/bin/bash

brews=(
    brew-cask
    git
    cscope
    bash-completion
    macvim
    mercurial
    tmux
    ctags
    )
casks=(
    alfred
    google-chrome
    iterm2
    spotify
    mactex
    )

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install ${brews[*]}
brew cask install ${casks[*]}
