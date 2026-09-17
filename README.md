# f1recracker's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

Supports macOS (`brew`) and Arch Linux (`pacman` + `paru` for AUR).

## Setup

### Fresh install

#### macOS

```sh
tmpdir=$(mktemp -d)
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmpdir"
"$tmpdir/chezmoi" init --apply git@github.com:f1recracker/dotfiles.git
rm -rf "$tmpdir"
```

#### Arch Linux

```sh
sudo pacman -S chezmoi
chezmoi init --apply git@github.com:f1recracker/dotfiles.git
```

#### Post setup

1. Setup `.zshrc`:
  ```sh
  grep -q 'zshrc.local' ~/.zshrc || echo '[ -f ~/.zshrc.local ] && source ~/.zshrc.local' >> ~/.zshrc
  ```

2. Setup installed [Nerd fonts](https://www.nerdfonts.com/font-downloads) in terminal for starship.

### Existing installation

```sh
chezmoi apply -v
```

```sh
# alternatively if you need sudo
sudo -v && chezmoi apply -v
```

## Configuration

### Packages

To add a package, add an entry to `.chezmoidata/packages.yaml`:

```yaml
packages:
  starship:
    pacman: starship
    brew: starship
  ...
```

Omit `brew` / `pacman` / `aur` to skip that manager. For a mac-only cask:

```yaml
packages:
  iterm2:
    brew: { cask: iterm2 }
  ...
```
