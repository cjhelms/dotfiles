#!/bin/bash
if [ -f /usr/bin/python3.10 ]; then
    echo "Python 3.10 installation found!"
    exit 0
fi
sudo apt update
sudo apt install -y -q software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y -q python3.10 python3.10-venv python3.10-dev
