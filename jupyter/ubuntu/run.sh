#!/bin/bash

# READ
YOUR_UID=`id -u`
YOUR_GID=`id -g`
CONTAINER_USER_NAME=`id -un`

echo "作成したいコンテナ名を入力してください（入力例「your_name_ubuntu」）"
read -p "> " CONTAINER_NAME

echo "コンテナユーザのパスワードを入力してください（入力は非表示になっています）"
read -sp "> " CONTAINER_USER_PASSWORD

echo "Jupyterに接続するためのポート番号を入力してください"
read -p "> " JUPYTER_PORT

echo "HTTP(S)_PROXYを入力してください（指定しない場合はそのままEnter）"
read -p "> " JUPYTER_HTTP_PROXY

echo "保存するイメージ名を入力してください（入力例「your_name/ubuntu」）"
read -p "> " IMAGE_NAME

# EXPORT docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'
services:
  ${CONTAINER_NAME}:
    build:
      context: .
      args:
        - HTTP_PROXY=${JUPYTER_HTTP_PROXY}
        - HTTPS_PROXY=${JUPYTER_HTTP_PROXY}
        - YOUR_UID=${YOUR_UID}
        - YOUR_GID=${YOUR_GID}
        - CONTAINER_USER_NAME=${CONTAINER_USER_NAME}
        - CONTAINER_USER_PASSWORD=${CONTAINER_USER_PASSWORD}
    image: ${IMAGE_NAME}
    container_name: ${CONTAINER_NAME}
    ports:
      - '${JUPYTER_PORT}:8888'
    environment:
      - HTTP_PROXY=${JUPYTER_HTTP_PROXY}
      - http_proxy=${JUPYTER_HTTP_PROXY}
      - HTTPS_PROXY=${JUPYTER_HTTP_PROXY}
      - https_proxy=${JUPYTER_HTTP_PROXY}
    volumes:
      - ${HOME}:/home/${CONTAINER_USER_NAME}/@HOST_HOME
EOF

# RUN CONTAINER(S)
docker-compose up -d
rm docker-compose.yml