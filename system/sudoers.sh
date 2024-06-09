#!/bin/bash

# Get the current username
USER_NAME=$(whoami)

# If a specific user is passed as an argument, use that instead
if [ ! -z "$1" ]; then
  USER_NAME=$1
fi

# Check if the script is run as root
if [ "$USER_NAME" == "root" ]; then
  echo "Please do not run this script as root. Use your regular user account with sudo privileges."
  exit 1
fi

# Backup the current sudoers file
sudo cp /etc/sudoers /etc/sudoers.bak

# Check if the user is already in the sudoers file with NOPASSWD
if sudo grep -q "^$USER_NAME ALL=(ALL) NOPASSWD:ALL" /etc/sudoers; then
  echo "User $USER_NAME already has NOPASSWD entry in sudoers."
else
  # Check if the user is in the sudoers file without NOPASSWD
  if sudo grep -q "^$USER_NAME ALL=(ALL)" /etc/sudoers; then
    echo "User $USER_NAME found in sudoers without NOPASSWD. Updating entry..."
    # Use sed to update the entry to include NOPASSWD
    sudo sed -i "s/^$USER_NAME ALL=(ALL).*/$USER_NAME ALL=(ALL) NOPASSWD:ALL/" /etc/sudoers
  else
    # Add the user to the sudoers file with NOPASSWD
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
  fi
  echo "User $USER_NAME added to sudoers with NOPASSWD."
fi
