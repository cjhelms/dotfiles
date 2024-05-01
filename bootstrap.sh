#!/usr/bin/bash

PATH_TO_BOOTSTRAP_SCRIPT=$(dirname "$(realpath -s "$0")")

# Ensure sudo is installed (bit of a hack in case container runs as root)
if ! dpkg -s sudo; then
  apt-get update && apt-get -y -q install sudo
fi

# Install system dependencies
sudo apt-get update && sudo apt-get -y -q install \
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
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_node.sh
bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_neovim.sh

# Check if need to update Python
PYTHON_VERSION=$(python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
COMPARISON_RESULT=$(printf '%s\n' "3.10" "$PYTHON_VERSION" | sort -V | head -n 1)
if [ "$COMPARISON_RESULT" != "3.10" ]; then
  echo "Python version is less than 3.10, found ${COMPARISON_RESULT}"
  echo "Installing 3.10..."
  bash "${PATH_TO_BOOTSTRAP_SCRIPT}"/scripts/install_python310.sh

  # Extra install for Neovim
  /usr/bin/python3.10 -m pip install pynvim
else
  # Extra install for Neovim
  python3 -m pip install pynvim
fi

# Source bash configuration file
echo "source ${PATH_TO_BOOTSTRAP_SCRIPT}/.bashrc" > ~/.bashrc

# Install Neovim and Lazy plugins
~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"

# Install common language tooling
~/bin/nvim --headless \
  -c "TSInstallSync markdown" \
  -c "TSInstallSync diff" \
  -c "MasonToolsInstallSync" \
  -c "quitall"

# Install pytest and pytest-cov (for Neotest)
python3 -m pip install pytest pytest-cov
