provider "postgresql" {
  host     = var.host
  port     = var.port
  username = var.username
  password = var.password
}

resource "random_password" "password" {
  length  = 64
  special = false
}

resource "postgresql_role" "vaultwarden" {
  name     = "vaultwarden"
  login    = true
  password = random_password.password.result
}

resource "postgresql_database" "vaultwarden" {
  name  = "vaultwarden"
  owner = "vaultwarden"

  depends_on = [
    postgresql_role.vaultwarden
  ]
}
