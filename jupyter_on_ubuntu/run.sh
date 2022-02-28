#!/bin/bash

# READ
echo "作成したいコンテナ名を入力してください（入力例「your_name_ubuntu」）"
read -p "> " CONTAINER_NAME

echo "コンテナ内の実行ユーザー名を入力してください（入力例「user」）"
read -p "> " CONTAINER_USER_NAME

echo "あなたのUIDを入力してください"
read -p "> " YOUR_UID

echo "Jupyterに接続するためのポート番号を入力してください"
read -p "> " JUPYTER_PORT

echo "マウントしたいホストのディレクトリのパスを入力してください（ホームディレクトリは避けてください）"
read -p "> " MOUNT_PATH
mkdir -p $MOUNT_PATH

echo "HTTP_PROXYを入力してください（指定しない場合はそのままEnter）"
read -p "> " JUPYTER_HTTP_PROXY

echo "HTTPS_PROXYを入力してください（指定しない場合はそのままEnter）"
read -p "> " JUPYTER_HTTPS_PROXY

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
        - http_proxy=${JUPYTER_HTTP_PROXY}
        - HTTPS_PROXY=${JUPYTER_HTTPS_PROXY}
        - https_proxy=${JUPYTER_HTTPS_PROXY}
        - YOUR_UID=${YOUR_UID}
        - CONTAINER_USER_NAME=${CONTAINER_USER_NAME}
    image: ${IMAGE_NAME}
    container_name: ${CONTAINER_NAME}
    ports:
      - '${JUPYTER_PORT}:8888'
    restart: always
    environment:
      - HTTP_PROXY=${JUPYTER_HTTP_PROXY}
      - http_proxy=${JUPYTER_HTTP_PROXY}
      - HTTPS_PROXY=${JUPYTER_HTTPS_PROXY}
      - https_proxy=${JUPYTER_HTTPS_PROXY}
    volumes:
      - ${MOUNT_PATH}:/home/${CONTAINER_USER_NAME}/jupyter
EOF

# RUN CONTAINER(S)
docker-compose up -d
rm docker-compose.yml