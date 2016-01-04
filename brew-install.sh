#!/bin/bash

brews=`cat brews`
casks=`cat casks`

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install cask

echo "Installing ${brews}"

brew install ${brews}

echo "Installing casks ${casks}"

brew cask install ${casks}
