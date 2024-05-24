# VPN Setup using Ansible

This repository contains Ansible playbooks and scripts to set up a VPN server on a Raspberry Pi and connect clients to it. The setup uses WireGuard as the VPN solution.

## Prerequisites

- Raspberry Pi running a Debian-based OS
- Client machine (Windows, macOS, or Linux)
- SSH access to the Raspberry Pi and the client machine

## Installation

1. SSH into your Raspberry Pi.
2. Run the bootstrap script to set up the VPN server and add a client:

```sh
wget https://raw.githubusercontent.com/bertanoniempje/vpn/main/scripts/bootstrap.sh && bash bootstrap.sh
