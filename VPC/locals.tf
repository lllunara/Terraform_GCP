locals {
  internet       = "0.0.0.0/0"
  firewall_allow = [
    { protocol = "tcp", ports = ["80", "22"] },
    { protocol = "icmp" }
  ]
}