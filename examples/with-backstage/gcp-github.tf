locals {
  service_account_name = "htc-ref-arch-gha-gar-push"
  name                 = "htc-ref-arch"
  cloud_provider       = "gcp"
}

# Create a role for GitHub Actions to push to GAR using OpenID Connect (OIDC) so we don't need to store GCP credentials in GitHub
# Reference https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-google-cloud-platform

# Source https://github.com/terraform-google-modules/terraform-google-github-actions-runners/tree/master/modules/gh-oidc
module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version     = "~> 3.1"
  project_id  = var.project_id
  pool_id     = "htc-ref-arch"
  provider_id = "htc-ref-arch"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      attribute = "attribute.repository_owner/${var.github_org_id}",
    }
  }
}

resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = local.service_account_name
}

# Reference https://cloud.google.com/artifact-registry/docs/access-control#roles
resource "google_artifact_registry_repository_iam_member" "gha_gar_containers_writer" {
  project    = var.project_id
  location   = var.gar_repository_location
  repository = module.base.gar_repository_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.sa.email}"
}
