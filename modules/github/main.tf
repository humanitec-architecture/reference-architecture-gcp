locals {
  cloud_provider = "gcp"

  repository_host = "${var.gar_repository_region}-docker.pkg.dev"
  repository_name = "${local.repository_host}/${var.project_id}/${var.gar_repository_id}"
}

# Configure GitHub variables & secrets for all scaffolded apps

resource "github_actions_organization_variable" "backstage_cloud_provider" {
  variable_name = "CLOUD_PROVIDER"
  visibility    = "all"
  value         = local.cloud_provider
}

resource "github_actions_organization_variable" "backstage_gcp_workload_identity_provider" {
  variable_name = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  visibility    = "all"
  value         = module.gh_oidc.provider_name
}

resource "github_actions_organization_variable" "backstage_gcp_service_account" {
  variable_name = "GCP_SERVICE_ACCOUNT"
  visibility    = "all"
  value         = google_service_account.sa.email
}


resource "github_actions_organization_variable" "backstage_gcp_gar_host" {
  variable_name = "GCP_GAR_HOST"
  visibility    = "all"
  value         = local.repository_host
}


resource "github_actions_organization_variable" "backstage_gcp_gar_name" {
  variable_name = "GCP_GAR_NAME"
  visibility    = "all"
  value         = local.repository_name
}


resource "github_actions_organization_variable" "backstage_humanitec_org_id" {
  variable_name = "HUMANITEC_ORG_ID"
  visibility    = "all"
  value         = var.humanitec_org_id
}

resource "github_actions_organization_secret" "backstage_humanitec_token" {
  secret_name     = "HUMANITEC_TOKEN"
  visibility      = "all"
  plaintext_value = var.humanitec_ci_service_user_token
}
