#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v terraform >/dev/null 2>&1; then
  echo "terraform is required. Install from https://www.terraform.io/downloads.html"
  exit 1
fi

echo "Initializing Terraform..."
terraform init -upgrade

echo "Planning..."
terraform plan -out=tfplan

echo "Applying..."
terraform apply -input=false tfplan
