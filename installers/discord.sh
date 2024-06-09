#!/bin/bash

source ../system/functions.sh

# Function to install Discord on Ubuntu/Debian
install_discord_deb() {
    echo "Detected Ubuntu/Debian. Installing Discord..."
    # Download the latest Discord .deb package
    wget --content-disposition -qO /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"

    # Install the downloaded package
    sudo dpkg -i /tmp/discord.deb

    # Fix any missing dependencies
    sudo apt-get install -f -y

    # Clean up
    rm /tmp/discord.deb

    echo "Discord installed successfully on Ubuntu/Debian."
}

# Function to install Discord on Fedora
install_discord_rpm() {
    echo "Detected Fedora. Installing Discord..."
    # Download the latest Discord .rpm package
    sudo dnf install -y discord

    # Clean up
    rm /tmp/discord.rpm

    echo "Discord installed successfully on Fedora."
}

# Check if the system is either Ubuntu or Fedora
if is_fedora; then
    install_discord_rpm
elif is_ubuntu; then
    install_discord_deb
else
    echo "This script supports only Ubuntu and Fedora."
    exit 1
fi