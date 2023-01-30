terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
  backend "gcs" {
    bucket      = "terraformbucketlunara"
    prefix      = "terraform/"
    credentials = "../../vpc/gcp-creds.json"
  }
}