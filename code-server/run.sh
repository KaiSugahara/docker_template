#!/bin/bash

############################################################
# Input container settings
############################################################

echo "1. 作成するコンテナ名を入力してください（例「yourname_ubuntu」）"
read -p "> " CONTAINER_NAME

echo "2. 作成するイメージ名を入力してください（例「yourname/ubuntu」）"
read -p "> " IMAGE_NAME

############################################################
# Make container
############################################################

# # EXPORT VARIABLE(S)
export YOUR_UID=`id -u` YOUR_GID=`id -g`
export CONTAINER_NAME IMAGE_NAME YOUR_UID YOUR_GID

# DOCKER-COMPOSE
docker compose build --pull
docker compose -p $CONTAINER_NAME up -d
