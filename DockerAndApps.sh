#!/bin/bash

# Docker, Docker Compose, and Portainer installation script.

echo "Starting installation process..."

# Update the apt package index and install prerequisites
echo "Updating system packages..."
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common jq

# Install Docker CE
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update && sudo apt install -y docker-ce

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Allow current user to run Docker commands without sudo
sudo usermod -aG docker $USER

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
if [ -z "$DOCKER_COMPOSE_VERSION" ]; then
    echo "Failed to fetch Docker Compose version. Exiting installation."
    exit 1
fi
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify installation
docker --version
docker-compose --version

echo "Docker and Docker Compose installation completed."

# Install Portainer
echo "Installing Portainer..."
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

echo "Portainer installation complete."
echo "To access Portainer web console go to the following location:" 
echo "https://$(hostname -I | awk '{print $1}'):9443"

# Optional applications
echo "Setting up additional applications..."
docker pull bkimminich/juice-shop
docker run -d -p 3000:3000 --restart always bkimminich/juice-shop

docker pull vulnerables/web-dvwa
docker run --rm -it -p 80:80 vulnerables/web-dvwa

docker pull tleemcjr/metasploitable2
docker run -d -p 8022:22 -p 8000:80 -p 8443:443 tleemcjr/metasploitable2

docker bitsensor/elastalert
docker run -d -p 3030:3030 -p 3333:3333 bitsensor/elastalert


# Installing mkdocs
echo "Installing docusaurus"

docker pull someuser/docusaurus
docker run -d -p 3000:3000 someuser/docusaurus

echo "Docker configuration for docusaurus created."


echo "docusaurus application started."

# Completion message
echo "Installation complete. All services are up and running."
