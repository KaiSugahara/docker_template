#!/bin/bash -l

export SHELL=/bin/bash

# Jupyterの起動
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab
fi