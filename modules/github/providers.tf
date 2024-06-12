terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.38"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  required_version = ">= 1.3.0"
}
