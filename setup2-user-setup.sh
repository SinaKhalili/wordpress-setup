#!/bin/bash
set -e

WORDPRESSUSER=wordpressuser

if [ "$(whoami)" != "wordpressuser" ]; then
  echo "This script must be run as the 'wordpressuser' user! (created in the last step)" >&2
  exit 1
fi

pushd ~

echo "Installing required packages..."
sudo apt install -y nginx-extras curl php-fpm vim wget unzip git zsh mysql-server php-mysql


export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Changing to the user's home directory..."

echo "Cloning dotfiles repository and configuring vim and zsh..."
git clone https://github.com/SinaKhalili/dotfiles.git
cp ./dotfiles/zsh/.zshrc ~/.zshrc
cp ./dotfiles/zsh/antigen.zsh ~/antigen.zsh
cp ./dotfiles/vim/.vimrc ~/.vimrc

echo "Starting nginx and PHP-FPM services..."
sudo service nginx start
sudo service php8.1-fpm start

echo "Setting zsh as the default shell..."
sudo chsh -s $(which zsh)

echo "Script 2 complete. Your shell is now zsh. The nginx and php8.1-fpm services have started."
echo "You can check on these services with `systemctl status nginx` and `systemctl status php8.1-fpm` respectively"

popd
echo "Please run the next script. (./setup3-wordpress.sh)"

exec zsh
