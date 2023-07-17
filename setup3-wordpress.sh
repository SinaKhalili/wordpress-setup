#!/bin/bash

# Variables
MYSQL_ROOT_PASSWORD=root
DB_NAME=wordpress
DB_USER=root
DB_PASSWORD=$MYSQL_ROOT_PASSWORD
WP_PATH=/var/www/html
WP_URL=your_site_url
WP_TITLE="Site Title"
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=strongpassword
WP_ADMIN_EMAIL=user@example.com

echo "Installing WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

echo "Installing and securing MySQL..."
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
sudo apt install -y mysql-server
sudo mysql_secure_installation

echo "Creating a new MySQL database for WordPress..."
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME" | mysql -u root -p$MYSQL_ROOT_PASSWORD

echo "Downloading and installing WordPress..."
wp core download --path=$WP_PATH
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --path=$WP_PATH
wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=$WP_PATH

echo "Script 3 complete. WordPress should now be installed and running."
