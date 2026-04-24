#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

apt_install git

if [ -d "${HOME}/.fzf/.git" ]; then
  git -C "${HOME}/.fzf" pull --ff-only
else
  rm -rf "${HOME}/.fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
fi

yes | "${HOME}/.fzf/install"
