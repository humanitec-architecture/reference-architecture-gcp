variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "subnet" {
  type        = string
  description = "Subnet name for GKE nodes to be in."
}

variable "cluster_name" {
  description = "The name to assign to the cluster. Must be unique within the project."
  type        = string
}



# Defaults to /14 for pods and /20 for services as defined here: https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#defaults_limits
variable "ip_allocation_policy" {
  description = "Configuration of cluster IP allocation for VPC-native clusters."
  type = object({
    cluster_secondary_range_name  = optional(string)
    services_secondary_range_name = optional(string)
    cluster_ipv4_cidr_block       = optional(string)
    services_ipv4_cidr_block      = optional(string)
    stack_type                    = optional(string)
  })
  default = {
    cluster_ipv4_cidr_block  = "/14"
    services_ipv4_cidr_block = "/20"
  }
}

variable "enable_autopilot" {
  description = "Enable Autopilot cluster instead of standard cluster."
  type        = bool
  default     = true
}


variable "release_channel" {
  type    = string
  default = "REGULAR"
}

variable "node_size" {
  description = "Size of the GKE nodes."
  type        = string
  default     = "n2d-standard-4"
}

variable "gar_repository_id" {
  description = "The ID of the Google Artifact Registry repository to use for storing Docker images."
  type        = string
  default     = null
}

variable "gar_repository_region" {
  description = "Region of the Google Artifact Registry repository."
  type        = string
  default     = null
}
