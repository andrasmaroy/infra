resource "sonarr_media_management" "main" {
  chmod_folder                = "755"
  chown_group                 = ""
  create_empty_folders        = false
  delete_empty_folders        = false
  download_propers_repacks    = "doNotPrefer"
  enable_media_info           = true
  episode_title_required      = "always"
  extra_file_extensions       = "srt"
  file_date                   = "none"
  hardlinks_copy              = true
  import_extra_files          = true
  minimum_free_space          = 100
  recycle_bin_days            = 7
  recycle_bin_path            = ""
  rescan_after_refresh        = "always"
  set_permissions             = false
  skip_free_space_check       = false
  unmonitor_previous_episodes = false
}

resource "sonarr_naming" "main" {
  anime_episode_format       = "{Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}[{MediaInfo VideoBitDepth}bit]{[MediaInfo VideoCodec]}[{Mediainfo AudioCodec} { Mediainfo AudioChannels}]{MediaInfo AudioLanguages}{-Release Group}"
  daily_episode_format       = "{Series TitleYear} - {Air-Date} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}"
  colon_replacement_format   = 0
  multi_episode_style        = 5
  rename_episodes            = true
  replace_illegal_characters = true
  season_folder_format       = "Season {season:00}"
  series_folder_format       = "{Series TitleYear}"
  specials_folder_format     = "Specials"
  standard_episode_format    = "{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}"
}

resource "sonarr_root_folder" "main" {
  path = "/media/Complete"
}
