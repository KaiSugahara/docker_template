FROM ubuntu:latest
USER root

RUN apt update
RUN apt -y install sudo python3-pip
RUN apt install -y default-libmysqlclient-dev

RUN pip install mlflow mysqlclient boto3

EXPOSE 5000

RUN mkdir -p /mlflow
WORKDIR /mlflow