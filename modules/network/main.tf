terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
  }
  required_version = ">= 1.3.0"
}

##########################################
# VPC DEFINITION
##########################################

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  description             = var.vpc_description
  auto_create_subnetworks = false
  project                 = var.project_id
}

##########################################
# VPC SUBNETS
##########################################

resource "google_compute_subnetwork" "vpc_subnetworks" {
  for_each = {
    for s in var.subnets : s.name => s
  }
  project                  = var.project_id
  network                  = google_compute_network.vpc_network.self_link
  name                     = each.value.name
  description              = each.value.description
  purpose                  = each.value.purpose
  role                     = each.value.role
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = each.value.region
  private_ip_google_access = each.value.private_ip_google_access
  secondary_ip_range       = each.value.secondary_ip_range
  depends_on               = [google_compute_network.vpc_network]

}

##########################################
# CLOUD NAT
##########################################

resource "google_compute_router" "router" {
  name    = var.vpc_name
  network = google_compute_network.vpc_network.name
  region  = var.region
}

resource "google_compute_router_nat" "router_nat" {
  name                               = var.vpc_name
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  region                             = var.region
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  dynamic "subnetwork" {
    for_each = {
      for s in google_compute_subnetwork.vpc_subnetworks : s.name => s
    }
    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}
