provider "google" {
  credentials = file("creds.json")
  project     = "anttech3"
  region      = var.region
  zone        = "us-east1-b"
}