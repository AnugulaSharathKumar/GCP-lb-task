#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
  echo "Usage: $0 PROJECT_ID"
  exit 1
fi

PROJECT=$1

echo "Enabling required GCP APIs for project $PROJECT..."
gcloud config set project "$PROJECT"

gcloud services enable compute.googleapis.com --project="$PROJECT"
gcloud services enable iam.googleapis.com --project="$PROJECT"

echo "Ensure you have application default credentials set (gcloud auth application-default login) or a service account JSON in GOOGLE_APPLICATION_CREDENTIALS."

echo "Setup complete."
