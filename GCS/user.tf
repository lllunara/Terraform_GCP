# Create a GCP Service Account
resource "google_service_account" "user" {
  count = length(var.google_service_account)
  account_id = element(var.google_service_account, count.index)
  display_name = element(var.google_service_account, count.index)
  description  = "Service Account for App"
}
