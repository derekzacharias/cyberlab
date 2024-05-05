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

# Optional applications (example using Juice-shop and PicoCMS)
echo "Setting up additional applications..."
docker pull bkimminich/juice-shop
docker run -d -p 3000:3000 --restart always bkimminich/juice-shop

# Installing mkdocs
echo "Installing mkdocs"

# Pulling continer from dockerhub
docker pull squidfunk/mkdocs-material

#Creating persistence
sudo mkdir mkdocs
cd mkdocs
mkdir docs
mkdir -p docs/cyber-security-fundamentals
touch docs/cyber-security-fundamentals/introduction.md
touch docs/cyber-security-fundamentals/threats-vulnerabilities.md
touch docs/cyber-security-fundamentals/principles.md
touch docs/cyber-security-fundamentals/cryptography.md

sudo mkdir -p docs/network-security
touch docs/network-security/network-fundamentals.md
touch docs/network-security/securing-infra.md
touch docs/network-security/ids-ips.md
touch docs/network-security/firewalls.md
touch docs/network-security/vpns.md

mkdir -p docs/ethical-hacking
touch docs/ethical-hacking/introduction.md
touch docs/ethical-hacking/reconnaissance.md
touch docs/ethical-hacking/scanning.md
touch docs/ethical-hacking/vulnerability-assessment.md
touch docs/ethical-hacking/exploitation.md
touch docs/ethical-hacking/maintaining-access.md
touch docs/ethical-hacking/pen-testing-reports.md

mkdir -p docs/web-app-security
touch docs/web-app-security/architecture.md
touch docs/web-app-security/common-vuln.md
touch docs/web-app-security/secure-coding.md
touch docs/web-app-security/testing-tools.md
touch docs/web-app-security/defensive-programming.md

mkdir -p docs/incident-response
touch docs/incident-response/preparation.md
touch docs/incident-response/forensic-tools.md
touch docs/incident-response/evidence-collection.md
touch docs/incident-response/legal.md

mkdir -p docs/os-security
touch docs/os-security/os-features.md
touch docs/os-security/patch-management.md
touch docs/os-security/malware-analysis.md
touch docs/os-security/reverse-engineering.md

mkdir -p docs/cloud-security
touch docs/cloud-security/overview.md
touch docs/cloud-security/challenges.md
touch docs/cloud-security/best-practices.md
touch docs/cloud-security/service-models.md

mkdir -p docs/cyber-law
touch docs/cyber-law/overview.md
touch docs/cyber-law/ethics.md
touch docs/cyber-law/compliance.md

mkdir -p docs/emerging-tech
touch docs/emerging-tech/ai.md
touch docs/emerging-tech/blockchain.md
touch docs/emerging-tech/quantum.md



# Initialize a new project
docker run --rm -v ${PWD}:/docs squidfunk/mkdocs-material new .

# Starting mkdocs container
docker run -d -it --rm -p 8080:8000 -v ${PWD}:/docs squidfunk/mkdocs-material

echo "Docker configuration for mkdocs created."


echo "mkdocs application started."

# Completion message
echo "Installation complete. All services are up and running."
