locals {
  branch                = "main"
  cluster_name          = "home"
  flux_secrets          = sensitive(yamldecode(data.ansiblevault_path.flux_secrets.value))
  kubeconfig            = "~/.kube/kubi.yaml"
  repository_name       = "infra"
  target_path           = "kubernetes/${local.cluster_name}/flux"
}
