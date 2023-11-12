#!/bin/bash -l

export SHELL=/bin/bash

# Start SSH Server
su -c "/usr/sbin/sshd -p ${JUPYTER_PORT}" << EOF
password
EOF

# Keep running container
tail -f /dev/null