FROM ubuntu:latest
USER root

# CHANGE WORKDIR
WORKDIR /app

# BASH
SHELL ["/bin/bash", "-c"]

# UPDATE & INSTALL
RUN apt update
RUN apt-get update
RUN apt -y install tzdata
ENV TZ=Asia/Tokyo
RUN apt -y install sudo python3-pip

# INSTALL FLASK
RUN pip3 install Flask

# SET CMD
CMD ["python3", "index.py"]