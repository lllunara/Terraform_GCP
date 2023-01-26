terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
  backend "gcs" {
    bucket      = "aktans-bucket-dont-touch"
    prefix      = "ter/"
    credentials = file("creds.json")
  }
}