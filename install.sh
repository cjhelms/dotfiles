sudo apt update
sudo apt upgrade -y
sudo apt autoremove

bash ./install-neovim.sh

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Docker
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor > /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
if ! [[ $(getent group docker) ]]; then
  sudo groupadd docker
fi
sudo usermod -aG docker $USER
newgrp docker

# Regolith
source /etc/os-release
if [[ $VERSION_ID == "22.04" ]]; then
  wget -qO - https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
  echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
  sudo tee /etc/apt/sources.list.d/regolith.list
  sudo apt update
  sudo apt install regolith-desktop regolith-compositor-picom-glx regolith-look-dracula -y
else
  echo "Not running Ubuntu 22.04, not installing Regolith!"
fi
