terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "0.22.3"
    }
    github = {
      source  = "integrations/github"
      version = "5.14.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

data "sops_file" "flux_secrets" {
  source_file = "secrets.sops.yaml"
}

provider "flux" {}

provider "kubectl" {
  config_path = local.kubeconfig
}

provider "kubernetes" {
  config_path = local.kubeconfig
}

provider "github" {
  owner = local.flux_secrets.github_owner
  token = local.flux_secrets.github_token
}
