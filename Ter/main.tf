provider "google" {
  credentials = file("creds.json")
  project     = "anttech2"
  region      = "us-central1"
  zone        = "us-central1-b"
}

## VPC
resource "google_compute_network" "vpc_network" {
  name                    = "${local.name}-vpc-network"
  auto_create_subnetworks = false
}

## Subnets
resource "google_compute_subnetwork" "custom-test" {
  name                     = "${local.name}-private-subnet"
  ip_cidr_range            = local.private-subnet
  region                   = "us-central1"
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "custom-test1" {
  name          = "${local.name}-public-subnet2"
  ip_cidr_range = local.public-subnet
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}

## Instance Template
resource "google_compute_instance_template" "tpl" {
  name         = "${local.name}-template"
  machine_type = "e2-micro"

  tags = ["http"]

  instance_description = "this is the template for instance"

  disk {
    source_image = "debian-cloud/debian-11"

  }

  metadata_startup_script = file("boot.sh")

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.custom-test.id
    access_config {

    }
  }
}

## Health check
resource "google_compute_health_check" "autohealing" {
  name                = "${local.name}-autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2 # 50 seconds
  tcp_health_check {
    port = "80"
  }
}

## instance group
resource "google_compute_instance_group_manager" "test" {
  name               = "${local.name}-terraform-mig"
  description        = "Terraform test instance group"
  base_instance_name = "app"
  zone               = "us-central1-b"
  target_size        = "1"
  version {
    instance_template = google_compute_instance_template.tpl.id
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }


}

## autoscaler
resource "google_compute_autoscaler" "default" {
  name   = "${local.name}-my-autoscaler"
  target = google_compute_instance_group_manager.test.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}

## Firewall 
resource "google_compute_firewall" "rules" {
  name        = "${local.name}s-allow-http-my-firewall-rule"
  network     = google_compute_network.vpc_network.name
  description = "Creates firewall rule targeting tagged instances"

  dynamic "allow" {
    for_each = local.firewall_allow
    content {
      protocol = allow.value["protocol"]
      ports    = lookup(allow.value, "ports", null)
    }
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]
}

## Forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${local.name}-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# reserved IP address
resource "google_compute_global_address" "default" {
  name = "${local.name}-static-ip"
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name    = "${local.name}-target-http-proxy"
  url_map = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "${local.name}-url-map"
  default_service = google_compute_backend_service.default.id
}

# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                    = "${local.name}-backend-service"
  protocol                = "HTTP"
  port_name               = "my-port"
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = true
  custom_request_headers  = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  custom_response_headers = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks           = [google_compute_health_check.autohealing.id]
  backend {
    group           = google_compute_instance_group_manager.test.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

terraform {
  backend "gcs" {
    bucket      = "aktans-bucket-dont-touch"
    prefix      = "ter/"
    credentials = "../creds.json"
  }
}
