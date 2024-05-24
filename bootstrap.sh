#!/bin/bash

#update & upgrade
sudo apt update -y

#install ansible and git
sudo apt install ansible -y
sudo apt install git -y

#clone ansible playbook
git clone https://github.com/bertanoniempje/vpn.git $HOME/vpn

#run pre_tasks playbook
cd $HOME/vpn && ansible-playbook ansible-playbook -i inventories/pi/hosts playbooks/pre_tasks.yml

#run playbook to install wireguard on vpn server
ansible-playbook ansible-playbook -i inventories/pi/hosts playbooks/install_wireguard.yml

#run playbook to add new client to the vpn server
ansible-playbook -i inventories/pi/hosts playbooks/add_client.yml

#run playbook to add Windows client
./setup_client.sh
