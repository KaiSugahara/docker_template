FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04
USER root

# ARGS
ARG YOUR_UID
ARG YOUR_GID
ARG CONTAINER_USER_NAME
ARG CONTAINER_USER_PASSWORD

# ADD FILES
ADD start.sh /
RUN chmod +rx /start.sh
CMD ["/start.sh"]

# BASH
SHELL ["/bin/bash", "-c"]

# UPDATE & INSTALL
RUN /bin/bash
RUN apt update
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y install tzdata
ENV TZ=Asia/Tokyo
RUN apt -y install sudo python3-pip openssh-server language-pack-ja-base language-pack-ja git
RUN mkdir /var/run/sshd

# USERADD
RUN groupadd -g ${YOUR_GID} ${CONTAINER_USER_NAME}
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} -g ${YOUR_GID} ${CONTAINER_USER_NAME}
RUN gpasswd -a ${CONTAINER_USER_NAME} sudo

# CHANGE PASSWORD
RUN echo "root:password" | chpasswd
RUN echo "${CONTAINER_USER_NAME}:${CONTAINER_USER_PASSWORD}" | chpasswd -e

# CHANGE USER
USER ${YOUR_UID}

# CHANGE WORK DIR
WORKDIR /home/${CONTAINER_USER_NAME}

# ADD BASHRC
RUN echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc
RUN echo "export LANG=ja_JP.UTF-8" >> $HOME/.bashrc

# INSTALL JUPYTER
RUN pip3 install jupyterlab jupyterlab-git

# INSTALL PYTORCH
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

# JUPYTER SETTINGS
RUN $HOME/.local/bin/jupyter lab --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.port = 8888" >> $HOME/.jupyter/jupyter_lab_config.py
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py

# INSTALL LIBRARIES
COPY requirements.txt /home/${CONTAINER_USER_NAME}
RUN pip3 install -r requirements.txt

EXPOSE 22