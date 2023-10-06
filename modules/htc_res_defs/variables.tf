
variable "k8s_cluster_name" {
  type        = string
  description = "The name of the cluster."
}
variable "k8s_loadbalancer" {
  type        = string
  description = "IP address or Host of the load balancer used by the ingress controller."
}
variable "k8s_project_id" {
  type        = string
  description = "The GCP Project the cluster is in."
}
variable "k8s_region" {
  type        = string
  description = "The region the cluster is in."
}
variable "k8s_credentials" {
  type        = map(any)
  description = "The credentials used to establish a connection to the cluster."
}
variable "environment" {
  type        = string
  description = "The environment to use for matching criteria."
}
variable "environment_type" {
  type        = string
  description = "The environment type to use for matching criteria."
}
variable "prefix" {
  type        = string
  description = "A prefix that will be attached to all IDs created in Humanitec."
  default     = ""
}