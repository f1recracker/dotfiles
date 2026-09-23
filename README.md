# f1recracker's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

Supports the following platforms:
- MacOS (via `brew`)
- Arch Linux (via `pacman` + `paru` for AUR)

## New setup

### MacOS

```sh
tmpdir=$(mktemp -d)
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmpdir"
export PATH="$tmpdir:$PATH" # use downloaded chezmoi in this shell only
```

If homebrew is missing, pre-authenticate sudo to complete setup (see https://docs.brew.sh/Installation#unattended-installation)

```sh
sudo -v
chezmoi init --apply https://github.com/f1recracker/dotfiles.git
rm -rf "$tmpdir"
```

### Arch Linux

```sh
sudo pacman -S chezmoi
chezmoi init --apply https://github.com/f1recracker/dotfiles.git
```

### Post setup

Some additional manual steps are needed to finish installation:

1. Managed zshrc changes are added to a new `.zshrc.local` instead of overwriting the system `.zshrc` and must therefore be included manually.
  ```sh
  grep -q 'zshrc.local' ~/.zshrc || echo '[ -f ~/.zshrc.local ] && source ~/.zshrc.local' >> ~/.zshrc
  ```

2. Setup installed [Nerd fonts](https://www.nerdfonts.com/font-downloads) in terminal for starship.

## Configurations

- Packages can be configured at [.chezmoidata/packages.yaml](.chezmoidata/packages.yaml).
- Git user configs are prompted during `chezmoi init`. Leaving it empty skips setting git identity.
- A `commit-msg` git hook is added to enforce [Conventional Commits](https://www.conventionalcommits.org/).

## Existing setup

```sh
chezmoi apply -v
```

```sh
# alternatively if you need sudo
sudo -v && chezmoi apply -v
```

## Management

### Packages

To add a package, add an entry to [.chezmoidata/packages.yaml](.chezmoidata/packages.yaml). Omitting a package manager `pacman` / `aur` / `brew` skips installation (for `brew`, use `{ cask: <name> }` for casks).

```yaml
packages:
  starship:
    pacman: starship
    brew: starship
  iterm2:
    brew: { cask: iterm2 }
  ...
```
