resource "sonarr_notification_webhook" "main" {
  method = 1
  name   = "Jelly"
  url    = nonsensitive(local.secrets.jellyfin_url)

  on_download                        = true
  on_episode_file_delete             = true
  on_episode_file_delete_for_upgrade = true
  on_grab                            = true
  on_series_delete                   = true
  on_upgrade                         = true
}

resource "sonarr_notification_custom_script" "tdarr" {
  name = "Tdarr"
  path = "/sonarr/tdarr_connect.sh"

  on_download = true
  on_upgrade  = true
}
