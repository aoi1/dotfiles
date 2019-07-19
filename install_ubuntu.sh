#!/bin/sh
sudo wget "https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_386.tar.gz"
sudo tar xzvf peco_linux_386.tar.gz
cd peco_linux_386
sudo chmod +x peco
sudo cp peco /usr/local/bin
sudo apt-get install zsh
chsh -s $(which zsh)
