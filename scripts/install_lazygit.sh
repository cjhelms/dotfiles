#!/bin/bash
VERSION="v0.40.2"
TARBALL="lazygit_0.40.2_Linux_x86_64.tar.gz"
mkdir -p ~/bin
sudo apt-get update && sudo apt-get -yq install wget
mkdir lazygit && cd lazygit
wget "https://github.com/jesseduffield/lazygit/releases/download/${VERSION}/${TARBALL}"
tar -xzvf "${TARBALL}"
mv lazygit ~/bin
cd .. && rm -rf lazygit
