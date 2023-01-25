terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    sendgrid = {
      source  = "Trois-Six/sendgrid"
      version = "0.2.1"
    }
  }
  required_version = "~> 1.3.0"
}

data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

provider "sendgrid" {
  api_key = local.secrets.sendgrid_api_key
}
