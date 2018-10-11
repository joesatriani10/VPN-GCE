#!/bin/bash

if [ $# -eq 0 ]; then
echo "====Es necesaria la IP y la contraseña CA como primer y segundo argumento===="
echo "====Ejemplo: update-users.sh 0.0.0.0 contraseña_ca===="
else
ansible-playbook users.yml -e "server=$1 ca_password=$2" -t update-users
fi
