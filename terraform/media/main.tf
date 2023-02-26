terraform {
  required_version = "~> 1.3.0"
}

module "sonarr" {
  source = "./sonarr"
}

module "radarr" {
  source = "./radarr"
}
