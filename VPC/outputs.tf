output "network_name" {
  value       = google_compute_network.private_network.name
  description = "The name of the VPC being created"
}

output "subnet" {
  value = { for k, i in google_compute_subnetwork.public-test : k => i.id}
}