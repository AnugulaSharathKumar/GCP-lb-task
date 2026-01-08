#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v terraform >/dev/null 2>&1; then
  echo "terraform is required. Install from https://www.terraform.io/downloads.html"
  exit 1
fi

echo "Destroying Terraform-managed resources..."
terraform destroy -auto-approve
