#!/bin/bash
mkdir -p ~/opt
mkdir -p ~/bin
sudo apt-get update && sudo apt-get -yq install wget
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
mv nvim-linux64 ~/opt
ln -s ~/opt/nvim-linux64/bin/nvim ~/bin/nvim
# /usr/bin/python3.10 -m pip install pynvim
