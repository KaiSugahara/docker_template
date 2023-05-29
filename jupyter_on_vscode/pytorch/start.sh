#!/bin/bash -l

export SHELL=/bin/bash

# OpenSSHの起動
su -c '/usr/sbin/sshd' << EOF
password
EOF

# Jupyterの起動
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab --ip="0.0.0.0" --no-browser --port=8888 --ServerApp.password="" &
fi

# コンテナを起動し続る
tail -f /dev/null