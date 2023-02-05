output "drone_api_key" {
  value     = sendgrid_api_key.main["Drone"].api_key
  sensitive = true
}

output "uptime_kuma_api_key" {
  value     = sendgrid_api_key.main["Uptime Kuma"].api_key
  sensitive = true
}

output "alert_manager_api_key" {
  value     = sendgrid_api_key.main["Alert Manager"].api_key
  sensitive = true
}

output "vaultwarden_api_key" {
  value     = sendgrid_api_key.main["Vaultwarden"].api_key
  sensitive = true
}

output "jellyfin_api_key" {
  value     = sendgrid_api_key.main["Jellyfin"].api_key
  sensitive = true
}

output "home_assistant_api_key" {
  value     = sendgrid_api_key.main["Home Assistant"].api_key
  sensitive = true
}
