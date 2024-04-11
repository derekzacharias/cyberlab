#!/bin/bash

# Docker, Docker compose and Portainer installation script.

# Update the apt package index
sudo apt update

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker apt repository
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 

# Update the apt package index again
sudo apt update

# Install Docker CE
sudo apt install -y docker-ce

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Allow current user to run Docker commands
sudo usermod -aG docker $USER

# Install Docker Compose
# Check https://github.com/docker/compose/releases for the latest version
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Print Docker and Docker Compose versions
docker --version
docker-compose --version

echo "Docker and Docker Compose installation completed!"

#Install Portanior
echo "Installing Portanior............................................................................."

#wait 5 sec
sleep 5

#Create a docker volume for persistent storage
sudo docker volume create portainer_data

#download and install the Portainer Server container:
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

echo "Portanior install complete"

echo "To access Portanior web console go to the following location:" 

#Link to Address

echo "https://$(hostname -I | awk '{print $1}'):9443"

docker pull bkimminich/juice-shop
docker run -d -p 3000:3000 --restart always bkimminich/juice-shop

git clone https://github.com/typemill/typemill.git
cd typemill
docker build -t typemill:local .

# Define the base directory
base_dir="/var/www/html"

# List of paths to create
declare -a paths=(
    "settings/users/"
    "media/tmp/"
    "media/original/"
    "media/live/"
    "media/thumbs/"
    "media/custom/"
    "media/files/"
)

# Loop through the array and create each directory
for path in "${paths[@]}"; do
    mkdir -p "${base_dir}/${path}"
done

echo "Directories created successfully."

cat > docker-compose.yml <<EOF
version: '3.3'
services:
  typemill:
    image: typemill:local
    container_name: typemill
    ports:
      - "8080:80"
    volumes:
      - ./typemill_data/settings/:/var/www/html/settings/
      - ./typemill_data/media/:/var/www/html/media/
      - ./typemill_data/data/:/var/www/html/data/
      - ./typemill_data/cache/:/var/www/html/cache/
      - ./typemill_data/plugins/:/var/www/html/plugins/
      - ./typemill_data/content/:/var/www/html/content/
      - ./typemill_data/themes/:/var/www/html/themes/
    restart: always
EOF

echo "docker-compose.yml file created. Executing docker-compose.yml file."

docker compose up -d
