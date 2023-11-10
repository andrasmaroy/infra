terraform {
  required_version = ">= 1.3.9"
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}
