#!/bin/bash

# Fetch the latest Go version
GO_VERSION=$(curl -s https://go.dev/VERSION\?m\=text | head -n 1)
GO_TARBALL="$GO_VERSION.linux-amd64.tar.gz"
GO_URL="https://dl.google.com/go/$GO_TARBALL"
GOROOT="/usr/local/go"
PROFILE_SCRIPT="/etc/profile.d/golang.sh"

# Download the latest Go tarball
echo "Downloading $GO_TARBALL..."
wget $GO_URL -O /tmp/$GO_TARBALL

# Remove any previous Go installation
echo "Removing previous Go installation..."
sudo rm -rf $GOROOT

# Extract the downloaded tarball
echo "Extracting Go tarball to $GOROOT..."
sudo tar -C /usr/local -xzf /tmp/$GO_TARBALL

# Create profile script for Go environment variables
echo "Creating profile script at $PROFILE_SCRIPT..."
sudo tee $PROFILE_SCRIPT > /dev/null <<EOL
export GOROOT=$GOROOT
export GOPATH=\$HOME/go
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
EOL

# Ensure the profile script is executable
echo "Making the profile script executable..."
sudo chmod +x $PROFILE_SCRIPT

# Clean up
echo "Cleaning up..."
rm /tmp/$GO_TARBALL

# Source the profile script for the current session
echo "Applying changes..."
source $PROFILE_SCRIPT

# Verify installation
echo "Go version installed:"
go version

echo "Go environment variables:"
echo "GOROOT=$GOROOT"
echo "GOPATH=$HOME/go"
echo "PATH=$PATH"

echo "Go installation and configuration complete."
