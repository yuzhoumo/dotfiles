# Joe's dotfiles

This is a single repository with my personal dotfiles intended to work across
macOS, WSL, and most GNU/Linux distros.

## Install with Git

```
git clone https://github.com/yuzhoumo/dotfiles "${HOME}/dotfiles" && \
  "${HOME}/dotfiles/sync.sh" && rm -rf "${HOME}/dotfiles"
```

## Install without Git

```
mkdir "${HOME}/dotfiles" && \
  curl -#L https://github.com/yuzhoumo/dotfiles/tarball/main --silent | \
  tar -xzv --strip-components 1 -C "${HOME}/dotfiles" && \
  "${HOME}/dotfiles/sync.sh" && rm -rf "${HOME}/dotfiles"
```

## Full OS configurations

This repository is a dependency for my full OS setup automations listed below:

- [macOS configs](https://github.com/yuzhoumo/macos-configs)
- [openSUSE configs](https://github.com/yuzhoumo/opensuse-configs)
