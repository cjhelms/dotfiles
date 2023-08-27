ARG BASE_IMAGE=ubuntu
ARG BASE_TAG=latest
FROM $BASE_IMAGE:$BASE_TAG
WORKDIR /root
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
  python3-venv \
  npm
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
RUN curl -sL https://deb.nodesource.com/setup_18.x && apt-get install nodejs -yqq
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
  tar -xvf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz && \
  mv nvim-linux64 /opt && \
  ln -s /opt/nvim-linux64/bin/nvim /bin/nvim
ARG DOTFILES_CHECKOUT=master
RUN git clone https://github.com/cjhelms/dotfiles.git .dotfiles && \
  cd .dotfiles && \
  git checkout $DOTFILES_CHECKOUT && \
  stow . && \
  echo "source ~/.dotfiles/.bashrc" >> ~/.bashrc
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
