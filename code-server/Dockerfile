FROM ubuntu:latest

ARG YOUR_UID
ARG YOUR_GID

# Install code-server
RUN apt update -y
RUN apt install -y curl
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set CMD
CMD ["code-server"]

# Change Run-User
RUN groupadd -g ${YOUR_GID} user
RUN useradd -m -s /bin/bash -N -u ${YOUR_UID} -g ${YOUR_GID} user
USER user
WORKDIR /home/user

# Copy Config to Container
COPY config.yaml /home/user/.config/code-server/config.yaml