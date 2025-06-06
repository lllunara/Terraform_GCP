variable "prefix" {
   type = map
   default = {
      sub-1 = {
         cidr = "10.0.1.0/24"
      }
      sub-2 = {
         cidr = "10.0.2.0/24"
      }
   }
}

variable "public" {
   type = map
   default = {
      subnet-1 = {
         cidr = "10.0.4.0/24"
      }
      subnet-2 = {
         cidr = "10.0.5.0/24"
      }
   }
}


variable "region" {
  default = "us-central1"
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}