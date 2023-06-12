resource "sonarr_delay_profile" "main" {
  enable_usenet             = true
  enable_torrent            = true
  bypass_if_highest_quality = true
  usenet_delay              = 0
  torrent_delay             = 120
  tags                      = []
  preferred_protocol        = "torrent"
}

