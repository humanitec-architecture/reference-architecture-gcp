# GCP reference architecture

locals {
  repository_id   = "htc-ref-arch"
  repository_host = "${var.gar_repository_location}-docker.pkg.dev"
  repository_name = "${local.repository_host}/${var.project_id}/${local.repository_id}"
}

module "base" {
  source           = "../../modules/base"
  project_id       = var.project_id
  region           = var.region
  humanitec_org_id = var.humanitec_org_id
  humanitec_prefix = var.humanitec_prefix
  environment      = var.environment
  environment_type = var.environment_type

  gar_repository_id       = local.repository_id
  gar_repository_location = var.gar_repository_location
}
