#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

apt_install git openssh-client

prompt_required() {
  local prompt="$1"
  local value

  while true; do
    read -r -p "${prompt}: " value

    if [ -n "${value}" ]; then
      printf '%s\n' "${value}"
      return
    fi
  done
}

git_email="${GIT_EMAIL:-}"
git_name="${GIT_NAME:-}"

if [ -z "${git_email}" ]; then
  git_email="$(prompt_required "Git email")"
fi

if [ -z "${git_name}" ]; then
  git_name="$(prompt_required "Git name")"
fi

git config --global user.email "${git_email}"
git config --global user.name "${git_name}"

ensure_dir "${HOME}/.ssh"
if [ ! -f "${HOME}/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -C "${git_email}" -N "" -f "${HOME}/.ssh/id_ed25519"
else
  log "SSH key already exists at ${HOME}/.ssh/id_ed25519"
fi
