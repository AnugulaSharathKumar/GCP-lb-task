#!/bin/bash
set -e

echo "=============================="
echo "Checking Terraform installation"
echo "=============================="

if command -v terraform >/dev/null 2>&1; then
    echo "✅ Terraform is already installed."
    terraform version
    exit 0
fi

echo "❌ Terraform not found. Installing Terraform..."
echo

###########################################################################
echo "Update system packages"
sudo apt update -y
sudo apt install -y gnupg software-properties-common curl

###########################################################################
echo "Add HashiCorp GPG key"
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

###########################################################################
echo "Add HashiCorp repository"
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

###########################################################################
echo "Install Terraform"
sudo apt update -y
sudo apt install terraform -y

###########################################################################
echo "Verify installation"
terraform version

echo "🎉 Terraform installation completed successfully."
