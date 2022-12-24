#!/bin/sh
# Sync dotfiles between repo and install locations
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# navigate to current directory
cd "$(dirname "${0}")" || exit

if [ -d /proc/version ] && grep -q microsoft /proc/version; then # WSL

  # directory for git repos
  CODE_DIR="${HOME}/code"

else # macOS and Linux

  # directory for git repos
  CODE_DIR="${HOME}/Code"

  # kitty config
  mkdir -p "${HOME}/.config/kitty" && \
    cp -r kitty/. "${HOME}/.config/kitty/."

fi

# note: period after trailing slash is significant to ensure consistent
# behavior between both BSD and GNU implementations of "cp" (eg. macOS vs
# Linux respectively); https://ackshaey.medium.com/835c0b608339

# zsh config
mkdir -p "${HOME}/.config/zsh/" && \
  cp -r zsh/. "${HOME}/.config/zsh/." && \
  mv "${HOME}/.config/zsh/.zshenv" "${HOME}/.zshenv"

# btop config
mkdir -p "${HOME}/.config/btop/" && \
  cp -r btop/. "${HOME}/.config/btop/."

# editor config
mkdir -p "${CODE_DIR}" && \
  cp editor/.editorconfig "${CODE_DIR}/.editorconfig"

# git config
mkdir -p "${HOME}/.config/git/" && \
  cp -r git/. "${HOME}/.config/git/." && \
  mv "${HOME}/.config/git/.gitconfig" "${HOME}/.gitconfig"

# neovim config
mkdir -p "${HOME}/.config/nvim/" && \
  cp -r nvim/. "${HOME}/.config/nvim/."

# tmux config
mkdir -p "${HOME}/.config/tmux/" && \
  cp -r tmux/. "${HOME}/.config/tmux/."

# stylua config (lua formatter)
mkdir -p "${HOME}/.config/stylua/" && \
  cp -r stylua/. "${HOME}/.config/stylua/."
