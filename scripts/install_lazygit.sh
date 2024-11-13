#!/bin/bash
VERSION="0.44.1"
TARBALL="lazygit_${VERSION}_Linux_x86_64.tar.gz"
mkdir -p ~/bin
apt-get update && apt-get -yq install wget
mkdir lazygit && cd lazygit
wget "https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/${TARBALL}"
tar -xzvf "${TARBALL}"
mv lazygit ~/bin
cd .. && rm -rf lazygit
