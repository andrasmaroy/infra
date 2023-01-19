locals {
  branch                = "main"
  cluster_name          = "home"
  flux_secrets          = sensitive(yamldecode(nonsensitive(data.sops_file.flux_secrets.raw)))
  kubeconfig            = "~/.kube/kubi.yaml"
  repository_name       = "infra"
  target_path           = "kubernetes/${local.cluster_name}/flux"
}
