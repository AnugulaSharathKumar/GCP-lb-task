#!/bin/bash
set -e

########################################
# Stage -1 : Terraform Installation
########################################
echo "========================================"
echo "Stage -1 : Terraform Installation"
echo "========================================"
bash ./workspaces/GCP-lb-task/gcp-terraform/scripts/terraform_installation.sh

########################################
# Stage -2 : GCP SDK Installation
########################################
echo "========================================"
echo "Stage -2 : GCP SDK Installation"
echo "========================================"
bash ./workspaces/GCP-lb-task/gcp-terraform/scripts/Installing_gcpsdk.sh

########################################
# Stage -3 : Project Setup
########################################
echo "========================================"
echo "Stage -3 : Project Setup"
echo "========================================"
bash ./workspaces/GCP-lb-task/gcp-terraform/scripts/setup.sh

########################################
# Stage -4 : Terraform Deploy
########################################
echo "========================================"
echo "Stage -4 : Terraform Deployment"
echo "========================================"
bash ./workspaces/GCP-lb-task/gcp-terraform/scriptsdeploy.sh

########################################
# Stage -5 : Terraform Destroy (Permission Required)
########################################
echo "========================================"
echo "⚠️  STAGE -5 : TERRAFORM DESTROY (HIGH RISK)"
echo "========================================"

read -r -p "Do you REALLY want to destroy infrastructure? Type YES to continue: " DESTROY_CONFIRM

if [[ "$DESTROY_CONFIRM" == "YES" ]]; then
    echo "🔥 Destroy confirmed. Proceeding..."
    cd ./workspaces/GCP-lb-task/gcp-
