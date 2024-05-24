#!/usr/bin/env python3

import os
import json

# Get environment variables
rpi_ip = os.getenv('RPI_IP')
rpi_user = os.getenv('RPI_USER')
client_ip = os.getenv('CLIENT_IP')
client_user = os.getenv('CLIENT_USER')

# Construct inventory dictionary
inventory = {
    'all': {
        'hosts': [],
        'children': {
            'raspberry_pi': {
                'hosts': [],
                'vars': {
                    'ansible_user': rpi_user
                }
            },
            'client': {
                'hosts': [],
                'vars': {
                    'ansible_user': client_user
                }
            }
        }
    }
}

# Add Raspberry Pi and client IP addresses to the inventory
if rpi_ip:
    inventory['all']['hosts'].append(rpi_ip)
    inventory['all']['children']['raspberry_pi']['hosts'].append(rpi_ip)

if client_ip:
    inventory['all']['hosts'].append(client_ip)
    inventory['all']['children']['client']['hosts'].append(client_ip)

# Print the inventory as JSON
print(json.dumps(inventory))
