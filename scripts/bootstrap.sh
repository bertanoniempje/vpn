#!/bin/bash

# Update & upgrade
sudo apt update -y

# Install Ansible and Git
sudo apt install ansible -y
sudo apt install git -y

# Clone the Ansible playbook
git clone https://github.com/bertanoniempje/vpn.git $HOME/vpn

# Run the script to get the IP addresses
cd $HOME/vpn/scripts && ./get_ips.sh

# Navigate to the vpn directory
cd $HOME/vpn

# Export environment variables for Ansible
export RPI_IP=$RPI_IP
export RPI_USER=$RPI_USER
export CLIENT_IP=$CLIENT_IP
export CLIENT_USER=$CLIENT_USER

# Run pre_tasks playbook
ansible-playbook -i scripts/dynamic_inventory.py playbooks/pre_tasks.yml

# Run playbook to install WireGuard on VPN server
ansible-playbook -i scripts/dynamic_inventory.py playbooks/install_wireguard.yml

# Run playbook to add new client to the VPN server
ansible-playbook -i scripts/dynamic_inventory.py playbooks/add_client.yml -e "client_name=new_client"
