resource "google_compute_firewall" "rules" {
  name        = "allow-http-my-firewall-rule"
  network     = google_compute_network.private_network.name
  description = "Creates firewall rule targeting tagged instances"

  dynamic "allow" {
    for_each = local.firewall_allow
    content {
      protocol = allow.value["protocol"]
      ports     = lookup(allow.value, "ports", null)
  }
  }
   source_ranges = [local.internet]
   target_tags = ["allow-http"]
}