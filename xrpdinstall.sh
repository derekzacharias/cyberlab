#!/bin/bash

# Script to install and configure xrdp on Kali Linux for Xfce Desktop

# Update and upgrade the system
echo "Updating and upgrading your system. This may take a few minutes..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install the xfce desktop
sudo apt-get install kali-desktop-xfce -y


# Install xrdp
echo "Installing xrdp..."
sudo apt-get install xrdp -y

# Allow RDP traffic on the firewall (Uncomment if you use ufw)
# echo "Allowing RDP traffic through the firewall..."
# sudo ufw allow 3389

# Configure xrdp to use Xfce
echo "Configuring xrdp to use Xfce..."
echo xfce4-session > ~/.xsession

# Copy the .xsession file for xrdp
sudo cp ~/.xsession /etc/skel

# Ensure correct permissions for Xwrapper
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config

# Restart xrdp service to apply changes
echo "Enabling this service..."
sudo systemctl enable xrdp
echo "Restarting xrdp service..."
sudo systemctl restart xrdp

echo "xrdp installation and configuration completed. You can now try logging in using RDP."
