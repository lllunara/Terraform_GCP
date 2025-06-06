variable "region" {
  type    = string
  default = "us-east1"

}

variable "root_password" {
  type    = string
  default = "mypassword"
}

variable "tier" {
  type    = string
  default = "db-custom-12-61440"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "project_id" {
  type    = string
  default = "anttech3"
}