#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

LUA_LS_VERSION="${LUA_LS_VERSION:-3.18.2}"
LUA_LS_NAME="lua-language-server"
LUA_LS_TARBALL="${LUA_LS_NAME}-${LUA_LS_VERSION}-linux-x64.tar.gz"
LUA_LS_URL="https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LS_VERSION}/${LUA_LS_TARBALL}"

apt_install clangd clang-format pipx wget
ensure_dir "${OPT_DIR}" "${BIN_DIR}"

tmp="$(make_temp_dir)"
trap 'rm -rf "$tmp"' EXIT

wget -qO "${tmp}/${LUA_LS_TARBALL}" "${LUA_LS_URL}"
rm -rf "${OPT_DIR}/${LUA_LS_NAME}"
mkdir -p "${OPT_DIR}/${LUA_LS_NAME}"
tar -xzf "${tmp}/${LUA_LS_TARBALL}" -C "${OPT_DIR}/${LUA_LS_NAME}"
ln -sfn "${OPT_DIR}/${LUA_LS_NAME}/bin/lua-language-server" "${BIN_DIR}/lua-language-server"

if [ -s "${HOME}/.nvm/nvm.sh" ]; then
  # shellcheck disable=SC1091
  \. "${HOME}/.nvm/nvm.sh"
fi

if ! has_cmd npm; then
  echo "npm not found. Run scripts/bootstrap.sh node first." >&2
  exit 1
fi

pipx ensurepath
pipx install --force black
npm install -g pyright @johnnymorganz/stylua-bin

clangd --version
clang-format --version
black --version
pyright --version
lua-language-server --version
stylua --version
