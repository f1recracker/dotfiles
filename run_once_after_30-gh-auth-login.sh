#!/bin/bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "gh not installed; skipping gh auth login."
  exit 0
fi

if gh auth status >/dev/null 2>&1; then
  echo "gh already authenticated; skipping login."
else
  echo "Running 'gh auth login'..."
  gh auth login -h github.com -p ssh --skip-ssh-key
fi
