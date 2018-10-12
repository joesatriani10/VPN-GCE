#!/bin/bash

if [ $# -eq 2 ]; then
 ansible-playbook users.yml -e "server=$1 ca_password=$2" -t update-users
else
 echo "====Es necesaria la IP y la contraseña CA como primer y segundo argumento===="
 echo "Uso: sh update-users.sh IP CA_PASS"
 echo "Ejemplo:sh update-users.sh 0.0.0.0 contraseña_ca"
fi
