resource "radarr_media_management" "main" {
  auto_rename_folders                         = false
  auto_unmonitor_previously_downloaded_movies = false
  chmod_folder                                = 755
  chown_group                                 = ""
  copy_using_hardlinks                        = true
  create_empty_movie_folders                  = false
  delete_empty_folders                        = false
  download_propers_and_repacks                = "preferAndUpgrade"
  enable_media_info                           = true
  extra_file_extensions                       = "srt"
  file_date                                   = "none"
  import_extra_files                          = false
  minimum_free_space_when_importing           = 100
  paths_default_static                        = false
  recycle_bin                                 = ""
  recycle_bin_cleanup_days                    = 7
  rescan_after_refresh                        = "always"
  set_permissions_linux                       = false
  skip_free_space_check_when_importing        = false
}

resource "radarr_naming" "main" {
  colon_replacement_format   = "delete"
  include_quality            = false
  movie_folder_format        = "{Movie Title} ({Release Year})"
  rename_movies              = true
  replace_illegal_characters = true
  replace_spaces             = false
  standard_movie_format      = "{Movie Title} ({Release Year}) {Quality Full}"
}

resource "radarr_root_folder" "main" {
  path = "/media/Complete"
}
