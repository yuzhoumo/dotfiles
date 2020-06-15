#!/usr/bin/env bash

# Full installation of dotfiles and other configurations

# Navigate to current directory
cd "$(dirname "$0")"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Disable Homebrew analytics
brew analytics off

# Install command-line and GUI applications
sh brew.sh

# Install python pip3 modules
sh init/python.sh

# Configure Browsers
sh init/firefox/firefox.sh
sh init/brave/brave.sh

# Install BetterDiscord
sh init/betterdiscord/betterdiscord.sh

# Configure macOS dock
./.dock

# Configure macOS settings
./.macOS

# Install dotfiles
sh bootstrap.sh
