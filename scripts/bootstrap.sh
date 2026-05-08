#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"
DOTFILES_REPO_URL="${DOTFILES_REPO_URL:-https://github.com/cjhelms/dotfiles.git}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "${SCRIPT_DIR}/lib.sh" ]; then
  if ! command -v git >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -yqq git
  fi

  if [ ! -e "${DOTFILES_DIR}" ]; then
    git clone "${DOTFILES_REPO_URL}" "${DOTFILES_DIR}"
  elif [ ! -d "${DOTFILES_DIR}/.git" ]; then
    echo "${DOTFILES_DIR} exists but is not a git checkout" >&2
    exit 1
  fi

  exec bash "${DOTFILES_DIR}/scripts/bootstrap.sh" "$@"
fi

source "${SCRIPT_DIR}/lib.sh"

APT_STATE_DIR="$(make_temp_dir)"
export APT_UPDATED_STAMP="${APT_STATE_DIR}/apt-updated"
trap 'rm -rf "${APT_STATE_DIR}"' EXIT

usage() {
  cat <<USAGE
usage: $0 [target ...]

targets:
  all                install core and desktop tools
  core               install dotfiles, git, tmux, fzf, ripgrep, node, neovim, lazygit, and LSP tools
  desktop            install GNOME extension tools
  dotfiles           symlink dotfiles into the home directory with stow
  git                install git and configure identity/key
  tmux               install tmux
  fzf                install fzf
  ripgrep            install ripgrep
  node               install nvm and Node.js
  neovim             install Neovim
  lsp                install common Neovim LSP servers and formatters
  lazygit            install lazygit
  terminal_theme     configure GNOME Terminal habamax colors
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
      run_installer dotfiles
      run_installer git
      run_installer tmux
      run_installer fzf
      run_installer ripgrep
      run_installer node
      run_installer neovim
      run_installer lsp
      run_installer lazygit
      ;;
    desktop)
      run_installer terminal_theme
      run_installer gnome_extensions
      ;;
    dotfiles|git|tmux|fzf|ripgrep|node|neovim|lsp|lazygit|terminal_theme|gnome_extensions)
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
