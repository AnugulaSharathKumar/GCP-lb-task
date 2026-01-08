#!/bin/bash
set -e

approve_and_run() {
    STAGE_NAME="$1"
    SCRIPT_PATH="$2"

    echo "========================================"
    echo "Stage: $STAGE_NAME"
    echo "Script: $SCRIPT_PATH"
    echo "========================================"

    read -r -p "Do you want to execute this step? (yes/no): " CONFIRM

    case "$CONFIRM" in
        yes|YES|y|Y)
            echo "✅ Executing $STAGE_NAME..."
            bash "$SCRIPT_PATH"
            ;;
        no|NO|n|N)
            echo "⏭️  Skipping $STAGE_NAME"
            ;;
        *)
            echo "❌ Invalid input. Skipping $STAGE_NAME"
            ;;
    esac
}

########################################
# Stage -1 : Terraform Installation
########################################
approve_and_run \
"Terraform Installation" \
"./workspaces/GCP-lb-task/gcp-terraform/scripts/terraform_installation.sh"

########################################
# Stage -2 : GCP SDK Installation
########################################
approve_and_run \
"GCP SDK Installation" \
"./workspaces/GCP-lb-task/gcp-terraform/scripts/Installing_gcpsdk.sh"

########################################
# Stage -3 : Project Setup
########################################
approve_and_run \
"Project Setup" \
"./workspaces/GCP-lb-task/gcp-terraform/scripts/setup.sh"

########################################
# Stage -4 : Terraform Deploy
########################################
approve_and_run \
"Terraform Deployment" \
"./workspaces/GCP-lb-task/gcp-terraform/scriptsdeploy.sh"

########################################
# Stage -5 : Terraform Destroy (Extra Safe)
########################################
echo "========================================"
echo "⚠️  DESTROY STAGE (High Risk)"
echo "========================================"

read -r -p "Do you REALLY want to destroy infrastructure? Type YES to continue: " DESTROY_CONFIRM

if [[ "$DESTROY_CONFIRM" == "YES" ]]; then
    echo "🔥 Destroy confirmed"
    cd ./workspaces/GCP-lb-task/gcp-terraform || exit 1
    terraform destroy -auto-approve
else
    echo "❌ Destroy skipped"
fi

echo "========================================"
echo "🎉 All approved stages completed safely"
echo "========================================"