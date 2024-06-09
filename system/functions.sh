#!/bin/bash
# Function to check if the system is Fedora
is_fedora() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "fedora" ]]; then
            return 0
        fi
    fi
    return 1
}

# Function to check if the system is Ubuntu
is_ubuntu() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
            return 0
        fi
    fi
    return 1
}