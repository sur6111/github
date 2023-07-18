#!/bin/bash

# Get the current directory
current_dir=$(pwd)

echo "Adding key to all the peers in the Medtrac Network"

# Define the roles and their respective directories
declare -A roles=(
  ["manufacturer"]="manufacturer.medtrac-network.com"
  ["distributor"]="distributor.medtrac-network.com"
  ["transporter"]="transporter.medtrac-network.com"
  ["retailer"]="retailer.medtrac-network.com"
  ["consumer"]="consumer.medtrac-network.com"
)

# Function to construct and execute the cURL command
execute_curl_command() {
  local role=$1
  local role_dir="$current_dir/crypto-config/peerOrganizations/${roles[$role]}/users/Admin@${roles[$role]}/msp"
  
  # Find the private key file in the directory
  local private_key_file=$(find "$role_dir" -type f -name '*_sk' -printf "%f")
  
  # Check if a private key file was found
  if [[ -z "$private_key_file" ]]; then
    echo "Private key file not found in directory: $role_dir"
    exit 1
  fi
  
  # Construct the private key path
  local private_key_path="$role_dir/keystore/$private_key_file"
  
  # Construct the cURL command
  local curl_command="curl --location --request POST 'localhost:4000/addToWallet' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'certificatePath=$role_dir/signcerts/Admin@${roles[$role]}-cert.pem' \
--data-urlencode 'privateKeyPath=$private_key_path' \
--data-urlencode 'orgRole=$role'"
  
  echo "Adding Key To $role"

  # Execute the cURL command
  eval "$curl_command"
  echo
}

# Loop over each role and execute the cURL command
for role in "${!roles[@]}"; do
  execute_curl_command "$role"
done
echo
echo "Successfully added keys to all peers in the Medtrac Network"