#!/bin/bash

# Script to change hostname, IP address, or both on Ubuntu 24.04
# Default DNS Servers: 192.168.20.181 and 192.168.20.182

# Function to display a message and exit
function exit_script {
    echo -e "\n$1"
    exit 1
}

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    exit_script "Please run this script as root."
fi

# Display menu options
echo "Welcome to the hostname and IP configuration script for Ubuntu 24.04!"
echo "Please select an option:"
echo "1. Change the hostname"
echo "2. Change the IP address"
echo "3. Change both hostname and IP address"
echo "4. Exit"

read -p "Enter your choice (1/2/3/4): " CHOICE

if [ "$CHOICE" == "4" ]; then
    exit_script "Exiting the script. No changes made."
fi

# Function to change the hostname
function change_hostname {
    read -p "Enter the new hostname: " NEW_HOSTNAME
    if [ -z "$NEW_HOSTNAME" ]; then
        echo "Hostname cannot be empty. Skipping hostname configuration."
    else
        echo "Changing hostname to '$NEW_HOSTNAME'..."
        hostnamectl set-hostname "$NEW_HOSTNAME"
        if [ $? -eq 0 ]; then
            echo "Hostname successfully changed to '$NEW_HOSTNAME'."
        else
            exit_script "Failed to change hostname."
        fi
    fi
}

# Function to change the IP address
function change_ip_address {
    read -p "Enter the new static IP address (e.g., 192.168.20.100): " NEW_IP
    read -p "Enter the subnet mask (e.g., 255.255.255.0): " SUBNET_MASK
    read -p "Enter the gateway (e.g., 192.168.20.1): " GATEWAY

    if [ -z "$NEW_IP" ] || [ -z "$SUBNET_MASK" ] || [ -z "$GATEWAY" ]; then
        echo "IP address, subnet mask, or gateway cannot be empty. Skipping IP configuration."
    else
        echo "Configuring IP address to $NEW_IP with gateway $GATEWAY and subnet mask $SUBNET_MASK..."

        # Backup the current netplan configuration
        NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"
        BACKUP_FILE="${NETPLAN_CONFIG}.bak"

        cp "$NETPLAN_CONFIG" "$BACKUP_FILE"
        echo "Backup of current netplan configuration saved to $BACKUP_FILE."

        # Update the netplan configuration
        cat > "$NETPLAN_CONFIG" <<EOF
network:
  version: 2
  ethernets:
    eth0:
      addresses:
        - $NEW_IP/$SUBNET_MASK
      gateway4: $GATEWAY
      nameservers:
        addresses:
          - 192.168.20.181
          - 192.168.20.182
EOF

        if [ $? -eq 0 ]; then
            echo "Netplan configuration updated."
        else
            exit_script "Failed to update netplan configuration."
        fi

        # Apply netplan changes
        echo "Applying netplan configuration..."
        netplan apply
        if [ $? -eq 0 ]; then
            echo "Network configuration successfully applied."
        else
            exit_script "Failed to apply network configuration. Please check the netplan file."
        fi
    fi
}

# Execute the chosen option
case $CHOICE in
    1)
        change_hostname
        ;;
    2)
        change_ip_address
        ;;
    3)
        change_hostname
        change_ip_address
        ;;
    *)
        exit_script "Invalid choice. Exiting script."
        ;;
esac

# Confirmation
echo -e "\nFinal Configuration:"
echo "Hostname: $(hostname)"
echo "IP Address: $(ip addr show | grep inet | grep -v inet6 | awk '{print $2}')"
echo "DNS Servers: 192.168.20.181, 192.168.20.182"

echo -e "\nConfiguration completed successfully!"
echo "If you experience any issues, restore the backup configuration using:"
echo "sudo cp $BACKUP_FILE $NETPLAN_CONFIG && sudo netplan apply"
