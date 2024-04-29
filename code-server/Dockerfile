FROM ubuntu:latest

# Install code-server
RUN apt update -y
RUN apt install -y curl
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set CMD
CMD ["code-server"]

# Change Run-User
USER ubuntu
WORKDIR /home/ubuntu

# Copy Config to Container
COPY config.yaml /home/ubuntu/.config/code-server/config.yaml