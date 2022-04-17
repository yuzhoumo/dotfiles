#!/bin/sh
# Sync dotfiles between repo and install locations
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

macos_code_dir="${HOME}/Code"
wsl_code_dir="${HOME}/code"

# Navigate to current directory
cd "$(dirname "${0}")" || exit

# macOS installation
if [ "$(uname -s)" = 'Darwin' ]; then
  mkdir -p "${macos_code_dir}" && \
    cp editor/.editorconfig "${macos_code_dir}/.editorconfig"

  mkdir -p "${HOME}/.config/kitty" && \
    cp -r kitty/ "${HOME}/.config/"
fi

# WSL installation
if grep -q microsoft /proc/version; then
  mkdir -p "${wsl_code_dir}" && \
    cp editor/.editorconfig "${wsl_code_dir}/.editorconfig" 
fi

# All installations
mkdir -p "${HOME}/.config/nvim/" && \
  cp -r nvim/ "${HOME}/.config/"

mkdir -p "${HOME}/.config/zsh/" && \
  cp -r zsh/ "${HOME}/.config/" && \
  mv "${HOME}/.config/zsh/.zshenv" "${HOME}/.zshenv"

