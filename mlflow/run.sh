#!/bin/bash

############################################################
# Input container settings
############################################################

echo "1. 作成するコンテナ名を入力してください（例「yourname_mlflow」）"
read -p "> " CONTAINER_NAME

echo "2. 作成するイメージ名を入力してください（例「yourname/mlflow」）"
read -p "> " IMAGE_NAME

echo "3. MLFlowに接続するためのポート番号を入力してください"
read -p "> " MLFLOW_PORT

echo "4. MLFlowのデータを保存するディレクトリを絶対パスで入力してください（例「${HOME}/mlflow」）"
read -p "> " MLFLOW_DIR_PATH
mkdir -p ${MLFLOW_DIR_PATH}
if [ -e ${MLFLOW_DIR_PATH} ]; then
    :
else
    exit 1
fi

############################################################
# Make container
############################################################

export YOUR_UID=`id -u` YOUR_GID=`id -g`
export CONTAINER_NAME IMAGE_NAME MLFLOW_PORT MLFLOW_DIR_PATH

# RUN DOCKER-COMPOSE
docker-compose build --no-cache --pull
docker-compose -p ${CONTAINER_NAME} up -d