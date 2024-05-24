#!/usr/bin/env python3

import os
import json

# Get the client IP address from the environment variable
client_ip = os.getenv('CLIENT_IP')

# Define the inventory dictionary
inventory = {
    'all': {
        'hosts': [],
        'children': {
            'raspberry_pi': {
                'hosts': [],
                'vars': {
                    'ansible_user': os.getenv('RPI_USER')
                }
            },
            'client': {
                'hosts': [],
                'vars': {
                    'ansible_user': os.getenv('CLIENT_USER')
                }
            }
        }
    }
}

# Add Raspberry Pi to inventory
rpi_ip = os.getenv('RPI_IP')
if rpi_ip:
    inventory['all']['hosts'].append(rpi_ip)
    inventory['all']['children']['raspberry_pi']['hosts'].append(rpi_ip)

# Add client machine to inventory
if client_ip:
    inventory['all']['hosts'].append(client_ip)
    inventory['all']['children']['client']['hosts'].append(client_ip)

# Print the inventory as JSON
print(json.dumps(inventory))
