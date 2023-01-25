resource "drone_orgsecret" "email_address" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "email_address"
  value                      = local.secrets.email_address
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}

resource "drone_orgsecret" "email_from" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "email_from"
  value                      = local.secrets.email_from
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}

resource "drone_orgsecret" "kubi" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "kubi"
  value                      = local.secrets.kubi
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}

resource "drone_orgsecret" "sendgrid_apikey" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "sendgrid_apikey"
  value                      = local.secrets.sendgrid_apikey
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}

resource "drone_orgsecret" "sops" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "sops"
  value                      = local.secrets.sops_gpg_key
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}

resource "drone_orgsecret" "terraform_cloud_token" {
  namespace                  = nonsensitive(local.secrets.owner)
  name                       = "terraform_cloud_token"
  value                      = local.secrets.terraform_cloud_token
  allow_on_pull_request      = false
  allow_push_on_pull_request = false
}
