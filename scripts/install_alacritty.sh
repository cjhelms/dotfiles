#!/bin/bash
git clone https://github.com/alacritty/alacritty.git ~/.alacritty
cd ~/.alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup override set stable
rustup update stable
sudo apt install -yqq cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release
if infocmp alacritty &>/dev/null; then
    echo "Alacritty terminfo is already installed."
else
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
fi
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
echo "source ~/.alacritty/extra/completions/alacritty.bash" >> ~/.bashrc
