#!/usr/bin/bash

PATH_TO_BOOTSTRAP_SCRIPT=$(dirname "$(realpath -s "$0")")

# Ensure sudo is installed (bit of a hack in case container runs as root)
if ! dpkg -s sudo; then
  apt-get update && apt-get install sudo
fi

# Install system dependencies
sudo apt-get update && sudo apt-get -yqq install \
  git \
  stow \
  build-essential \
  ripgrep \
  unzip \
  python3-pip \
  python3-venv

# Install dot files
cd "${PATH_TO_BOOTSTRAP_SCRIPT}" && stow . --ignore=.docker && cd - || exit 1

# Run other install scripts
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_fzf.sh
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_lazygit.sh
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_neovim.sh

# Source bash configuration file
echo "source ${PATH_TO_BOOTSTRAP_SCRIPT}/.bashrc" > ~/.bashrc

# Run through first-time Lazy install
~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"

# Install common language tooling
~/bin/nvim --headless \
  -c "MasonToolsInstallSync" \
  -c "quitall"

# Install treesitter parsers
~/bin/nvim --headless \
  -c "TSUpdateSync" \
  -c "quitall"

# Install pytest and pytest-cov (for Neotest)
pip3 install pytest pytest-cov
