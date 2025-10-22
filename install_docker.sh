#!/bin/bash
# install_docker.sh - Install Docker on Linux

echo "Updating system packages..."
sudo apt update -y || sudo yum update -y

echo "Installing Docker..."
sudo apt install docker.io -y || sudo yum install docker -y

echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation completed successfully!"
docker --version
