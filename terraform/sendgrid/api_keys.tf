resource "sendgrid_api_key" "main" {
  for_each = toset(["Drone", "Uptime Kuma", "Alert Manager", "Vaultwarden", "Jellyfin", "Home Assistant", "Tdarr"])
  name     = each.key
  scopes = [
    "mail.send",
    "sender_verification_eligible",
    "2fa_required"
  ]
}
