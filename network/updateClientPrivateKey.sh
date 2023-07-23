#!/bin/bash

# Define the YAML file path
yaml_file="caliper-config.yaml"

# Define the directory containing the target file
directory="./crypto-config/peerOrganizations/manufacturer.medtrac-network.com/peers/peer0.manufacturer.medtrac-network.com/msp/keystore/"

# Get the absolute filename of the file in the directory
file_name=$(ls -1 "$directory")

# Generate the absolute file path
absolute_file_path="${directory}${file_name}"

# Update the YAML file with the new absolute file path
sed -i "s|path: '$directory.*'|path: '$absolute_file_path'|" "$yaml_file"

echo "Updated the YAML file with the new absolute file path: $absolute_file_path"
