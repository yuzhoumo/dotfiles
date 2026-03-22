#!/bin/sh
# Sync dotfiles between repo and install locations
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# navigate to current directory
cd "$(dirname "${0}")" || exit

if [ -f /proc/version ] && grep -q microsoft /proc/version; then # WSL

  # directory for git repos
  CODE_DIR="${HOME}/code"

else # macOS and Linux

  # directory for git repos
  CODE_DIR="${HOME}/Code"

  # kitty config
  mkdir -p "${HOME}/.config/kitty" && \
    cp -r kitty/. "${HOME}/.config/kitty/."

  # ghostty config
  mkdir -p "${HOME}/.config/ghostty" && \
    cp -r ghostty/. "${HOME}/.config/ghostty/."
fi

# desktop linux (wayland)
if [ -n "${WAYLAND_DISPLAY}" ]; then
  # hyprland config. copy default monitors.conf if it does not already exist
  mkdir -p "${HOME}/.config/hypr" && \
    find hyprland -type f ! -name 'monitors.conf' -exec cp {} "${HOME}/.config/hypr/." \; && \
    cp -n hyprland/monitors.conf "${HOME}/.config/hypr/."

  # mako config
  mkdir -p "${HOME}/.config/mako" && \
    cp -r mako/. "${HOME}/.config/mako/."

  # rofi config
  mkdir -p "${HOME}/.config/rofi" && \
    cp -r rofi/. "${HOME}/.config/rofi/."

  # waybar config
  rm -rf "${HOME}/.config/waybar" && \
    mkdir -p "${HOME}/.config/waybar" && \
    cp -r waybar/. "${HOME}/.config/waybar/."
fi

# note: period after trailing slash is significant to ensure consistent
# behavior between both BSD and GNU implementations of "cp" (eg. macOS vs
# Linux respectively); https://ackshaey.medium.com/835c0b608339

# zsh config
mkdir -p "${HOME}/.config/zsh/" && \
  cp -r zsh/. "${HOME}/.config/zsh/." && \
  mv "${HOME}/.config/zsh/.zshenv" "${HOME}/.zshenv"

# editor config
mkdir -p "${CODE_DIR}" && \
  cp editor/.editorconfig "${CODE_DIR}/.editorconfig"

# git config
mkdir -p "${HOME}/.config/git/" && \
  cp -r git/. "${HOME}/.config/git/."

# vim config
mkdir -p "${HOME}/.config/vim/" && \
  cp -r vim/. "${HOME}/.config/vim/."

# neovim config
mkdir -p "${HOME}/.config/nvim/" && \
  cp -r nvim/. "${HOME}/.config/nvim/."

# tmux config
mkdir -p "${HOME}/.config/tmux/" && \
  cp -r tmux/. "${HOME}/.config/tmux/."

# npm config
mkdir -p "${HOME}/.config/npm/" && \
  cp -r npm/. "${HOME}/.config/npm/."

# wget config
mkdir -p "${HOME}/.config/wget/" && \
  cp -r wget/. "${HOME}/.config/wget/."
