## GCS 
resource "google_storage_bucket" "bucket" {
  count = 4
  name                     = "public-access-bucket-${count.index}"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}

## Google Compute Engine
resource "google_compute_instance" "jakyp" {
    name = "zhakyp2"
    for_each = local.names
    machine_type = lookup(each.value, "type", "e2-medium")

    boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
   network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}


## Locals
locals {
    names = {
        bir = {
            type = "f1-micro"
        },
        second = {
            type = "e2-small"
        }
    }
}



