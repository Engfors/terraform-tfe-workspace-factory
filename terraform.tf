terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.26.1"
    }
  }
  required_version = ">= 1.0"
}
