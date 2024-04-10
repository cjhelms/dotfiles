#!/usr/bin/bash

PATH_TO_BOOTSTRAP_SCRIPT=$(realpath -s "$0")

# Install system dependencies
sudo apt-get update && apt-get -yqq install \
  git \
  stow \
  build-essential \
  ripgrep \
  unzip \
  python3-pip \
  clang-format \
  python3-venv

# Install dot files
cd ${PATH_TO_BOOTSTRAP_SCRIPT}
stow .
cd ..

# Run other install scripts
bash ${PATH_TO_BOOTSTRAP_SCRIPT}/scripts/install_fzf.sh
bash ${PATH_TO_BOOTSTRAP_SCRIPT}/scripts/install_node.sh
bash ${PATH_TO_BOOTSTRAP_SCRIPT}/scripts/install_lazygit.sh
bash ${PATH_TO_BOOTSTRAP_SCRIPT}/scripts/install_neovim.sh

# Source bash configuration file
echo "source ~/.dotfiles/.bashrc" > ~/.bashrc

# Install Neovim plugins
~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"

# Install treesitter parsers
~/bin/nvim --headless \
  -c "TSInstallSync vimdoc" \
  -c "TSInstallSync lua" \
  -c "TSInstallSync python" \
  -c "TSInstallSync cpp" \
  -c "quitall"

# Install LSP servers
~/bin/nvim --headless \
  -c "MasonInstall lua-language-server" \
  -c "MasonInstall pyright" \
  -c "MasonInstall clangd" \
  -c "quitall"

# Install formatters
~/bin/nvim --headless \
  -c "MasonInstall stylua" \
  -c "MasonInstall black" \
  -c "MasonInstall isort" \
  -c "MasonInstall clang-format" \
  -c "quitall"

# Install linters
~/bin/nvim --headless \
  -c "MasonInstall flake8" \
  -c "quitall"
