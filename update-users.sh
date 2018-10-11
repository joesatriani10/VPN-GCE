#!/bin/bash

if [ $# -eq 0 ]; then
echo "====Es necesaria la contraseña CA como primer argumento===="
else
ansible-playbook users.yml -e "server=35.188.61.54 ca_password=$1" -t update-users
fi
