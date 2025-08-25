#!/bin/bash
mkdir -p ~/opt
mkdir -p ~/bin
sudo apt update && sudo apt -yq install wget make build-essential xclip
wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
tar -xvf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 ~/opt
ln -s ~/opt/nvim-linux-x86_64/bin/nvim ~/bin/nvim
