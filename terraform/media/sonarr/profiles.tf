resource "sonarr_delay_profile" "main" {
  bypass_if_above_custom_format_score  = true
  bypass_if_highest_quality            = false
  enable_torrent                       = true
  enable_usenet                        = true
  minimum_custom_format_score          = 1600
  preferred_protocol                   = "torrent"
  tags                                 = []
  torrent_delay                        = 120
  usenet_delay                         = 0
}

