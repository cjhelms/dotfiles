#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

apt_install git openssh-client

git config --global user.email "cjhelms1428@gmail.com"
git config --global user.name "Chris Helms"

ensure_dir "${HOME}/.ssh"
if [ ! -f "${HOME}/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -C "cjhelms1428@gmail.com" -N "" -f "${HOME}/.ssh/id_ed25519"
else
  log "SSH key already exists at ${HOME}/.ssh/id_ed25519"
fi
