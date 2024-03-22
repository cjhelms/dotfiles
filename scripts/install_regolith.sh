#!/bin/bash
sudo apt-get update && sudo apt-get -yq install wget
source /etc/lsb-release
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
sudo apt-get install -yq regolith-desktop regolith-look-gruvbox
