ARG BASE_IMAGE=ubuntu
ARG BASE_TAG=latest
FROM $BASE_IMAGE:$BASE_TAG

WORKDIR /root

# Base setup (basic system dependencies via apt)
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yqq install \
  curl \
  unzip \
  wget \
  git \
  stow \
  xclip \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Install NodeJS (required for pyright)
RUN apt-get update && \
  apt-get install -y ca-certificates curl gnupg && \
  mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
    gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | \
    tee /etc/apt/sources.list.d/nodesource.list && \
  apt-get update && apt-get -yqq install nodejs

# Install Lazygit
RUN mkdir lazygit && cd lazygit && \
  wget "https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_32-bit.tar.gz" && \
  tar -xvf lazygit_0.40.2_Linux_32-bit.tar.gz && \
  mv lazygit /bin && \
  cd .. && rm -rf lazygit

# Install Neovim
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
  tar -xvf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz && \
  mv nvim-linux64 /opt && \
  ln -s /opt/nvim-linux64/bin/nvim /bin/nvim

# Clone down my dotfiles repository
RUN git clone --depth 1 https://github.com/cjhelms/dotfiles.git .dotfiles && \
  cd .dotfiles && \
  stow . && \
  echo "source ~/.dotfiles/.bashrc" >> ~/.bashrc

# Run through first-time Neovim setup
RUN git clone \
  --depth 1 \
  https://github.com/wbthomason/packer.nvim \
  /root/.local/share/nvim/site/pack/packer/start/packer.nvim && \
  nvim --headless \
  -c "autocmd User PackerComplete quitall" \
  -c "PackerSync" && \
  nvim --headless \
  -c "autocmd User MasonToolsUpdateCompleted quitall" \
  -c "MasonToolsUpdate"

CMD ["/bin/bash"]
