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
    'raspberry_pi': {
        'hosts': [rpi_ip],
        'vars': {
            'ansible_user': rpi_user
        }
    },
    'client': {
        'hosts': [client_ip],
        'vars': {
            'ansible_user': client_user
        }
    }
}

# Print the inventory as JSON
print(json.dumps(inventory))
