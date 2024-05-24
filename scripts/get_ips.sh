#!/bin/bash

# Get the Raspberry Pi IP address
RPI_IP=$(hostname -I | awk '{print $1}')
RPI_USER=$(whoami)

# Get the client IP address from the SSH connection
CLIENT_IP=$(echo $SSH_CLIENT | awk '{print $1}')
CLIENT_USER=$(who am i | awk '{print $1}')

# Export variables for use in the calling script
export RPI_IP
export RPI_USER
export CLIENT_IP
export CLIENT_USER

echo "Raspberry Pi IP: $RPI_IP"
echo "Raspberry Pi User: $RPI_USER"
echo "Client IP: $CLIENT_IP"
echo "Client User: $CLIENT_USER"