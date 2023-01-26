## Database instance
resource "google_sql_database_instance" "master" {
  name                = "sql-database-instance"
  database_version    = "SQLSERVER_2019_ENTERPRISE"
  region              = var.region
  root_password       = var.root_password
  deletion_protection = "false"
  settings {
    tier      = var.tier
    disk_size = "100"
  }

}

## Database
resource "google_sql_database" "database" {
  name     = "mydatabase"
  instance = google_sql_database_instance.master.name
  # charset = "utf8"
  # collation = "utf8_general_ci"
}

## User
resource "google_sql_user" "users" {
  name     = var.db_username
  instance = google_sql_database_instance.master.name

  # host = "%"
  password = var.db_password
}