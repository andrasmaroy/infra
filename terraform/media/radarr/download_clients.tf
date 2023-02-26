resource "radarr_download_client_flood" "main" {
  host = "rtorrent-flood"
  name = "rTorrent"

  destination = "/downloads/movies/"
  enable      = true
  field_tags = [
    "movies"
  ]
  password                = nonsensitive(local.secrets.rtorrent.password)
  priority                = 1
  remove_failed_downloads = true
  username                = nonsensitive(local.secrets.rtorrent.username)
}

resource "radarr_download_client_config" "main" {
  check_for_finished_download_interval = 1
  enable_completed_download_handling   = true
  auto_redownload_failed               = true
}

resource "radarr_remote_path_mapping" "main" {
  host        = "rtorrent-flood"
  remote_path = "/downloads/movies/"
  local_path  = "/media/Downloads/"
}
