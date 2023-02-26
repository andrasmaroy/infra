terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    radarr = {
      source  = "devopsarr/radarr"
      version = "1.8.0"
    }
  }
  required_version = "~> 1.3.0"
}

data "sops_file" "secrets" {
  source_file = "radarr/secrets.sops.yaml"
}

provider "radarr" {
  url     = local.secrets.url
  api_key = local.secrets.api_key
}
