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

variable "gar_repository_id" {
  type        = string
  description = "Google Artifact Registry repository ID."
  default     = "htc-ref-arch"
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

variable "with_backstage" {
  description = "Deploy Backstage"
  type        = bool
  default     = false
}

variable "github_org_id" {
  description = "GitHub org id (required for Backstage)"
  type        = string
  default     = null
}

variable "humanitec_org_id" {
  description = "Humanitec Organization ID."
  type        = string
  default     = null
}
