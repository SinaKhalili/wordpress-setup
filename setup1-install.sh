#!/bin/bash
set -e

if [ "$(whoami)" != "root" ]; then
  echo "This script must be run as the 'root' user! (this is the default DO user)" >&2
  exit 1
fi

# Variables
WORDPRESSUSER=wordpressuser

echo "Updating the system..."
apt update -y
apt upgrade -y

echo "Creating a new user for WordPress and adding it to the sudo group..."
adduser --gecos "" $WORDPRESSUSER
usermod -aG sudo $WORDPRESSUSER

echo "Script 1 complete. Please run the next script as the new user. (su wordpressuser; ./setup2-user-setup.sh)"
