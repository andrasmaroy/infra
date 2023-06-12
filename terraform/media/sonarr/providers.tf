terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "3.0.0"
    }
  }
  required_version = "~> 1.3.0"
}

data "sops_file" "secrets" {
  source_file = "sonarr/secrets.sops.yaml"
}

provider "sonarr" {
  url     = local.secrets.url
  api_key = local.secrets.api_key
}
