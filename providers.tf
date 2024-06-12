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
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
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

provider "kubernetes" {
  host                   = module.base.gke_endpoint
  cluster_ca_certificate = module.base.gke_ca_certificate

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.base.gke_endpoint
    cluster_ca_certificate = module.base.gke_ca_certificate

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}
