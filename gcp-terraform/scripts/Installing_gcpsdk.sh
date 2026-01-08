#!/bin/bash
set -e

echo "========================================"
echo "Checking Google Cloud SDK installation"
echo "========================================"

if command -v gcloud >/dev/null 2>&1; then
    echo "✅ Google Cloud SDK is already installed."
    gcloud version
else
    echo "❌ Google Cloud SDK not found. Installing..."
    #######################################################################
echo " Updating the system"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates gnupg curl

###########################################################################
echo "Adding the Google Cloud GPG key"
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

###########################################################################
echo "adding the Google Cloud SDK repository"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] \
https://packages.cloud.google.com/apt cloud-sdk main" | \
sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list


###########################################################################
echo "Installing the gcloud in codespace"
sudo apt update
sudo apt install -y google-cloud-cli

###########################################################################
echo "Verifying the gcp is installed or not"
gcloud version

###########################################################################
echo "Enabling the application default credentials"
gcloud auth application-default login

echo "Checking the adc is ready or not"
ls ~/.config/gcloud/application_default_credentials.json

    echo "✅ Google Cloud SDK installation completed."
fi
