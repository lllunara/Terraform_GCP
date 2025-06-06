locals {
  internet       = "0.0.0.0/0"
  private-subnet = "10.0.0.0/24"
  public-subnet  = "10.1.0.0/24"
  name           = "lunara"
  firewall_allow = [
    { protocol = "tcp", ports = ["80", "22"] },
    { protocol = "icmp" }
  ]
}