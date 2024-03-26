FROM ubuntu:latest

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

# Install LSP servers
RUN ~/bin/nvim --headless \
  -c "MasonInstall lua_ls" \
  -c "MasonInstall stylua" \
  -c "MasonInstall pyright" \
  -c "MasonInstall flake8" \
  -c "MasonInstall isort" \
  -c "MasonInstall black" \
  -c "MasonInstall clangd" \
  -c "quitall"

CMD ["/bin/bash"]
