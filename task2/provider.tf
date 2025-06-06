provider "google" {
  credentials = file("../../vpc/gcp-creds.json")
  project     = "anttech3"
  region      = "us-central1"
  zone        = "us-central1-b"
}

provider "google" {
  alias       = "gcp"
  credentials = file("../../vpc/gcp-creds.json")
  project     = "anttech3"
  region      = "us-west1"
  zone        = "us-west-a"
}