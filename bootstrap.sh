#!/bin/bash

#update & upgrade
sudo apt update && sudo apt upgrade -y

#install ansible and git
sudo apt install ansible -y
sudo apt install git -y

#clone ansible playbook
git clone https://github.com/bertanoniempje/vpn.git $HOME/vpn

#run playbook
cd $HOME/vpn && ansible-playbook --ask-vault-pass playbook.yml
