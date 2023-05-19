#!/bin/bash

# EXPORT VARIABLE(S)
read -p "TRACKING_PORT: " TRACKING_PORT
export TRACKING_PORT

# RUN DOCKER-COMPOSE
docker-compose build --no-cache
docker-compose up -d