# GCP reference architecture

module "base" {
  source           = "./modules/base"
  project_id       = var.project_id
  region           = var.region
  humanitec_prefix = var.humanitec_prefix
  humanitec_org_id = var.humanitec_org_id
  environment      = var.environment
  environment_type = var.environment_type

  gar_repository_id       = var.gar_repository_id
  gar_repository_location = var.gar_repository_location
}

# User used for scaffolding and deploying apps

resource "humanitec_user" "deployer" {
  count = var.with_backstage ? 1 : 0

  name = "deployer"
  role = "administrator"
  type = "service"
}

resource "humanitec_service_user_token" "deployer" {
  count = var.with_backstage ? 1 : 0

  id          = "deployer"
  user_id     = humanitec_user.deployer[0].id
  description = "Used by scaffolding and deploying"
}


module "github" {
  count = var.with_backstage ? 1 : 0

  source = "./modules/github"

  humanitec_org_id                = var.humanitec_org_id
  humanitec_ci_service_user_token = humanitec_service_user_token.deployer[0].token
  project_id                      = var.project_id
  github_org_id                   = var.github_org_id
  gar_repository_id               = var.gar_repository_id
  gar_repository_location         = var.gar_repository_location

  depends_on = [module.base]
}

# Configure GitHub variables & secrets for Backstage itself and for all scaffolded apps

locals {
  github_app_credentials_file = "github-app-credentials.json"
}

module "github_app" {
  count = var.with_backstage ? 1 : 0

  source = "github.com/humanitec-architecture/shared-terraform-modules?ref=v2024-06-12//modules/github-app"

  credentials_file = "${path.module}/${local.github_app_credentials_file}"
}

# Deploy Backstage as Portal

module "portal_backstage" {
  count = var.with_backstage ? 1 : 0

  source = "./modules/portal-backstage"

  humanitec_org_id                = var.humanitec_org_id
  humanitec_ci_service_user_token = humanitec_service_user_token.deployer[0].token

  github_org_id            = var.github_org_id
  github_app_client_id     = module.github_app[0].client_id
  github_app_client_secret = module.github_app[0].client_secret
  github_app_id            = module.github_app[0].app_id
  github_app_private_key   = module.github_app[0].private_key
  github_webhook_secret    = module.github_app[0].webhook_secret

  depends_on = [module.github]
}
