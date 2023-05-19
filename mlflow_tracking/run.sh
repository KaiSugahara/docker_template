#!/bin/bash

# EXPORT VARIABLE(S)
read -p "VIRTUAL_HOST: " VIRTUAL_HOST
read -p "LETSENCRYPT_EMAIL: " LETSENCRYPT_EMAIL

export VIRTUAL_HOST LETSENCRYPT_EMAIL

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose up -d