#  resource "google_sql_database_instance" "read_replica" {
#   name                 = "replica-${random_id.db_name_suffix.hex}"
#   master_instance_name = "${google_sql_database_instance.instance.name}"
#   region               = "europe-west4"
#   database_version     = "POSTGRES_14"
#   deletion_protection = false
#   replica_configuration {
#     failover_target = false
#   }

#   settings {
#     tier              = "db-f1-micro"
#     availability_type = "ZONAL"
#     disk_size         = "100"
#     backup_configuration {
#       enabled = false
#     }
#     ip_configuration {
#       ipv4_enabled    = true
#       private_network = google_compute_network.private_network.id
#     }
#     location_preference {
#       zone = "europe-west4-a"
#     }
#   }
# }