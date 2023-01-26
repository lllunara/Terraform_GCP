#Master Instance Postgres Engine
resource "google_sql_database_instance" "master_instance" {
  name             = "master-instance"
  database_version = "POSTGRES_14"
  region           = "us-west1"

  settings {
    tier                 = "db-custom-2-13312"
    disk_size    = 100
    disk_autoresize_limit  = 110
    disk_type = "PD_SSD" 
    location_preference {
      zone = "us-west1-a"
    }
  }
}
