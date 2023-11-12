variable "username" {
  type    = string
  default = "terraform"
}

variable "password" {
  type      = string
  sensitive = true
}

variable "host" {
  type    = string
  default = "core-db-rw.cnpg-system"
}

variable "port" {
  type    = number
  default = 5432
}
