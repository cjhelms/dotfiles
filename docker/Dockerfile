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
RUN bash ~/.dotfiles/scripts/install_lazygit.sh
RUN bash ~/.dotfiles/scripts/install_neovim.sh

# Source .bashrc
RUN echo "source ~/.dotfiles/.bashrc" > ~/.bashrc

# Run through first-time Lazy install
RUN ~/bin/nvim --headless \
  -c "autocmd User LazySync quitall" \
  -c "Lazy sync"

# Install common language tooling
RUN ~/bin/nvim --headless \
  -c "MasonToolsInstallSync" \
  -c "quitall"

# Install treesitter parsers
RUN ~/bin/nvim --headless \
  -c "TSUpdateSync" \
  -c "quitall"

CMD ["/bin/bash"]
