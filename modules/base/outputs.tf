output "gar_repository_id" {
  description = "Google Artifact Registry repository id (if created)."
  value       = module.k8s.gar_repository_id
}
