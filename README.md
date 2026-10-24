# f1recracker's dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

Supports the following platforms:
- MacOS (via `brew`)
- Arch Linux (via `pacman` + `paru` for AUR)

## New setup

One command on macOS or Arch Linux:

```sh
sh -c "$(curl -fsLS https://raw.githubusercontent.com/f1recracker/dotfiles/master/install.sh)"
```

It installs chezmoi if missing (may ask for sudo), clones this repo to `~/repos/dotfiles`, applies it, and pins that dir as chezmoi's source so later `chezmoi apply` / `chezmoi update` runs keep working.

If Homebrew is missing on macOS, pre-authenticate sudo first (see https://docs.brew.sh/Installation#unattended-installation):

```sh
sudo -v
```

### Post setup

Some additional manual steps are needed to finish installation:

1. Managed zshrc changes are added to a new `.zshrc.local` instead of overwriting the system `.zshrc` and must therefore be included manually.
  ```sh
  grep -q 'zshrc.local' ~/.zshrc || echo '[ -f ~/.zshrc.local ] && source ~/.zshrc.local' >> ~/.zshrc
  ```

2. Setup installed [Nerd fonts](https://www.nerdfonts.com/font-downloads) in terminal for starship. **This is configured automatically for Ghostty (MartianMono Nerd Font; see below).**

## Configurations

- Packages can be configured at [.chezmoidata/packages.yaml](.chezmoidata/packages.yaml).
- Git user configs are prompted during `chezmoi init`. Leaving it empty skips setting git identity.
- On Linux with the NVIDIA driver installed, `chezmoi init` detects the GPU and allows setting up additional GPU management services:
  - `nvidia-gpu-exporter.service` exports Prometheus metrics for Nvidia GPUs.
  - `nvidia-geforce-rtx-5090-power-limit.service` sets a 450W power limit on the RTX 5090.
- A `commit-msg` git hook is added to enforce [Conventional Commits](https://www.conventionalcommits.org/).
- Ghostty ([config](dot_config/ghostty/config)) has been explicitly configured with:
  - Quick/dropdown terminal (triggered globally by `` ` ``, top of screen, autohide).
  - Natural text editing.
  - MartianMono Nerd Font with ligatures enabled.
  - Molokai color scheme.
  - Shortcut: `Cmd+T` opens a new tab.
- [MacOS] An empty `~/.hushlogin` is added to silence the login message.

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

Most packages are managed in [.chezmoidata/packages.yaml](.chezmoidata/packages.yaml) with a few exceptions (see [exceptions below](#exceptions)). Omitting a package manager `pacman` / `aur` / `brew` skips installation (for `brew`, use `{ cask: <name> }` for casks). A package can be gated on chezmoi data with an optional `if: <dotted data path>` (e.g. `if: gpu.nvidia_management_services`); when the path is missing or falsy the package is skipped by all managers.

#### Exceptions

- **Rustup**: Rustup is installed via the official `sh.rustup.rs` script (See `run_before_13-rustup.sh`).

```yaml
packages:
  starship:
    pacman: starship
    brew: starship
  ghostty:
    pacman: ghostty
    brew: { cask: ghostty }
  ...
```
