ARG IMAGE_ID

FROM ${IMAGE_ID}:latest

USER root

# Install minimal system dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yqq install \
  sudo \
  git \
  stow \
  build-essential \
  ripgrep \
  unzip \
  python3-pip \
  clang-format \
  python3-venv

# Install dotfiles
RUN git clone https://github.com/cjhelms/dotfiles.git ~/.dotfiles
RUN cd ~/.dotfiles && stow . && cd -

# Run install scripts
RUN bash ~/.dotfiles/scripts/install_fzf.sh
RUN bash ~/.dotfiles/scripts/install_node.sh
RUN bash ~/.dotfiles/scripts/install_lazygit.sh
RUN bash ~/.dotfiles/scripts/install_neovim.sh

# Source .bashrc
RUN echo "source ~/.dotfiles/.bashrc" > ~/.bashrc

# Run through first-time Lazy install
RUN ~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"

# Install treesitter parsers
RUN ~/bin/nvim --headless \
  -c "TSInstallSync vimdoc" \
  -c "TSInstallSync lua" \
  -c "TSInstallSync python" \
  -c "TSInstallSync cpp" \
  -c "quitall"

# Install LSP servers
RUN ~/bin/nvim --headless \
  -c "MasonInstall lua-language-server" \
  -c "MasonInstall pyright" \
  -c "MasonInstall clangd" \
  -c "quitall"

# Install formatters
RUN ~/bin/nvim --headless \
  -c "MasonInstall stylua" \
  -c "MasonInstall black" \
  -c "MasonInstall isort" \
  -c "MasonInstall clang-format" \
  -c "quitall"

# Install linters
RUN ~/bin/nvim --headless \
  -c "MasonInstall flake8" \
  -c "quitall"

CMD ["/bin/bash"]
