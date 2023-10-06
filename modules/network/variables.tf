# #########################################
# VARIABLES DEFINITION
# #########################################
#
variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

# VPC Variables
variable "vpc_name" {
  type        = string
  description = "VPC Name"
}
variable "vpc_description" {
  type        = string
  description = "VPC Description"
}

variable "subnets" {
  type = list(object({
    name                     = string
    description              = string
    ip_cidr_range            = string
    purpose                  = optional(string)
    role                     = optional(string)
    region                   = optional(string)
    private_ip_google_access = optional(bool)
    secondary_ip_range = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })))
  }))
  description = "List of VPC Subnets"
}


variable "subnet_flow_logs" {
  description = "Optional map of boolean to control flow logs (default is disabled), keyed by subnet 'region/name'."
  type        = map(bool)
  default     = {}
}

variable "drain_nat_ips" {
  type    = list(string)
  default = null
}

variable "log_configs" {
  description = "Map keyed by subnet 'region/name' of optional configurations for flow logs when enabled."
  type        = map(map(string))
  default     = {}
}

variable "log_config_defaults" {
  description = "Default configuration for flow logs when enabled (If nothing defined in log_configs)."
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })
  default = {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

