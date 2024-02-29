resource "radarr_indexer_torznab" "main" {
  for_each = {
    for index, indexer in nonsensitive(local.secrets.indexers) :
    indexer.name => indexer
  }

  api_key                   = nonsensitive(local.secrets.jackett_api_key)
  base_url                  = each.value.url
  categories                = each.value.categories
  enable_automatic_search   = true
  enable_interactive_search = true
  enable_rss                = true
  download_client_id        = radarr_download_client_flood.main.id
  name                      = each.value.name
  priority                  = 25
}

resource "radarr_indexer_config" "main" {
  allow_hardcoded_subs       = false
  availability_delay         = 0
  maximum_size               = 0
  minimum_age                = 0
  prefer_indexer_flags       = false
  retention                  = 0
  rss_sync_interval          = 60
  whitelisted_hardcoded_subs = ""
}
