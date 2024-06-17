terraform {
  required_providers {
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
  }
  required_version = ">= 1.3.0"
}
