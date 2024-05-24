#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install -y wireguard
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install wireguard-tools
elif [[ "$OSTYPE" == "msys" ]]; then
    choco install wireguard
else
    echo "Unsupported OS"
    exit 1
fi
