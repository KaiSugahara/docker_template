# READ
echo "カレントディレクトリに certs を作成し、証明書ファイルのマウント先としてよろしいですか？ [y/n]"
read -p "> " CERT_PATH_FLAG
case $CERT_PATH_FLAG in
    y)
        CERT_PATH="./certs"
        ;;
    *)
        echo "証明書ファイルのマウント先のパスを入力してください"
        read -p "> " CERT_PATH
        ;;
esac

# EXPORT docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'

services:
  nginx-proxy:
    image: jwilder/nginx-proxy:latest
    container_name: nginx-proxy
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - $CERT_PATH:/etc/nginx/certs:ro
      - /etc/nginx/vhost.d
      - /usr/share/nginx/html
      - /var/run/docker.sock:/tmp/docker.sock:ro
    restart: always
  nginx-letsencrypt:
    image: jrcs/letsencrypt-nginx-proxy-companion:latest
    container_name: nginx-letsencrypt
    depends_on: 
        - nginx-proxy
    volumes:
      - $CERT_PATH:/etc/nginx/certs
      - /var/run/docker.sock:/var/run/docker.sock:ro
    volumes_from:
      - nginx-proxy
    restart: always

networks:
  default:
    name: nginx-network
EOF

# RUN CONTAINER(S)
docker-compose up -d