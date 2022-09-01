#!/bin/bash

# READ
echo "作成したいコンテナ名を入力してください"
read -p "> " CONTAINER_NAME

echo "保存するイメージ名を入力してください（入力例「your_name/ubuntu」）"
read -p "> " IMAGE_NAME

echo "割り当てたいドメイン名を入力してください（入力例「domain.com」または「domain0.com,domain1.com」）"
read -p "> " DOMAIN_NAME_LIST

echo "証明書取得に利用するメールアドレスを入力してください"
read -p "> " EMAIL_ADDRESS

# EXPORT docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'
services:
  ${CONTAINER_NAME}:
    build: $(cd $(dirname $0); pwd)
    image: ${IMAGE_NAME}
    container_name: ${CONTAINER_NAME}
    restart: always
    volumes:
      - ./app:/app
    environment:
      VIRTUAL_HOST: ${DOMAIN_NAME_LIST}
      LETSENCRYPT_HOST: ${DOMAIN_NAME_LIST}
      LETSENCRYPT_EMAIL: ${EMAIL_ADDRESS}

networks:
  default:
    external: true
    name: nginx-network
EOF

# RUN CONTAINER(S)
docker-compose up -d
rm docker-compose.yml