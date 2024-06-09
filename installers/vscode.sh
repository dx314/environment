#!/bin/bash

# Function to install VS Code on Ubuntu/Debian
install_vscode_deb() {
    echo "Detected Ubuntu/Debian. Installing Visual Studio Code..."
    # Download the latest VS Code .deb package
    wget -qO- https://update.code.visualstudio.com/latest/linux-deb-x64/stable -O /tmp/vscode.deb

    # Install the downloaded package
    sudo dpkg -i /tmp/vscode.deb

    # Fix any missing dependencies
    sudo apt-get install -f -y

    # Clean up
    rm /tmp/vscode.deb

    echo "Visual Studio Code installed successfully on Ubuntu/Debian."
}

# Function to install VS Code on Fedora
install_vscode_rpm() {
    echo "Detected Fedora. Installing Visual Studio Code..."
    # Download the latest VS Code .rpm package
    wget -qO- https://update.code.visualstudio.com/latest/linux-rpm-x64/stable -O /tmp/vscode.rpm

    # Install the downloaded package
    sudo dnf install -y /tmp/vscode.rpm

    # Clean up
    rm /tmp/vscode.rpm

    echo "Visual Studio Code installed successfully on Fedora."
}

# Detect the distribution and call the appropriate function
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
        install_vscode_deb
    elif [[ "$ID" == "fedora" ]]; then
        install_vscode_rpm
    else
        echo "Unsupported distribution: $ID. This script supports only Ubuntu/Debian and Fedora."
        exit 1
    fi
else
    echo "Cannot determine the distribution."
    exit 1
fi
