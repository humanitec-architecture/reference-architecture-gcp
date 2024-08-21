
resource "google_artifact_registry_repository" "repo" {
  count = var.gar_repository_id == null ? 0 : 1

  location      = var.gar_repository_region
  repository_id = var.gar_repository_id
  description   = "htc-ref-arch docker repository"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "gar_containers_reader" {
  count = var.gar_repository_id == null ? 0 : 1

  location   = google_artifact_registry_repository.repo[count.index].location
  repository = google_artifact_registry_repository.repo[count.index].id
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.gke_nodes.email}"
}
