#!/bin/bash

source ./functions.sh

# Function to install RPM Fusion free and non-free repositories
install_rpm_fusion() {
    echo "Installing RPM Fusion free and non-free repositories..."
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

# Function to install other common non-free repositories
install_other_non_free_repos() {
    echo "Installing other common non-free repositories..."

    # Add the Google Chrome repository
    sudo dnf config-manager --set-enabled google-chrome
    sudo sh -c 'echo -e "[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo'

    # Add the Microsoft repository for Visual Studio Code
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
}

# Main script execution
if is_fedora; then
    echo "Detected Fedora. Proceeding with installation of non-free repositories..."
    install_rpm_fusion
    install_other_non_free_repos
    echo "Non-free repositories installed successfully on Fedora."
else
    echo "This script is only for Fedora."
    exit 1
fi
