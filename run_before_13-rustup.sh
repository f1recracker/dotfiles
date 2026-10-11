#!/bin/bash
set -euo pipefail

if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --no-modify-path --profile default
else
  echo "Found existing rustup at $(command -v rustup); skipping install."
fi

export PATH="$HOME/.cargo/bin:$PATH"

rustup toolchain install stable --profile default \
  --component rust-analyzer,clippy,rustfmt
rustup default stable
