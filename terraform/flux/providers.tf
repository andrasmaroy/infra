terraform {
  required_providers {
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "2.2.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.2.3"
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
  required_version = "~> 1.3.0"
}

data "external" "vault_pass" {
  program = ["bash", "-c", "ansible-vault-pass | jq -R -c '{\"pass\": .}'"]
}

provider "ansiblevault" {
  vault_pass  = data.external.vault_pass.result.pass
  root_folder = "."
}

data "ansiblevault_path" "flux_secrets" {
  path = "secrets.yaml"
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
