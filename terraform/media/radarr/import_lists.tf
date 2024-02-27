resource "radarr_import_list_trakt_list" "main" {
  access_token         = nonsensitive(local.secrets.trakt.access_token)
  auth_user            = nonsensitive(local.secrets.trakt.username)
  enable_auto          = true
  enabled              = true
  limit                = 100
  listname             = "Radarr"
  minimum_availability = "tba"
  monitor              = "movieOnly"
  name                 = "Trakt"
  quality_profile_id   = 7
  root_folder_path     = radarr_root_folder.main.path
  username             = nonsensitive(local.secrets.trakt.username)
}
