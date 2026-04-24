#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

VERSION="${LAZYGIT_VERSION:-0.61.1}"
TARBALL="lazygit_${VERSION}_Linux_x86_64.tar.gz"
URL="https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/${TARBALL}"

apt_install wget
ensure_dir "${BIN_DIR}"

tmp="$(make_temp_dir)"
trap 'rm -rf "$tmp"' EXIT

wget -qO "${tmp}/${TARBALL}" "$URL"
tar -xzf "${tmp}/${TARBALL}" -C "$tmp" lazygit
install -m 0755 "${tmp}/lazygit" "${BIN_DIR}/lazygit"
