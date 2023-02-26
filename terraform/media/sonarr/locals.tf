locals {
  secrets = sensitive(yamldecode(nonsensitive(data.sops_file.secrets.raw)))
}
