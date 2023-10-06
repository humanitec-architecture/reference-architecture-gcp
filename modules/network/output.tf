# #########################################
# MODULE OUTPUTS
# #########################################

output "vpc_id" {
  value = google_compute_network.vpc_network.id
}

output "vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "vpc_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "subnets" {
  value       = google_compute_subnetwork.vpc_subnetworks
  description = "The created subnet resources"
}

output "subnet_names" {
  value       = [for subnet in google_compute_subnetwork.vpc_subnetworks : subnet.name]
  description = "The subnet names"
}

