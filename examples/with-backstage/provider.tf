terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 0.13"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.38"
    }
  }
  required_version = ">= 1.3.0"
}

provider "humanitec" {
  org_id = var.humanitec_org_id
}

provider "github" {
  owner = var.github_org_id
}

provider "google" {
  project = var.project_id
}
