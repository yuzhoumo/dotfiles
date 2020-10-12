#!/usr/bin/env bash

# Full installation of dotfiles and other configurations

cd "$(dirname "$0")"

# Configure macOS settings
sh assets/macos.sh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install command-line and GUI applications
sh assets/brew.sh

# Install python pip3 modules
sh assets/python.sh

# Install BetterDiscord
sh assets/betterdiscord.sh

# Configure macOS dock
sh dock.sh
