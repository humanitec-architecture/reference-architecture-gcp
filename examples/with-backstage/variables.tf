##########################################
# REQUIRED INPUTS
##########################################

variable "project_id" {
  type        = string
  description = "GCP Project ID to provision resources in."
}


variable "region" {
  type        = string
  description = "GCP Region to provision resources in."
}

variable "gar_repository_location" {
  type        = string
  description = "Location of the Google Artifact Registry repository,"
}

variable "github_org_id" {
  description = "GitHub org id"
  type        = string
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID"
  type        = string
}

variable "humanitec_ci_service_user_token" {
  description = "Humanitec CI Service User Token"
  type        = string
  sensitive   = true
}

##########################################
# OPTIONAL INPUTS
##########################################

variable "environment" {
  type        = string
  description = "The environment to associate the reference architecture with."
  default     = null
}

variable "environment_type" {
  type        = string
  description = "The environment type to associate the reference architecture with."
  default     = "development"
}

variable "humanitec_prefix" {
  type        = string
  description = "A prefix that will be attached to all IDs created in Humanitec."
  default     = "htc-ref-arch-"
}
