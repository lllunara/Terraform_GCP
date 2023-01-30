## VPC 
resource "google_compute_network" "private_network" {
  name = "private-network"
  auto_create_subnetworks = false
}

## Private ip address
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

## Private vpc connection
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

## Random id
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

## Database instance
resource "google_sql_database_instance" "instance" {
  name             = "private-instance-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = "POSTGRES_14"
  deletion_protection = false
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    disk_size         = "100"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.id
    }
  }
}
