terraform {
  required_providers {
    humanitec = {
      source = "humanitec/humanitec"
    }
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
    # http = {
    #   source = "hashicorp/http"
    # }
  }
}

provider "helm" {
  kubernetes {
    host  = "https://${google_container_cluster.gke.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.gke.master_auth.0.cluster_ca_certificate
    )
  }
}
