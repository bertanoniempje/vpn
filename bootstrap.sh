#!/bin/bash

#update & upgrade
sudo apt update && sudo apt upgrade -y

#install ansible
sudo apt install ansible -y

#run playbook
cd $HOME/vpn && ansible-playbook --ask-vault-pass playbook.yml
