#!/bin/bash
mkdir -p ~/opt
mkdir -p ~/bin
sudo apt update && sudo apt -yq install wget make build-essentials
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
mv nvim-linux64 ~/opt
ln -s ~/opt/nvim-linux64/bin/nvim ~/bin/nvim
