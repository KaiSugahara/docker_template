# READ
echo "作成するコンテナ名を入力してください（入力例「wp-domain-name」）"
read -p "> " CONTAINER_NAME

echo "接続するデータベース名を入力してください（入力例「wp_db_name」）"
read -p "> " DB_NAME

echo "割り当てたいドメイン名を入力してください（入力例「domain.com」または「domain0.com,domain1.com」）"
read -p "> " DOMAIN_NAME_LIST

echo "証明書取得に利用するメールアドレスを入力してください"
read -p "> " EMAIL_ADDRESS

echo "あなたのUIDを入力してください"
read -p "> " YOUR_UID

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

# EXPORT docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'

services:
  ${CONTAINER_NAME}:
    build:
      context: .
      dockerfile: Dockerfile
    image: ${YOUR_UID}/wordpress:latest
    container_name: ${CONTAINER_NAME}
    volumes:
      - ${WORDPRESS_PATH}:/var/www/html
    restart: always
    environment:
      WORDPRESS_DB_HOST: db-mysql:3306
      WORDPRESS_DB_NAME: ${DB_NAME}
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      VIRTUAL_HOST: ${DOMAIN_NAME_LIST}
      LETSENCRYPT_HOST: ${DOMAIN_NAME_LIST}
      LETSENCRYPT_EMAIL: ${EMAIL_ADDRESS}

networks:
  default:
    external: true
    name: nginx-network
EOF

# EXPORT Dockerfile
cat << EOF > Dockerfile
FROM wordpress:latest

RUN groupmod -g ${YOUR_UID} www-data
RUN usermod -u ${YOUR_UID} www-data
RUN chown -R www-data:www-data /usr/src/wordpress
EOF

# RUN CONTAINER(S)
docker-compose up -d