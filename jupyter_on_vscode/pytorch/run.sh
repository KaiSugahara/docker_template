#!/bin/bash

# EXPORT VARIABLE(S)
export YOUR_UID=`id -u` YOUR_GID=`id -g` CONTAINER_USER_NAME=`id -un`

echo "作成するコンテナ名を入力してください（入力例「your_name_pytorch」）"
read -p "> " CONTAINER_NAME

echo "コンテナユーザのパスワードを入力してください"
read -sp "> 入力内容は表示されません: " CONTAINER_USER_PASSWORD
echo ""

echo "sshで接続するためのポート番号を入力してください"
read -p "> " SSH_PORT

echo "作成するイメージ名を入力してください（入力例「your_name/pytorch」）"
read -p "> " IMAGE_NAME

export CONTAINER_NAME CONTAINER_USER_PASSWORD SSH_PORT IMAGE_NAME

# RUN CONTAINER(S)
docker-compose up -d