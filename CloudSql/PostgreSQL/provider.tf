provider "google" {
  credentials = file("creds.json")
  project     = "gcp-team-project"
  region      = var.region
  zone        = "us-east1-b"
}