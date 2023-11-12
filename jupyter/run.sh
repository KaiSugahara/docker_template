!/bin/bash

############################################################
# Ready for docker-compose files
############################################################

echo "1. 作成するコンテナタイプ番号を入力してください
 [0] ubuntu (Jupyter Lab)
 [1] cuda11 (Jupyter Lab)
 [2] cuda12 (Jupyter Lab)
 [3] ubuntu (SSH)
 [4] cuda11 (SSH)
 [5] cuda12 (SSH)"
read -p "> " CONTAINER_TYPE

case $CONTAINER_TYPE in
    0)
        # ubuntu
        BASE_IMAGE_NAME="ubuntu:latest"
        COMPOSE_FILE_NAME="docker-compose-cpu.yml"
        START_SHELL_FILE_NAME="start-lab.sh"
        ;;
    1)
        # cuda11
        BASE_IMAGE_NAME="nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        START_SHELL_FILE_NAME="start-lab.sh"
        ;;
    2)
        # cuda12
        BASE_IMAGE_NAME="nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        START_SHELL_FILE_NAME="start-lab.sh"
        ;;
    3)
        # ubuntu
        BASE_IMAGE_NAME="ubuntu:latest"
        COMPOSE_FILE_NAME="docker-compose-cpu.yml"
        START_SHELL_FILE_NAME="start-ssh.sh"
        ;;
    4)
        # cuda11
        BASE_IMAGE_NAME="nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        START_SHELL_FILE_NAME="start-ssh.sh"
        ;;
    5)
        # cuda12
        BASE_IMAGE_NAME="nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        START_SHELL_FILE_NAME="start-ssh.sh"
        ;;
    *)
        echo "Error: 存在しないコンテナ番号のため中断しました"
        exit 1
        ;;
esac

############################################################
# Input container settings
############################################################

echo "2. 作成するコンテナ名を入力してください（例「yourname_ubuntu」）"
read -p "> " CONTAINER_NAME

echo "3. 作成するイメージ名を入力してください（例「yourname/ubuntu」）"
read -p "> " IMAGE_NAME

echo "4. コンテナユーザのパスワードを入力してください"
read -sp "入力内容は表示されません> ********** " CONTAINER_USER_PASSWORD
echo ""

echo "5. Jupyterに接続するためのポート番号を入力してください"
read -p "> " JUPYTER_PORT

############################################################
# Make container
############################################################

# ENCRYPT PASSWORD
CONTAINER_USER_PASSWORD=`openssl passwd -6 -salt $(openssl rand -base64 6) ${CONTAINER_USER_PASSWORD}`

# EXPORT VARIABLE(S)
export YOUR_UID=`id -u` YOUR_GID=`id -g` CONTAINER_USER_NAME=`id -un`
export BASE_IMAGE_NAME START_SHELL_FILE_NAME CONTAINER_NAME IMAGE_NAME CONTAINER_USER_PASSWORD JUPYTER_PORT

# DOCKER-COMPOSE
docker-compose -f ${COMPOSE_FILE_NAME} build --no-cache --pull
docker-compose -f ${COMPOSE_FILE_NAME} -p $CONTAINER_NAME up -d