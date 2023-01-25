terraform {
  required_providers {
    drone = {
      source  = "mavimo/drone"
      version = "0.7.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
  required_version = "~> 1.3.0"
}

provider "drone" {
  server = local.secrets.drone_server
  token  = local.secrets.drone_token
}

data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}
