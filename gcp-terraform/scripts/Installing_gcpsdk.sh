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
    echo

    #######################################################################
    echo "Updating the system"
    sudo apt update -y
    sudo apt install -y apt-transport-https ca-certificates gnupg curl

    #######################################################################
    echo "Adding the Google Cloud GPG key"
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

    ##########################
