resource "sonarr_delay_profile" "main" {
  bypass_if_above_custom_format_score = true
  bypass_if_highest_quality           = true
  enable_torrent                      = true
  enable_usenet                       = true
  minimum_custom_format_score         = 2600
  preferred_protocol                  = "torrent"
  tags                                = []
  torrent_delay                       = 120
  usenet_delay                        = 0
}

resource "sonarr_delay_profile" "DoVi" {
  bypass_if_above_custom_format_score = true
  bypass_if_highest_quality           = false
  enable_torrent                      = true
  enable_usenet                       = true
  minimum_custom_format_score         = 1500
  preferred_protocol                  = "torrent"
  tags                                = [sonarr_tag.DoVi.id]
  torrent_delay                       = 1440
  usenet_delay                        = 0
}

resource "sonarr_delay_profile" "DoViAtmos" {
  bypass_if_above_custom_format_score = true
  bypass_if_highest_quality           = false
  enable_torrent                      = true
  enable_usenet                       = true
  minimum_custom_format_score         = 2600
  preferred_protocol                  = "torrent"
  tags                                = [sonarr_tag.DoViAtmos.id]
  torrent_delay                       = 1440
  usenet_delay                        = 0
}
