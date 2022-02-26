FROM ubuntu:latest
USER root

# ARGS
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG YOUR_UID
ARG CONTAINER_USER_NAME

# ADD FILES
ADD start.sh /
RUN chmod +rx /start.sh
CMD ["/start.sh"]

# BASH
SHELL ["/bin/bash", "-c"]

# APT PROXY SETTING
RUN echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf
RUN echo "Acquire::https::Proxy \"${HTTPS_PROXY}\";" >> /etc/apt/apt.conf

# UPDATE & INSTALL
RUN /bin/bash
RUN apt update
RUN apt-get update
RUN apt install sudo
RUN echo y | apt install python3-pip

# USERADD
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} ${CONTAINER_USER_NAME}
RUN gpasswd -a ${CONTAINER_USER_NAME} sudo

# MAKE BACKUP DIR
RUN mkdir /backup
RUN chown ${YOUR_UID} /backup

# CHANGE USER
USER ${YOUR_UID}
WORKDIR /home/${CONTAINER_USER_NAME}

# ADD BASHRC
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> .bashrc
RUN source .bashrc

# INSTALL JUPYTER
RUN pip3 install jupyterlab

# INSTALL TO BACKUP DIR
RUN cp -r /home/${CONTAINER_USER_NAME}/. /backup/

EXPOSE 8888