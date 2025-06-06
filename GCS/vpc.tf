## VPC
resource "google_compute_network" "vpc_network" {
  name = "vpc-network2"
  auto_create_subnetworks = false
} 

## Subnets
resource "google_compute_subnetwork" "custom-test" {
  for_each = var.prefix
  name          = "zhakyp-${each.key}"
  ip_cidr_range = each.value["cidr"]
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = "true"
}
