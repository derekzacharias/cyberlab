
#!/bin/bash

# Script to install Ubuntu MAAS (Metal as a Service)
# Ensure you run this script as root or with sudo privileges.

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Enable the Universe repository
echo "Enabling the Universe repository..."
sudo add-apt-repository universe

# Add the MAAS Stable PPA
echo "Adding the MAAS Stable PPA..."
sudo add-apt-repository -y ppa:maas/3.3

# Update the package list again
echo "Updating the package list after adding PPA..."
sudo apt update

# Install MAAS
echo "Installing MAAS..."
sudo apt install -y maas

# Prompt for user inputs
read -p "Enter the MAAS admin username: " MAAS_ADMIN_USERNAME
read -p "Enter the MAAS admin email: " MAAS_ADMIN_EMAIL
read -s -p "Enter the MAAS admin password: " MAAS_ADMIN_PASSWORD
echo

# Initialize MAAS and create admin user
echo "Initializing MAAS and creating admin user..."
sudo maas init --mode all

# Configure PostgreSQL (local installation)
echo "Configuring PostgreSQL for MAAS..."
sudo maas-region createadmin --username "$MAAS_ADMIN_USERNAME" --email "$MAAS_ADMIN_EMAIL" --password "$MAAS_ADMIN_PASSWORD"

# Get the IP address of the machine
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Configure MAAS URL
MAAS_URL="http://$IP_ADDRESS:5240/MAAS"
echo "Configuring MAAS URL as $MAAS_URL..."
sudo maas config --set default-url="$MAAS_URL"

# Display the MAAS web interface URL
echo "MAAS installation completed."
echo "Access the MAAS web interface at: $MAAS_URL"
echo "Use the admin credentials to log in."

# Restart MAAS services
echo "Restarting MAAS services..."
sudo systemctl restart maas-regiond
sudo systemctl restart maas-rackd

echo "MAAS setup is complete!"
