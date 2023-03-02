resource "sonarr_import_list_trakt_list" "main" {
  enable_automatic_add = true
  language_profile_id  = 1
  listname             = "Sonarr"
  name                 = "Trakt"
  quality_profile_id   = 4
  rating               = "0-100"
  root_folder_path     = sonarr_root_folder.main.path
  season_folder        = true
  series_type          = "standard"
  should_monitor       = "all"
  username             = nonsensitive(local.secrets.trakt_username)
}

resource "sonarr_import_list_trakt_list" "pilots" {
  enable_automatic_add = true
  language_profile_id  = 1
  listname             = "Sonarr pilots"
  name                 = "Trakt pilots"
  quality_profile_id   = 4
  rating               = "0-100"
  root_folder_path     = sonarr_root_folder.main.path
  season_folder        = true
  series_type          = "standard"
  should_monitor       = "pilot"
  username             = nonsensitive(local.secrets.trakt_username)
}