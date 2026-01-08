#!/bin/bash
set -e

echo "========================================"
echo "Stage -1"
echo "Downloading the Terraform dependencies"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/terraform_installation.sh

echo "========================================"
echo "Stage -2"
echo "Downloading the GCP SDK dependencies"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/Installing_gcpsdk.sh

echo "========================================"
echo "Stage -3"
echo "Running the setup script for initializing the project"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scripts/setup.sh

echo "========================================"
echo "Stage -4"
echo "Deploying the Terraform scripts"
echo "========================================"
./workspaces/GCP-lb-task/gcp-terraform/scriptsdeploy.sh

echo "========================================"
echo "⚠️  DESTROY CONFIRMATION REQUIRED"
echo "========================================"
read -r -p "Do you really want to DESTROY the infrastructure? (yes/no): " CONFIRM

case "$CONFIRM" in
  yes|YES|y|Y)
    echo "🔥 Permission granted. Destroying infrastructure..."
    cd ./workspaces/GCP-lb-task/gcp-terraform || exit 1
    terraform destroy -auto-approve
    ;;
  no|NO|n|N)
    echo "❌ Destroy skipped. Exiting safely."
    exit 0
    ;;
  *)
    echo "❌ Invalid input. Destroy skipped. Exiting."
    exit 1
    ;;
esac

echo "========================================"
echo "✅ Script execution completed successfully"
echo "========================================"