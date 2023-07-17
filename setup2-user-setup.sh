#!/bin/bash

echo "Installing required packages..."
sudo apt install -y nginx-extras curl php-fpm vim wget unzip git zsh mysql-server

echo "Setting zsh as the default shell..."
sudo chsh -s $(which zsh)

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Cloning dotfiles repository and configuring vim and zsh..."
git clone https://github.com/SinaKhalili/dotfiles.git
cp ./dotfiles/zsh/.zshrc ~/.zshrc
cp ./dotfiles/zsh/antigen.zsh ~/antigen.zsh
cp ./dotfiles/vim/.vimrc ~/.vimrc

echo "Starting nginx and PHP-FPM services..."
sudo service nginx start
sudo service php8.1-fpm start

echo "Script 2 complete. Please run the next script."
