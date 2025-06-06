resource "google_compute_subnetwork" "private-test" {
  for_each = var.prefix
  name          = "private-${each.key}"
  ip_cidr_range = each.value["cidr"]
  region        = var.region
  network       = google_compute_network.private_network.id
  private_ip_google_access = "true"
}

resource "google_compute_subnetwork" "public-test" {
  for_each = var.public
  name          = "public-${each.key}"
  ip_cidr_range = each.value["cidr"]
  region        = var.region
  network       = google_compute_network.private_network.id
}

