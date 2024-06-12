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
