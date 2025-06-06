resource "google_sql_database_instance" "read_replica" {
  name                 = "replica"
  master_instance_name = "${var.project_id}:${google_sql_database_instance.master.name}"
  region               = "us-west1"
  database_version     = "SQLSERVER_2019_ENTERPRISE"
  deletion_protection  = "false"
  replica_configuration {
    failover_target = false
  }
  settings {
    tier              = var.tier
    disk_size         = "100"
    availability_type = "ZONAL"
    backup_configuration {
      enabled = false
    }
    location_preference {
      zone = "us-west1-a"
    }
  }
}

