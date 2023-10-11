# Configure GitHub variables & secrets for Backstage itself and for all scaffolded apps

locals {
  github_app_credentials_file = "github-app-credentials.json"
  github_app_credentials      = jsondecode(file("${path.module}/${local.github_app_credentials_file}"))
  github_app_id               = local.github_app_credentials["appId"]
  github_app_client_id        = local.github_app_credentials["clientId"]
  github_app_client_secret    = local.github_app_credentials["clientSecret"]
  github_app_private_key      = local.github_app_credentials["privateKey"]
  github_webhook_secret       = local.github_app_credentials["webhookSecret"]
}

locals {
  backstage_repo = "backstage"
}

resource "github_actions_organization_variable" "backstage_cloud_provider" {
  variable_name = "CLOUD_PROVIDER"
  visibility    = "all"
  value         = "gcp"
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

# Backstage repository itself

resource "github_repository" "backstage" {
  name        = local.backstage_repo
  description = "Backstage"

  visibility = "public"

  template {
    owner      = "humanitec-architecture"
    repository = "backstage"
  }

  depends_on = [
    module.base,
    module.gh_oidc,
    humanitec_application.backstage,
    humanitec_resource_definition_criteria.backstage_postgres,
    github_actions_organization_secret.backstage_humanitec_token,
  ]
}
