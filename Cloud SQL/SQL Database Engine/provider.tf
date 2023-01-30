provider "google" {
  credentials = file("user_creds.json")
  project     = "anttech3"
  region      = "us-east1"
  zone        = "us-east1-b"
}