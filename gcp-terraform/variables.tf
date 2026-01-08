variable "project" {
  type        = string
  description = "GCP project id"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone used for instance templates"
  default     = "us-central1-a"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "image" {
  type    = string
  default = "projects/debian-cloud/global/images/family/debian-11"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "target_size" {
  type    = number
  default = 2
}
