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
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header Host \$http_host;
        proxy_http_version 1.1;
        proxy_redirect off;
        proxy_buffering off;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass $TO_DOMAIN;
    }
}
EOF

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose -p ${CONTAINER_NAME} up -d