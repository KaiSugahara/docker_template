# READ
echo "カレントディレクトリに mysql を作成し、MySQLデータのマウント先としてよろしいですか？ [y/n]"
read -p "> " MYSQLDATA_PATH_FLAG
case $MYSQLDATA_PATH_FLAG in
    y)
        MYSQLDATA_PATH="./mysql"
        ;;
    *)
        echo "MySQLデータのマウント先のパスを入力してください（入力形式例「./mysql」）"
        read -p "> " MYSQLDATA_PATH
        ;;
esac

echo "カレントディレクトリに phpmyadmin を作成し、セッションデータのマウント先としてよろしいですか？ [y/n]"
read -p "> " PHPMYADMIN_PATH_FLAG
case $PHPMYADMIN_PATH_FLAG in
    y)
        PHPMYADMIN_PATH="./phpmyadmin"
        ;;
    *)
        echo "MySQLデータのマウント先のパスを入力してください（入力形式例「./phpmyadmin」）"
        read -p "> " PHPMYADMIN_PATH
        ;;
esac

echo "phpmyadminにログインしたいポート番号を入力してください"
read -p "> " PHPMYADMIN_PORT

# EXPORT docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'

services:
  db-mysql:
    image: mysql:oracle
    container_name: db-mysql
    depends_on:
      - nginx-proxy
    volumes:
       - ${MYSQLDATA_PATH}:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  db-phpmyadmin:
    image: arm64v8/phpmyadmin
    container_name: db-phpmyadmin
    depends_on:
      - nginx-proxy
    environment:
      - PMA_ARBITRARY=1
      - PMA_HOST=db-mysql
      - PMA_USER=root
      - PMA_PASSWORD=wordpress
    ports:
      - ${PHPMYADMIN_PORT}:80
    volumes:
      - ${PHPMYADMIN_PATH}/sessions:/sessions
      - ${PHPMYADMIN_PATH}/phpmyadmin-misc.ini:/usr/local/etc/php/conf.d/phpmyadmin-misc.ini

networks:
  default:
    external: true
    name: nginx-network
EOF

# RUN CONTAINER(S)
docker-compose up -d