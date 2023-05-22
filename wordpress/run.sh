#!/bin/bash

# EXPORT VARIABLE(S)
export YOUR_UID=`id -u`

echo "作成するコンテナ名を入力してください（入力例「wp-domain-name」）"
read -p "> " CONTAINER_NAME

echo "接続するデータベース名を入力してください（入力例「wp_db_name」）"
read -p "> " DB_NAME

echo "割り当てたいドメイン名を入力してください（入力例「domain.com」または「domain0.com,domain1.com」）"
read -p "> " DOMAIN_NAME_LIST

echo "証明書取得に利用するメールアドレスを入力してください"
read -p "> " EMAIL_ADDRESS

echo "カレントディレクトリに public_html を作成し、公開ファイルのマウント先として良いですか？ [y/n]"
read -p "> " WORDPRESS_PATH_FLAG
case $WORDPRESS_PATH_FLAG in
    y)
        WORDPRESS_PATH="./public_html"
        ;;
    *)
        echo "公開ファイルのマウント先のパスを入力してください（入力例「./public_html」）"
        read -p "> " WORDPRESS_PATH
        ;;
esac

export YOUR_UID CONTAINER_NAME DB_NAME DOMAIN_NAME_LIST EMAIL_ADDRESS YOUR_UID WORDPRESS_PATH

# RUN CONTAINER(S)
docker-compose -p $CONTAINER_NAME up -d