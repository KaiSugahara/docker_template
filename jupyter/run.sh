#!/bin/bash

##############################
# Container Settings
##############################

echo "Step1: Select and type in the container you wish to create
 [0] ubuntu (Jupyter Lab)
 [1] cuda11 (Jupyter Lab)
 [2] cuda12 (Jupyter Lab)"
read -p "> " CONTAINER_TYPE

case $CONTAINER_TYPE in
    0)
        # ubuntu
        BASE_IMAGE_NAME="ubuntu:latest"
        COMPOSE_FILE_NAME="docker-compose-cpu.yml"
        ;;
    1)
        # cuda11
        BASE_IMAGE_NAME="nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        ;;
    2)
        # cuda12
        BASE_IMAGE_NAME="nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04"
        COMPOSE_FILE_NAME="docker-compose-gpu.yml"
        ;;
    *)
        echo "Error: Aborted because a non-existent container number was typed in"
        exit 1
        ;;
esac

echo "Step2: Type in the container's port"
read -p "> " JUPYTER_PORT

##############################
# Make container
##############################

# Make jupyter config dir. in host
mkdir -p ${HOME}/.jupyter/lab/user-settings

# Export variables
export YOUR_UID=`id -u` YOUR_GID=`id -g`
export BASE_IMAGE_NAME JUPYTER_PORT
export IMAGE_NAME="jupyter/${JUPYTER_PORT}"
export CONTAINER_NAME="jupyter-${JUPYTER_PORT}"

# Make
docker compose -f ${COMPOSE_FILE_NAME} build --no-cache --pull
docker compose -f ${COMPOSE_FILE_NAME} -p $CONTAINER_NAME up -d
