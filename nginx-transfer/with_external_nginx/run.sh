#!/bin/bash

# EXPORT VARIABLE(S)
read -p "CONTAINER_NAME: " CONTAINER_NAME
read -p "VIRTUAL_HOST: " VIRTUAL_HOST
read -p "LETSENCRYPT_EMAIL: " LETSENCRYPT_EMAIL
export CONTAINER_NAME VIRTUAL_HOST LETSENCRYPT_EMAIL

# MAKE .conf
read -p "TO_DOMAIN: " TO_DOMAIN

cat << EOF > ./localhost.conf
server {
    server_name $VIRTUAL_HOST;
    location / {
        proxy_pass $TO_DOMAIN;
    }
}
EOF

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose -p ${CONTAINER_NAME} up -d