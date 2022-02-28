#!/bin/bash -l

# Jupyterの起動
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab &
fi

# コンテナを起動し続る
tail -f /dev/null