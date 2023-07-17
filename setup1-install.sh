#!/bin/bash

# Variables
WORDPRESSUSER=wordpressuser

echo "Updating the system..."
apt update -y
apt upgrade -y

echo "Creating a new user for WordPress and adding it to the sudo group..."
adduser $WORDPRESSUSER
usermod -aG sudo $WORDPRESSUSER

echo "Script 1 complete. Please run the next script as the new user."
