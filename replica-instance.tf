#Read Replica for Master Instance Postgres Engine
resource "google_sql_database_instance" "read_replica" {
  name                 = "replica-for-master"
  master_instance_name = google_sql_database_instance.master_instance.name
  region               = "us-west1"
  database_version     = "POSTGRES_14"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-custom-2-13312"
    availability_type = "ZONAL"
    disk_size         = "110"
    backup_configuration {
      enabled = false
    }
    location_preference {
      zone = "us-west1-a"
    }
  }
}