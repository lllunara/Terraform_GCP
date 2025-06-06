## Create VPC
resource "google_compute_network" "private_network" {
name = var.network_name
auto_create_subnetworks = var.auto_create_subnetworks
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}