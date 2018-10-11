#!/bin/bash

if [ $# -eq 0 ]; then
echo "====Es necesario un nombre en minusculas como primer argumento===="
else
ansible-playbook main.yml -e "provider=gce
                                server_name=$1
                                ondemand_cellular=false
                                ondemand_wifi=false
                                local_dns=false
                                ssh_tunneling=false
                                windows=true
                                store_cakey=true
                                gce_credentials_file=/REEMPLAZAR.json
                                region=us-central1-b"
fi
