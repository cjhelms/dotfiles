#!/bin/bash

# Install general dependencies
sudo apt-get update && sudo apt-get update -yqq && sudo apt-get -yqq install \
	git \
  wget \
  curl \
  unzip \
  stow \
  xclip \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv \
  npm

# Install configuration files
stow .
echo "source ~/.dotfiles/.bashrc" >> ~/.bashrc

# Make local install locations
mkdir -p ~/bin
mkdir -p ~/opt

# Install Regolith 2
. /etc/lsb-release
if [ "${DISTRIB_RELEASE}" = 20.04 ]; then
	wget -qO - https://regolith-desktop.org/regolith.key | sudo apt-key add -
	echo deb "[arch=amd64] https://regolith-desktop.org/release-ubuntu-focal-amd64 focal main" | \
		sudo tee /etc/apt/sources.list.d/regolith.list
elif [ "${DISTRIB_RELEASE}" = 22.04 ]; then
	wget -qO - https://regolith-desktop.org/regolith.key | \
		gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
	echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
		https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
		sudo tee /etc/apt/sources.list.d/regolith.list
else
	echo "Unsupported Ubuntu version!"
	echo "${DISTRIB_RELEASE}"
	exit 1
fi
sudo apt-get update
sudo apt-get install -yqq \
	regolith-desktop \
	regolith-compositor-picom-glx
sudo apt-get upgrade -yqq

# Install Docker
sudo apt-get update
sudo apt-get install -yqq ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
	sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
	"deb [arch="$(dpkg --print-architecture)" \
	signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -yqq \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker "${USER}"

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# Install Neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
mv nvim-linux64 ~/opt
ln -s ~/opt/nvim-linux64/bin/nvim ~/bin/nvim
git clone \
  --depth 1 \
  https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless \
  -c "autocmd User PackerComplete quitall" \
  -c "PackerSync"
nvim --headless \
  -c "autocmd User MasonToolsUpdateCompleted quitall" \
  -c "MasonToolsUpdate"

# Install Lazygit
mkdir lazygit && cd lazygit
wget "https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_32-bit.tar.gz"
tar -xvf lazygit_0.40.2_Linux_32-bit.tar.gz
mv lazygit ~/bin
cd .. && rm -rf lazygit

echo "Installation complete, please log out and log back in."
