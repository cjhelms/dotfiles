#!/bin/bash
sudo apt-add-repository -y ppa:git-core/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install git -yqq
git config --global user.email "cjhelms1428@gmail.com"
git config --global user.name "Chris Helms"
ssh-keygen -t ed25519 -C "cjhelms1428@gmail.com" -N "" -f ~/.ssh/id_ed25519
