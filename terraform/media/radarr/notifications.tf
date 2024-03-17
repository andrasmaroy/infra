resource "radarr_notification_webhook" "main" {
  method = 1
  name   = "Jelly"
  url    = nonsensitive(local.secrets.jellyfin_url)

  on_download                      = true
  on_grab                          = true
  on_movie_delete                  = true
  on_movie_file_delete             = true
  on_movie_file_delete_for_upgrade = true
  on_rename                        = true
  on_upgrade                       = true
}

resource "radarr_notification_custom_script" "tdarr" {
  name = "Tdarr"
  path = "/radarr/tdarr_connect.sh"

  on_download     = true
  on_movie_delete = false
  on_upgrade      = true
}
