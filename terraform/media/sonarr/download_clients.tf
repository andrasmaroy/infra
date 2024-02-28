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

resource "sonarr_download_client_torrent_blackhole" "main" {
  enable                     = true
  priority                   = 50
  name                       = "Tdarr Blackhole"
  magnet_file_extension      = ".magnet"
  save_magnet_files          = false
  read_only                  = false
  watch_folder               = "/media/Transcode/Blackhole"
  torrent_folder             = "/media/Transcode/"
  remove_completed_downloads = true
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
