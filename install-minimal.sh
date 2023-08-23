# Miscellaneous tools
sudo apt install curl unzip wget git fzf stow xclip npm -y

# Ensure Python pip is installed
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
rm get-pip.py

# TODO: Ensure Python venv is installed

# Install npm (necessary for Pyright language server)
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs

# Install Neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
mkdir -p ~/opt
mv -f nvim-linux64 ~/opt
mkdir -p ~/bin
ln -s ~/opt/nvim-linux64/bin/nvim ~/bin/nvim
