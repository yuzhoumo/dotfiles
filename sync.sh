#!/bin/sh
# Sync dotfiles between repo and install locations
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

macos_code_dir="${HOME}/Code"

# Navigate to current directory
cd "$(dirname "${0}")" || exit

if [[ $(uname -s) = 'Darwin' ]]; then
  mkdir -p "${macos_code_dir}" && \
    cp editor/.editorconfig "${macos_code_dir}/.editorconfig"

  mkdir -p "${HOME}/.config/kitty" && \
    cp -r kitty/ "${HOME}/.config/kitty/"

  mkdir -p "${HOME}/.config/nvim/" && \
    cp -r nvim/ "${HOME}/.config/nvim/"

  mkdir -p "${HOME}/.config/zsh/" && \
    cp -r zsh/ "${HOME}/.config/zsh/" && \
    mv "${HOME}/.config/zsh/.zshenv" "${HOME}/.zshenv"
fi
