# f1recracker's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

To add a package, add an entry to `.chezmoidata/packages.yaml`:

```yaml
packages:
  starship:
    pacman: starship
    brew: starship
  ...
```

Omit `brew` / `pacman` to skip that manager. For a mac-only cask:

```yaml
packages:
  iterm2:
    brew: { cask: iterm2 }
  ...
```

## Usage

### Current status
```zsh
chezmoi diff
chezmoi status
```

### Apply configurations

```zsh
sudo -v && chezmoi apply -v
```

### Post apply

#### Update `.zshrc`

```zsh
echo '[ -f ~/.zshrc.local ] && source ~/.zshrc.local' >> ~/.zshrc
```

#### Setup fonts

Install a nerd font manually in terminal emulator for starship.
