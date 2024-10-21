#!/bin/sh

# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Install peco
sudo wget "https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_386.tar.gz"
sudo tar xzvf peco_linux_386.tar.gz
cd peco_linux_386
sudo chmod +x peco
sudo cp peco /usr/local/bin

# Install zsh
sudo apt-get install -y zsh
chsh -s $(which zsh)

# Install dein.vim [deprecated]
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
aoi cat install_ubuntu.sh                                                                                                                                                     [/quipper/monorepo/dotfiles][master]
#!/bin/sh

# Install NeoVim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Install peco
sudo wget "https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_386.tar.gz"
sudo tar xzvf peco_linux_386.tar.gz
cd peco_linux_386
sudo chmod +x peco
sudo cp peco /usr/local/bin

# Install zsh
sudo apt-get install -y zsh
chsh -s $(which zsh)

# Install dein.vim [deprecated]
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
