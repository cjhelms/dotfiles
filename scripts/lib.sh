#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${HOME}/bin"
OPT_DIR="${HOME}/opt"

log() {
  printf '\n==> %s\n' "$*"
}

ensure_dir() {
  mkdir -p "$@"
}

apt_update_once() {
  if [ "${APT_UPDATED:-0}" = "1" ]; then
    return
  fi

  if [ -n "${APT_UPDATED_STAMP:-}" ] && [ -f "${APT_UPDATED_STAMP}" ]; then
    export APT_UPDATED=1
    return
  fi

  sudo apt update
  export APT_UPDATED=1

  if [ -n "${APT_UPDATED_STAMP:-}" ]; then
    touch "${APT_UPDATED_STAMP}"
  fi
}

apt_install() {
  apt_update_once
  sudo apt install -yqq "$@"
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

append_line_once() {
  local line="$1"
  local file="$2"

  touch "$file"
  grep -Fqx "$line" "$file" || printf '%s\n' "$line" >> "$file"
}

make_temp_dir() {
  mktemp -d "${TMPDIR:-/tmp}/dotfiles.XXXXXXXXXX"
}
