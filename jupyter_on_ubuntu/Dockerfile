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
RUN apt -y install tzdata
ENV TZ=Asia/Tokyo
RUN apt -y install sudo python3-pip emacs

# USERADD
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} ${CONTAINER_USER_NAME}
RUN gpasswd -a ${CONTAINER_USER_NAME} sudo

# CHANGE USER
USER ${YOUR_UID}

# CHANGE WORK DIR
WORKDIR /home/${CONTAINER_USER_NAME}

# ADD BASHRC
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc

# INSTALL JUPYTER
RUN pip3 install jupyterlab

# JUPYTER SETTINGS
RUN $HOME/.local/bin/jupyter lab --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.port = 8888" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py

EXPOSE 8888