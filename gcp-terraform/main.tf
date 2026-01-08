provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_http" {
  name    = "${var.project}-allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.0.0.0/8"]
  target_tags   = ["http-server"]
}

resource "google_compute_instance_template" "template" {
  name         = "${var.project}-template"
  machine_type = var.machine_type
  tags         = ["http-server"]

  disk {
    boot         = true
    auto_delete  = true
    source_image = var.image
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Hello from GCP MIG on $(hostname)" > /var/www/html/index.html
    systemctl enable --now nginx
  EOF
}

# ✅ Use a regional managed instance group (no need for vm1/vm2 or unmanaged group)
resource "google_compute_region_instance_group_manager" "mig" {
  name               = "${var.project}-mig"
  region             = var.region
  base_instance_name = "${var.project}-instance"
  target_size        = var.target_size

  version {
    instance_template = google_compute_instance_template.template.self_link
  }
}

resource "google_compute_health_check" "tcp_hc" {
  name = "${var.project}-tcp-hc"

  tcp_health_check {
    port = 80
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

resource "google_compute_region_backend_service" "backend" {
  name                  = "my-backend-service"
  region                = var.region
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"

  backend {
    group          = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode = "CONNECTION"
  }

  health_checks = [google_compute_health_check.tcp_hc.self_link]
}

resource "google_compute_address" "internal_ip" {
  name         = "${var.project}-ilb-ip"
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.subnet.self_link
  purpose      = "GCE_ENDPOINT"
}

resource "google_compute_forwarding_rule" "ilb" {
  name                  = "${var.project}-ilb"
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.self_link
  ip_protocol           = "TCP"
  ports                 = ["80"]
  ip_address            = google_compute_address.internal_ip.address
  network               = google_compute_network.vpc.self_link
  subnetwork            = google_compute_subnetwork.subnet.self_link
}
