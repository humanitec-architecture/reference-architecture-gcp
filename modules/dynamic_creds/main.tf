data "google_project" "project" {
  project_id = var.gcp_project_id
}

resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.gcp_workload_identity_pool_id
  display_name              = "Humanitec Identity Pool"
  description               = "Identity pool for platform orchiestration"
}

resource "google_iam_workload_identity_pool_provider" "pool_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.gcp_workload_identity_pool_provider_id
  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }
  oidc {
    issuer_uri = "https://idtoken.humanitec.io"
  }
}

resource "google_service_account" "service_account" {
  account_id   = var.gcp_service_account_id
  display_name = "Humanitec GCP dynamic cloud account"
  description  = "Used by Humanitec Platform Orchestrator Cloud Account"
}

resource "humanitec_resource_account" "cloud_account" {
  id   = "humanitec-gcp-dynamic-cloud-account"
  name = "Humanitec GCP dynamic cloud account"
  type = "gcp-identity"
  credentials = jsonencode({
    "gcp_service_account" = "${google_service_account.service_account.account_id}@${var.gcp_project_id}.iam.gserviceaccount.com"
    "gcp_audience"        = "//iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.pool.workload_identity_pool_id}/providers/${google_iam_workload_identity_pool_provider.pool_provider.workload_identity_pool_provider_id}"
  })
}

resource "google_service_account_iam_binding" "iam-binding" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/humanitec-wif-pool/subject/${var.humanitec_org}/${humanitec_resource_account.cloud_account.id}",
  ]
}

resource "google_project_iam_member" "cloud_account_container_role" {
  project = var.gcp_project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
