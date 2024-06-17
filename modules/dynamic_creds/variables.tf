variable "gcp_project_id" {
  type        = string
  description = "The ID of the GCP project to which resources will be deployed."
}

variable "gcp_workload_identity_pool_id" {
  type        = string
  default     = "humanitec-wif-pool"
  description = "The ID of the Workload Identity Pool in GCP, which allows you to manage resources within the GCP project."
}

variable "gcp_workload_identity_pool_provider_id" {
  type        = string
  default     = "humanitec-wif"
  description = "The ID of the Workload Identity Pool Provider within the specified Workload Identity Pool in GCP, enabling integration with Humanitec."
}

variable "gcp_service_account_id" {
  type        = string
  default     = "humanitec-cloud-account"
  description = "The ID of the service account used for authenticating and managing GCP resources."
}

variable "humanitec_org" {
  type        = string
  description = "The identifier of the Humanitec organization used for managing deployments and resources."
}
