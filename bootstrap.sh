#!/usr/bin/bash

PATH_TO_BOOTSTRAP_SCRIPT=$(dirname "$(realpath -s "$0")")

# Install system dependencies
apt-get update && apt-get -y -q install \
  git \
  stow \
  build-essential \
  ripgrep \
  unzip

# Install dot files
cd "${PATH_TO_BOOTSTRAP_SCRIPT}" && stow . --ignore=.docker && cd - || exit 1

# Run other install scripts
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_fzf.sh
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_lazygit.sh
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_neovim.sh

# Source bash configuration file
echo "source ${PATH_TO_BOOTSTRAP_SCRIPT}/.bashrc" >> ~/.bashrc

# Install Neovim plugins
~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"
