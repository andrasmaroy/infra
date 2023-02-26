resource "sonarr_media_management" "main" {
  chmod_folder                = "755"
  chown_group                 = ""
  create_empty_folders        = false
  delete_empty_folders        = false
  download_propers_repacks    = "preferAndUpgrade"
  enable_media_info           = true
  episode_title_required      = "always"
  extra_file_extensions       = "srt"
  file_date                   = "none"
  hardlinks_copy              = true
  import_extra_files          = false
  minimum_free_space          = 100
  recycle_bin_days            = 7
  recycle_bin_path            = ""
  rescan_after_refresh        = "always"
  set_permissions             = false
  skip_free_space_check       = false
  unmonitor_previous_episodes = false
}

resource "sonarr_naming" "main" {
  anime_episode_format       = "{Series Title} - S{season:00}E{episode:00} - {Episode Title} - {Quality Full}"
  daily_episode_format       = "{Series Title} - {Air-Date} - {Episode Title} - {Quality Full}"
  multi_episode_style        = 5
  rename_episodes            = true
  replace_illegal_characters = true
  season_folder_format       = "Season {season:00}"
  series_folder_format       = "{Series Title}"
  specials_folder_format     = "Specials"
  standard_episode_format    = "{Series Title} - S{season:00}E{episode:00} - {Episode Title} - {Quality Full}"
}

resource "sonarr_root_folder" "main" {
  path = "/media/Complete"
}
