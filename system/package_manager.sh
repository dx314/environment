#!/bin/bash

# Function to determine the Linux distribution and set package manager alias
set_package_manager_alias() {
    # Determine the distribution
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "Cannot determine the distribution."
        return 1
    fi

    # Set alias based on the distribution
    if [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "debian" ]; then
        alias installpkg='sudo apt install'
        echo "Alias set: 'installpkg' -> 'sudo apt install'"
    elif [ "$DISTRO" = "fedora" ] || [ "$DISTRO" = "centos" ] || [ "$DISTRO" = "rhel" ]; then
        alias installpkg='sudo dnf install'
        echo "Alias set: 'installpkg' -> 'sudo dnf install'"
    else
        echo "Unsupported distribution: $DISTRO"
        return 1
    fi
}

# Initialize the function
set_package_manager_alias