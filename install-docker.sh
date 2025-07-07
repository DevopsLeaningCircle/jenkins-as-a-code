#!/bin/bash

## OS: Ubuntu 22.04

# Update package lists
echo "Updating package lists..."
sudo apt update -y

# Install necessary packages for Docker repository
echo "Installing required packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository to APT sources
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again after adding the repository
echo "Updating package lists again..."
sudo apt update -y

# Install Docker Engine, containerd, and Docker Compose (CLI plugin)
echo "Installing Docker Engine and related components..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add the current user to the 'docker' group to run Docker without sudo
echo "Adding current user to the 'docker' group (requires re-login to take effect)..."
sudo usermod -aG docker "$USER"

echo "Docker installation complete. Please log out and log back in for group changes to take effect."
echo "You can verify the installation by running: docker run hello-world"