#!/bin/bash

# Update the package list
sudo apt update

# Upgrade all installed packages to their latest versions
sudo apt upgrade -y

# Remove unnecessary packages and dependencies
sudo apt autoremove -y

# Clean up any unused packages and files
sudo apt autoclean
