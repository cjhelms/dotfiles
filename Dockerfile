ARG BASE_IMAGE=ubuntu
ARG BASE_TAG=latest
FROM $BASE_IMAGE:$BASE_TAG

WORKDIR /root

# Install system dependencies through apt-get
RUN apt-get update && apt-get -yqq install \
  curl \
  unzip \
  wget \
  git \
  fzf \
  stow \
  xclip \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv \
  npm

# Install nodejs for Pyright
RUN \
  curl -sL https://deb.nodesource.com/setup_18.x && \
  apt-get install nodejs -yqq

# Download and install Neovim
RUN \
  wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
  tar -xvf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz && \
  mv nvim-linux64 /opt && \
  ln -s /opt/nvim-linux64/bin/nvim /bin/nvim

# Neovim executable was linked to /root/bin
ENV PATH="$PATH:/root/bin"

# Download and install configuration files
# Pass an argument value for DOTFILES_VER to force a refresh of this layer
ARG DOTFILES_VER=unknown
RUN \
  git clone https://github.com/cjhelms/dotfiles.git .dotfiles && \
  cd .dotfiles && \
  stow .

CMD ["/bin/bash"]
