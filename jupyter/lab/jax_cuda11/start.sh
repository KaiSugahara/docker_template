#!/bin/bash -l

export SHELL=/bin/bash

# Jupyterの起動
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab --ip="0.0.0.0" --no-browser --port=8888
fi