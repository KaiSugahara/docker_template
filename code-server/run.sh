#!/bin/bash

############################################################
# Input container settings
############################################################

echo "1. 作成するコンテナ名を入力してください（例「yourname_ubuntu」）"
read -p "> " CONTAINER_NAME

echo "2. 作成するイメージ名を入力してください（例「yourname/ubuntu」）"
read -p "> " IMAGE_NAME

echo "3. code-serverの起動ポート番号を入力してください"
read -p "> " CODE_PORT

############################################################
# Make config.yaml
############################################################

echo "bind-addr: 0.0.0.0:8080" > config.yaml
echo "auth: none" >> config.yaml
echo "cert: false" >> config.yaml

############################################################
# Make container
############################################################

# # EXPORT VARIABLE(S)
export YOUR_UID=`id -u` YOUR_GID=`id -g`
export CONTAINER_NAME IMAGE_NAME CODE_PORT YOUR_UID YOUR_GID

# DOCKER-COMPOSE
docker-compose build --no-cache --pull
docker-compose -p $CONTAINER_NAME up -d