#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

VERSION="${NVIM_VERSION:-0.12.2}"
NAME="nvim-linux-x86_64"
TARBALL="${NAME}.tar.gz"
URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/${TARBALL}"

if ! has_cmd npm; then
  echo "npm not found. Run scripts/bootstrap.sh node first." >&2
  exit 1
fi

npm install -g tree-sitter-cli

apt_install wget make build-essential xclip
ensure_dir "${OPT_DIR}" "${BIN_DIR}"

tmp="$(make_temp_dir)"
trap 'rm -rf "$tmp"' EXIT

wget -qO "${tmp}/${TARBALL}" "$URL"
tar -xzf "${tmp}/${TARBALL}" -C "$tmp"
rm -rf "${OPT_DIR}/${NAME}"
mv "${tmp}/${NAME}" "${OPT_DIR}/${NAME}"
ln -sfn "${OPT_DIR}/${NAME}/bin/nvim" "${BIN_DIR}/nvim"
