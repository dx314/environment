#!/bin/bash

echo "Setting up DX314 Linux Environment"

source ./system/functions.sh

# Check if the system is either Ubuntu or Fedora
if is_ubuntu; then
    echo "This system is running Ubuntu."
elif is_fedora; then
    echo "This system is running Fedora."
else
    echo "This script supports only Ubuntu and Fedora."
    exit 1
fi

# Main script execution
if is_fedora; then
    echo "Detected Fedora. "
else
    echo "This script is only for Fedora."
    exit 1
fi


./system/sudoers.sh
./system/package_manager.sh
./system/repos.sh
./installers/go.sh
./installers/telegram.sh
./installers/discord.sh
./installers/vscode.sh