#!/bin/bash

# EXPORT VARIABLE(S)
read -p "PROJECT_NAME: " PROJECT_NAME
read -p "TRACKING_PORT: " TRACKING_PORT
export PROJECT_NAME TRACKING_PORT

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose -p ${PROJECT_NAME} up -d