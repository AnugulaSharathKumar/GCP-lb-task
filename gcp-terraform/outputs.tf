output "ilb_ip" {
  description = "Internal LB IP address"
  value       = google_compute_address.internal_ip.address
}

output "mig_name" {
  description = "Managed Instance Group name"
  value       = google_compute_region_instance_group_manager.mig.name
}
