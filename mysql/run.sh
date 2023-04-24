#!/bin/bash

# EXPORT VARIABLE(S)
echo "phpmyadminにログインしたいポート番号を入力してください"
read -p "> " PHPMYADMIN_PORT

export PHPMYADMIN_PORT

# RUN DOCKER-COMPOSE
docker-compose up -d