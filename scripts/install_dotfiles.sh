#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

apt_install stow

stow --dir="${DOTFILES_DIR}" --target="${HOME}" .

append_line_once 'source $HOME/.dotfiles/.bashrc' "${HOME}/.bashrc"
