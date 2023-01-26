terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
  backend "gcs" {
    bucket      = "terraformzhakyp"
    prefix      = "terraform/cloudsql.tfstate"
    credentials = "user_creds.json"
  }
}