#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
  echo "Usage: $0 project-3e800f45-77e7-454a-a2b"
  exit 1
fi

PROJECT=$1

echo "Enabling required GCP APIs for project project-3e800f45-77e7-454a-a2b..."
gcloud config set project "project-3e800f45-77e7-454a-a2b"

gcloud services enable compute.googleapis.com --project="project-3e800f45-77e7-454a-a2b"
gcloud services enable iam.googleapis.com --project="project-3e800f45-77e7-454a-a2b"

echo "Ensure you have application default credentials set (gcloud auth application-default login) or a service account JSON in GOOGLE_APPLICATION_CREDENTIALS."

echo "Setup complete."
