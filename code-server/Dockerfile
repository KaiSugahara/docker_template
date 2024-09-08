FROM ubuntu:latest

ARG YOUR_UID
ARG YOUR_GID

# Install code-server
RUN apt update
RUN apt -y install wget gpg
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |tee /etc/apt/sources.list.d/vscode.list > /dev/null
RUN rm -f packages.microsoft.gpg
RUN apt -y install apt-transport-https
RUN apt update
RUN apt -y install code

# Set CMD
CMD ["code", "serve-web", "--host", "0.0.0.0", "--without-connection-token", "--accept-server-license-terms"]

# Change Run-User
RUN groupadd -g ${YOUR_GID} user
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} -g ${YOUR_GID} user
USER user
WORKDIR /home/user
