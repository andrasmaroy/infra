terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.7"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
  required_version = "~> 1.3.0"
}

provider "tailscale" {
  oauth_client_id     = local.secrets.oauth_client_id
  oauth_client_secret = local.secrets.oauth_client_secret
  tailnet             = local.secrets.tailnet
}

data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}
