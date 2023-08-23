# Miscellaneous tools
sudo apt install wget git fzf stow xclip npm -y

# Install neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xvf nvim-linux64.tar.gz
rm install nvim-linux64.tar.gz
if [ ! -d "~/opt" ]; then
  mkdir ~/opt
fi
mv nvim-linux64 ../opt
if [ ! -d "~/bin" ]; then
  mkdir ~/bin
fi
ln -s ~/opt/nvim-linux64/bin/nvim ~/bin/nvim
