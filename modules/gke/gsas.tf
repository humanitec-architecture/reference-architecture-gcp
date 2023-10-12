# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam

resource "google_service_account" "gke_nodes" {
  account_id  = "${var.cluster_name}-nodes-sa"
  description = "Account used by the GKE nodes"
}

resource "google_project_iam_member" "gke_nodes" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_service_account" "gke_cluster_access" {
  account_id  = var.cluster_name
  description = "Account used by Humanitec to access the GKE cluster"
}

resource "google_project_iam_member" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_cluster_access.email}"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_key#private_key
resource "google_service_account_key" "gke_cluster_access_key" {
  service_account_id = google_service_account.gke_cluster_access.name

  depends_on = [google_project_iam_member.gke_admin]
}
