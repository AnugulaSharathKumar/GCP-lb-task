#!/bin/bash
set -e
echo "Stage -1--"
echo "Downloading the Terraform dependencies"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/terraform_installation.sh
echo "========================================"
echo "Stage -2--"
echo "Downloading the GCP SDK dependencies"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/Installing_gcpsdk.sh

echo "========================================"
echo "Stage-3"
echo "Running the setup script for initializing the project"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/setup.sh


echo "========================================"
echo "Stage-4"
echo " Deploying the Terraform scripts"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scriptsdeploy.sh


echo "========================================"
echo "All stages completed successfully!"