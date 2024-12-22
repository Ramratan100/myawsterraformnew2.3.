#!/bin/bash

cd "$(dirname "$0")"

output_bastion=$(terraform output -raw bastion_host_ip)
output_mysql_ip=$(terraform output -raw mysql_instance_ip)

if [ -z "$output_bastion" ] || [ -z "$output_mysql_ip" ]; then
  echo "Error: Terraform outputs are missing. Ensure Terraform has been applied."
  exit 1
fi

# Generate YAML inventory
cat <<EOF > ../ansible/inventory.yml
bastion:
  hosts:
    bastion_host:
      ansible_host: $output_bastion
      ansible_user: ubuntu

mysql:
  hosts:
    mysql_instance:
      ansible_host: $output_mysql_ip
      ansible_user: ubuntu
EOF

echo "Ansible inventory.yml has been successfully generated."
