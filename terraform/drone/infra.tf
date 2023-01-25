locals {
  repository = "infra"
}

resource "drone_cron" "terraform_daily_plan" {
  repository = format("%s/%s", nonsensitive(local.secrets.owner), local.repository)
  name       = "terraform-daily-plan"
  expr       = "@daily"
  event      = "push"
  branch     = "main"
}

resource "drone_repo" "infra" {
  repository    = format("%s/%s", nonsensitive(local.secrets.owner), local.repository)
  visibility    = "private"
  trusted       = true
  ignore_forks  = true
  ignore_pulls  = true
  configuration = ".drone.yml"
}
