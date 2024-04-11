git clone https://github.com/typemill/typemill.git
cd typemill
docker build -t typemill:local .
sudo nano docker-compose.yml


version: "2.0"

services:
  typemill:
    image: typemill:local
    volumes:
      - ./typemill_data/settings/:/var/www/html/settings/
      - ./typemill_data/media/:/var/www/html/media/
      - ./typemill_data/data/:/var/www/html/data/
      - ./typemill_data/cache/:/var/www/html/cache/
      - ./typemill_data/plugins/:/var/www/html/plugins/
      - ./typemill_data/content/:/var/www/html/content/
      - ./typemill_data/themes/:/var/www/html/themes/
    ports:
      - 8080:80

      docker compose up -d
