## GCP Regional Internal Load Balancer + Managed Instance Group

This project deploys a regional Managed Instance Group (MIG) attached to a regional Internal TCP load balancer on Google Cloud Platform using Terraform.

Files:
- `main.tf` - Terraform resources
- `variables.tf` - Terraform variables
- `outputs.tf` - Terraform outputs
- `versions.tf` - Terraform provider versions
- `terraform.tfvars` - Example variable values (edit `project`)
- `scripts/setup.sh` - Enables required GCP APIs and checks auth
- `scripts/deploy.sh` - Runs `terraform init` and `terraform apply`
- `scripts/destroy.sh` - Runs `terraform destroy`

Quick start

1. Install `gcloud` and `terraform` and authenticate:

```bash
# Authenticate with gcloud
gcloud auth login
gcloud auth application-default login

# Set project
gcloud config set project YOUR_PROJECT_ID
```

2. Enable required APIs (the helper script will do this):

```bash
cd gcp-terraform/scripts
./setup.sh YOUR_PROJECT_ID
```

3. Initialize and apply Terraform:

```bash
cd ../
./scripts/deploy.sh
```

4. When finished, destroy resources:

```bash
./scripts/destroy.sh
```

Notes
- The scripts assume you have `gcloud` configured and the active account has privileges to create resources.
- Edit `terraform.tfvars` or set environment variables to override defaults.
