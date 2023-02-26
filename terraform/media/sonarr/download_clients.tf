resource "sonarr_download_client_flood" "main" {
  host = "rtorrent-flood"
  name = "rTorrent"

  destination = "/downloads/shows/"
  enable      = true
  field_tags = [
    "shows"
  ]
  password                = nonsensitive(local.secrets.rtorrent.password)
  priority                = 1
  remove_failed_downloads = true
  username                = nonsensitive(local.secrets.rtorrent.username)
}

resource "sonarr_download_client_config" "main" {
  enable_completed_download_handling = true
  auto_redownload_failed             = true
}

resource "sonarr_remote_path_mapping" "main" {
  host        = "rtorrent-flood"
  remote_path = "/downloads/shows/"
  local_path  = "/media/Downloads/"
}
