#!/bin/bash

CONTAINER_USER_NAME=`id -un`

# SET IMAGE_NAME
echo "dockerイメージ名 ${CONTAINER_USER_NAME}/mlflow で作成しても良いですか [y/N]: "
read -p "> " yn
case "$yn" in
    [yY]*)
        export IMAGE_NAME="${CONTAINER_USER_NAME}/mlflow"
        ;;
    *)
        echo "コンテナ名を入力してください: "
        read -p "> " IMAGE_NAME
        ;;
esac

# SET CONTAINER_NAME
echo "dockerコンテナ名 ${CONTAINER_USER_NAME}_mlflow で作成しても良いですか [y/N]: "
read -p "> " yn
case "$yn" in
    [yY]*)
        export CONTAINER_NAME="${CONTAINER_USER_NAME}_mlflow"
        ;;
    *)
        echo "コンテナ名を入力してください: "
        read -p "> " CONTAINER_NAME
        ;;
esac

# SET MLFLOW_PORT
echo "MLflow Tracking Server を立てるポート番号を指定してください: "
read -p "> " MLFLOW_PORT

echo $IMAGE_NAME
echo $CONTAINER_NAME
echo $MLFLOW_PORT
export IMAGE_NAME CONTAINER_NAME MLFLOW_PORT

# CHECK MAKE DIR.
echo "MLflow用に2つのディレクトリ ${HOME}/mlruns, ${HOME}/mlartifacts を作成しても良いですか [y/N]: "
read -p "> " yn
case "$yn" in
    [yY]*)
        ;;
    *)
        echo "NOTICE: コンテナ作成を終了しました"
        exit 1
        ;;
esac

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose -p ${CONTAINER_NAME} up -d