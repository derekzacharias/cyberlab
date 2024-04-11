#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Ask for the new hostname
echo "Enter the new hostname:"
read new_hostname

# Check if the user entered a hostname
if [ -z "$new_hostname" ]; then
    echo "No hostname entered. Exiting."
    exit 1
fi

# Change the hostname
hostnamectl set-hostname "$new_hostname"

# Update /etc/hostname
echo "$new_hostname" > /etc/hostname

# Update /etc/hosts to ensure localhost resolution
sed -i "s/127\.0\.1\.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts

echo "Hostname changed to $new_hostname"
