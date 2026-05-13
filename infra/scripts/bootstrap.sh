#!/bin/bash
# User Data script to install AWS CLI, unzip, and kubectl
# This script is designed for Amazon Linux, CentOS, RHEL, Ubuntu, or Debian.

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting bootstrap script..."

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# 1. Install unzip and curl
echo "Installing dependencies (unzip, curl)..."
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get update -y
    sudo apt-get install -y unzip curl
elif [ "$OS" = "amzn" ] || [ "$OS" = "centos" ] || [ "$OS" = "rhel" ]; then
    sudo yum update -y
    sudo yum install -y unzip curl
else
    echo "Unsupported OS ($OS). Trying to proceed anyway..."
fi

# 2. Install AWS CLI v2
echo "Installing AWS CLI v2..."
cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install --update
rm -rf awscliv2.zip aws/

# 3. Install kubectl
echo "Installing kubectl..."
# Fetch the latest stable version of kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Make the kubectl binary executable
chmod +x ./kubectl

# Move the binary in to your PATH
sudo mv ./kubectl /usr/local/bin/kubectl

# 4. Verify installations
echo "Verification:"
echo "-----------------------------------"
aws --version
echo "-----------------------------------"
kubectl version --client
echo "-----------------------------------"
echo "Bootstrap completed successfully!"
