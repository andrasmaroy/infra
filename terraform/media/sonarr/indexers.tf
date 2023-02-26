resource "sonarr_indexer_torznab" "main" {
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
  name                      = each.value.name
  priority                  = 25
}

resource "sonarr_indexer_config" "main" {
  maximum_size      = 0
  minimum_age       = 0
  retention         = 0
  rss_sync_interval = 15
}
