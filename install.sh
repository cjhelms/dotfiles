apt update && apt upgrade -y && apt autoremove
apt install git fzf stow -y
source /etc/os-release
if [[ $VERSION_ID == "22.04" ]]; then
  wget -qO - https://regolith-desktop.org/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
  echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
  sudo tee /etc/apt/sources.list.d/regolith.list
  apt install regolith-desktop regolith-compositor-picom-glx regolith-look-dracula -y
else
  echo "Not running Ubuntu 22.04, not installing Regolith!"
fi
