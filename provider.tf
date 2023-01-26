provider "google" {
  # Configuration options
  credentials = file("credentials.json")
  project     = "anttech-373808"
  region      = "us-west1"
}