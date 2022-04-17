# Joe's dotfiles

This is a single repository with my personal dotfiles/configs that should work
across macOS and Linux/WSL.

## One-line installation

```
mkdir "${HOME}/dotfiles" && cd "${HOME}/dotfiles" && curl -#L https://github.com/yuzhoumo/dotfiles/tarball/main --silent | tar -xzv --strip-components 1 --exclude={README.md,LICENSE} && ./sync.sh
```
