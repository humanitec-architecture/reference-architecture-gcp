terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
}

provider "humanitec" {
  org_id = var.humanitec_org_id
}



module "base" {
  source           = "./modules/base"
  project_id       = var.project_id
  region           = var.region
  humanitec_org_id = var.humanitec_org_id
  humanitec_prefix = var.humanitec_prefix
  environment      = var.environment
  environment_type = var.environment_type
}
