terraform_version_constraint  = "~> 1.3.0"

generate "cloud" {
  path      = "tg_cloud.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  cloud {
    organization = "andrasmaroy"

    workspaces {
      name = "${path_relative_to_include()}"
    }
  }
  required_version = "~> 1.3.0"
}
EOF
}
