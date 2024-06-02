# SELECT BASE IMAGE
ARG BASE_IMAGE_NAME
FROM ${BASE_IMAGE_NAME}
USER root

# SELECT BASH
SHELL ["/bin/bash", "-c"]

# UPDATE & INSTALL
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get update
RUN apt -y install sudo git

# USERADD
ARG YOUR_UID
ARG YOUR_GID
RUN groupadd -f -g ${YOUR_GID} jupyter
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} -g ${YOUR_GID} -G sudo jupyter
RUN echo "root:password" | chpasswd
RUN echo "jupyter:password" | chpasswd

# INSTALL python3
RUN apt -y install python3-pip python3-venv

# CHANGE USER
USER ${YOUR_UID}
WORKDIR /home/jupyter

# SET LOCALE
RUN echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc

# INSTALL JUPYTER & OTHER LIBRARIES
RUN python3 -m venv ~/.venv
COPY requirements.txt /home/jupyter
RUN source ~/.venv/bin/activate && pip3 install --upgrade pip  && pip3 install -r requirements.txt
RUN rm -f ~/requirements.txt

# RUN JUPYTER LAB
CMD ["/bin/bash", "-c", "source ~/.venv/bin/activate && export SHELL=/bin/bash && jupyter lab --ip=0.0.0.0 --no-browser --port=8888"]