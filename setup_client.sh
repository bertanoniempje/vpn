#!/bin/bash

# Function to prompt for and read input
read_input() {
    local prompt="$1"
    local input_var
    read -p "$prompt: " input_var
    echo "$input_var"
}

# Function to encrypt a string
encrypt_string() {
    local plain_text="$1"
    echo "$plain_text" | openssl enc -aes-256-cbc -a -salt
}

# Detect the client's IP address
client_ip=$(hostname -I | awk '{print $1}')

# Prompt the user for their OS type
client_os=$(read_input "Enter the client OS (windows/macos)")

# Prompt the user for their username and password
user=$(read_input "Enter the username for the $client_os client")
password=$(read_input "Enter the password for the $client_os client")

# Encrypt the username and password
encrypted_user=$(encrypt_string "$user")
encrypted_password=$(encrypt_string "$password")

# Determine the appropriate inventory file and update it
inventory_file=""
if [ "$client_os" == "windows" ]; then
    inventory_file="inventories/windows/hosts"
elif [ "$client_os" == "macos" ]; then
    inventory_file="inventories/macos/hosts"
else
    echo "Unsupported OS type. Please enter 'windows' or 'macos'."
    exit 1
fi

# Backup the existing inventory file
cp "$inventory_file" "$inventory_file.bak"

# Update the inventory file with the client details
cat <<EOL > "$inventory_file"
[$client_os_clients]
$client_os_client ansible_host=$client_ip ansible_user=$(openssl enc -d -aes-256-cbc -a <<<"$encrypted_user") ansible_password=$(openssl enc -d -aes-256-cbc -a <<<"$encrypted_password") ansible_connection=${client_os}_connection ansible_become=true ansible_become_method=sudo
EOL

# Confirm the update
echo "Updated $inventory_file with the following details:"
echo "IP Address: $client_ip"
echo "Username: $(openssl enc -d -aes-256-cbc -a <<<"$encrypted_user")"
echo "Password: [hidden]"
