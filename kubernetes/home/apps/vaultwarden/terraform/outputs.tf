output "database-url" {
  value    = "postgresql://vaultwarden:${random_password.password.result}@${var.host}:${var.port}/vaultwarden"
  sensitive = true
}
