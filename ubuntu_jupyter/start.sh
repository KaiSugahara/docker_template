#!/bin/bash

export SHELL=/bin/bash

# バックアップファイルを復元
mv -n /backup/.[^\.]* $HOME/

export PATH=$HOME/.local/bin:$PATH

# Jupyterの起動
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab &
fi

# コンテナを起動し続る
tail -f /dev/null