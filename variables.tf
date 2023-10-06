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


variable "humanitec_org_id" {
  type        = string
  description = "ID of the Humanitec Organization to associate resources with."
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