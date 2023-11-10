output "EMQX_AUTHENTICATION__1__SERVER" {
  value = "${var.host}:${var.port}"
}

output "EMQX_AUTHENTICATION__1__DATABASE" {
  value = "emqx"
}

output "EMQX_AUTHENTICATION__1__USERNAME" {
  value = "emqx"
}

output "EMQX_AUTHENTICATION__1__PASSWORD" {
  value     = random_password.password.result
  sensitive = true
}

output "EMQX_AUTHORIZATION__SOURCES__1__SERVER" {
  value = "${var.host}:${var.port}"
}

output "EMQX_AUTHORIZATION__SOURCES__1__DATABASE" {
  value = "emqx"
}

output "EMQX_AUTHORIZATION__SOURCES__1__USERNAME" {
  value = "emqx"
}

output "EMQX_AUTHORIZATION__SOURCES__1__PASSWORD" {
  value     = random_password.password.result
  sensitive = true
}
