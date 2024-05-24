#!/usr/bin/env python3

import os
import json

# Get the client IP address from the environment variable
client_ip = os.getenv('CLIENT_IP')

# Define the inventory dictionary
inventory = {
    '_meta': {
        'hostvars': {}
    },
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

# Add Raspberry Pi and client machine to hosts
if client_ip:
    inventory['_meta']['hostvars'][client_ip] = {'ansible_host': client_ip}
    inventory['all']['hosts'].append(client_ip)
    inventory['all']['children']['client']['hosts'].append(client_ip)

# Add Raspberry Pi to hosts
inventory['_meta']['hostvars'][os.getenv('RPI_IP')] = {'ansible_host': os.getenv('RPI_IP')}
inventory['all']['hosts'].append(os.getenv('RPI_IP'))
inventory['all']['children']['raspberry_pi']['hosts'].append(os.getenv('RPI_IP'))

# Print the inventory as JSON
print(json.dumps(inventory))
