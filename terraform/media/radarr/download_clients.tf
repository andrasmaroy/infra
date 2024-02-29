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

resource "radarr_download_client_torrent_blackhole" "main" {
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
