#!/bin/bash
sudo apt-get update && sudo apt-get install wget
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
