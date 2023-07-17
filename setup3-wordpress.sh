#!/bin/bash
set -e

# Variables
MYSQL_ROOT_PASSWORD=root
DB_NAME=wordpress
DB_USER=wordpressuser
WORDPRESSUSER=wordpressuser
DB_PASSWORD=wordpresspassword
WP_PATH=/var/www/html
WP_URL=your_site_url
WP_TITLE="Site Title"
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=strongpassword
WP_ADMIN_EMAIL=user@example.com

echo "Installing WP-CLI..."
pushd ~
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

sudo chown -R $WORDPRESSUSER:$WORDPRESSUSER $WP_PATH

echo "Creating a new MySQL database and user for WordPress..."
DB_EXISTS=$(sudo mysql -u root --skip-password -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep ${DB_NAME} > /dev/null; echo "$?")
if [ "$DB_EXISTS" -eq 0 ]; then
  echo "Database ${DB_NAME} already exists, skipping..."
else
  sudo mysql <<EOF
  CREATE DATABASE ${DB_NAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
  CREATE USER '${DB_USER}'@'localhost' IDENTIFIED WITH mysql_native_password BY '${DB_PASSWORD}';
  GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
  FLUSH PRIVILEGES;
EOF
fi


echo "Downloading and installing WordPress..."
wp core download --path=$WP_PATH
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --path=$WP_PATH
wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=$WP_PATH

popd

echo "Script 3 complete. WordPress should now be installed and running."
