output "gar_repository_id" {
  description = "Google Artifact Registry repository id (if created)."
  value       = module.k8s.gar_repository_id
}

output "gke_endpoint" {
  description = "GKE cluster endpoint."
  value       = module.k8s.cluster_endpoint
}

output "gke_ca_certificate" {
  description = "GKE cluster CA certificate."
  value       = module.k8s.cluster_ca_certificate
}
