#!/bin/bash
set -e

########################################
# Stage -1 : Terraform Installation
########################################
echo "========================================"
echo "Stage -1 : Terraform Installation"
echo "========================================"
#bash ./terraform_installation.sh

########################################
# Stage -2 : GCP SDK Installation
########################################
echo "========================================"
echo "Stage -2 : GCP SDK Installation"
echo "========================================"
#bash ./Installing_gcpsdk.sh

########################################
# Stage -3 : Project Setup
########################################
echo "========================================"
echo "Stage -3 : Project Setup"
echo "========================================"
#gcloud auth login
#gcloud auth application-default login
#gcloud config set project project-3e800f45-77e7-454a-a2b
#bash ./setup.sh project-3e800f45-77e7-454a-a2b

########################################
# Stage -4 : Terraform Deploy
########################################
echo "========================================"
echo "Stage -4 : Terraform Deployment"
echo "========================================"
bash ./deploy.sh

########################################
# Stage -5 : Terraform Destroy (Permission Required)
########################################
echo "========================================"
echo "⚠️  STAGE -5 : TERRAFORM DESTROY (HIGH RISK)"
echo "========================================"

read -r -p "Do you REALLY want to destroy infrastructure? (YES/NO): " DESTROY_CONFIRM

if [[ "$DESTROY_CONFIRM" == "YES" ]]; then
    echo "🔥 Destroy confirmed. Proceeding..."
    bash ./destroy.sh
    echo "✅ Infrastructure destroyed successfully."
else
    echo "❌ Destroy cancelled. Exiting safely."
    exit 0
fi
echo "========================================"
