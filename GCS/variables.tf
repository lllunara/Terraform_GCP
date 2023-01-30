variable "region" {
  type    = string
  default = "us-east1"
}


variable "google_service_account" {
  default = ["lunaraluna", "aktanataktan", "nurnurnur", "donleeeee"]
}


variable "prefix" {
   type = map
   default = {
      sub-1 = {
         cidr = "10.0.198.0/24"
      }
      sub-2 = {
         cidr = "10.0.199.0/24"
      }
      sub-3 = {
         cidr = "10.0.200.0/24"
      }
   }
}