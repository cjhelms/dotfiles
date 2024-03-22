#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
read -p "Install Docker? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  ${SCRIPT_DIR}/install_docker.sh
fi
read -p "Install fzf? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  ${SCRIPT_DIR}/install_fzf.sh
fi
read -p "Install Lazygit? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  ${SCRIPT_DIR}/install_lazygit.sh
fi
read -p "Install Neovim? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  ${SCRIPT_DIR}/install_neovim.sh
fi
read -p "Install Regolith 2? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  ${SCRIPT_DIR}/install_regolith.sh
fi
