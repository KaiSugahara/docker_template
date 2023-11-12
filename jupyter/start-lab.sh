#!/bin/bash -l

export SHELL=/bin/bash

# Start Jupyter Lab Server
if type "jupyter" > /dev/null 2>&1; then
    jupyter lab --ip="0.0.0.0" --no-browser --port=${JUPYTER_PORT}
fi