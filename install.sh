#!/bin/sh
# One-shot installer for f1recracker's dotfiles (macOS and Arch Linux).
#
# It fetches chezmoi, clones this repo to ~/repos/dotfiles and applies it.
set -eu

msg() { printf '%s\n' "$*"; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }

[ -n "${HOME:-}" ] || die "HOME is not set"

REPO="https://github.com/f1recracker/dotfiles.git"

SOURCE_DIR="$HOME/repos/dotfiles"
mkdir -p "$SOURCE_DIR"

case "$(uname -s)" in
  Darwin)
    # Temporarily fetch chezmoi and use it in this shell only.
    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmpdir"
    PATH="$tmpdir:$PATH"
    # Homebrew's unattended install needs an authenticated sudo session.
    sudo -v
    chezmoi init --source "$SOURCE_DIR" --apply "$REPO"
    ;;
  Linux)
    # Only Arch and derivatives (mirrors packages-pacman).
    if [ -r /etc/os-release ]; then
      # shellcheck disable=SC1091
      . /etc/os-release
    fi
    case "${ID:-unknown} ${ID_LIKE:-}" in
      *arch*|*manjaro*) ;;
      *) die "unsupported distro (ID=${ID:-unknown}); this installer covers macOS and Arch Linux" ;;
    esac
    sudo pacman -S --needed --noconfirm chezmoi
    chezmoi init --source "$SOURCE_DIR" --apply "$REPO"
    ;;
  *)
    die "unsupported OS '$(uname -s)'; this installer covers macOS and Arch Linux"
    ;;
esac

# Validate chezmoi's source-directory is configured to ~/repos/dotfiles
# so future `chezmoi apply` / `chezmoi update` work without explicit source dir flags
actual="$(chezmoi source-path)"
[ "$actual" = "$SOURCE_DIR" ] || die "source-path mismatch: got '$actual', want '$SOURCE_DIR'"

msg "Setup complete."
