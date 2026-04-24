#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

APT_STATE_DIR="$(make_temp_dir)"
export APT_UPDATED_STAMP="${APT_STATE_DIR}/apt-updated"
trap 'rm -rf "${APT_STATE_DIR}"' EXIT

usage() {
  cat <<USAGE
usage: $0 [target ...]

targets:
  all                install core and desktop tools
  core               install git, tmux, fzf, node, neovim, and lazygit
  desktop            install GNOME extension tools
  git                install git and configure identity/key
  tmux               install tmux
  fzf                install fzf
  node               install nvm and Node.js
  neovim             install Neovim
  lazygit            install lazygit
  gnome_extensions   install GNOME extension tools
USAGE
}

run_installer() {
  local name="$1"

  log "Installing ${name}"
  bash "${SCRIPT_DIR}/install_${name}.sh"
}

run_target() {
  case "$1" in
    all)
      run_target core
      run_target desktop
      ;;
    core)
      run_installer git
      run_installer tmux
      run_installer fzf
      run_installer node
      run_installer neovim
      run_installer lazygit
      ;;
    desktop)
      run_installer gnome_extensions
      ;;
    git|tmux|fzf|node|neovim|lazygit|gnome_extensions)
      run_installer "$1"
      ;;
    -h|--help|help)
      usage
      ;;
    *)
      echo "Unknown target: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
}

if [ "$#" -eq 0 ]; then
  run_target all
else
  for target in "$@"; do
    run_target "$target"
  done
fi
