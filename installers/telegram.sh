#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Function to show progress
show_progress() {
    echo -n "$1"
    for i in {1..10}; do
        echo -n "."
        sleep 0.1
    done
    echo ""
}

# Download the latest Telegram .tar.xz package
show_progress "Downloading Telegram"
wget -qO- https://telegram.org/dl/desktop/linux -O /tmp/telegram.tar.xz

# Check if the download was successful
if [ ! -f /tmp/telegram.tar.xz ]; then
    echo "Failed to download Telegram."
    exit 1
fi

# Extract the downloaded package
show_progress "Extracting Telegram"
sudo tar -xvf /tmp/telegram.tar.xz -C /opt/ > /dev/null

# Create a symbolic link to make Telegram accessible
show_progress "Creating symbolic link"
sudo ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram

# Copy the icon to the appropriate location
show_progress "Copying icon"
sudo cp ../assets/icons/telegram.png /opt/Telegram/

# Create a desktop entry
show_progress "Creating desktop entry"
sudo tee /usr/share/applications/telegram.desktop > /dev/null <<EOL
[Desktop Entry]
Name=Telegram Desktop
Comment=Telegram Messenger
Exec=/usr/local/bin/telegram
Icon=/opt/Telegram/telegram.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;
EOL

# Update the desktop database to make the new entry appear right away
show_progress "Updating desktop database"
sudo update-desktop-database /usr/share/applications > /dev/null

# Clean up
show_progress "Cleaning up"
rm /tmp/telegram.tar.xz

echo "Telegram installed successfully."
