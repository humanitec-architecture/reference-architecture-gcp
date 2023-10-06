# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "gke" {
  name       = var.cluster_name
  location   = var.region
  network    = var.vpc_name
  subnetwork = var.subnet

  remove_default_node_pool = var.enable_autopilot ? null : true
  initial_node_count       = var.enable_autopilot ? null : 1
  datapath_provider        = "ADVANCED_DATAPATH" # Dataplane V2 (NetworkPolicies) is enabled.

  enable_autopilot = var.enable_autopilot

  # Requried as of version 5.0.0+ of the hashicorp/google provider to allow for a clean destroy
  # Not documented as of this time. See: https://github.com/hashicorp/terraform-provider-google/blob/main/website/docs/r/container_cluster.html.markdown
  deletion_protection = false

  release_channel {
    channel = var.release_channel
  }

  cluster_autoscaling {
    enabled = var.enable_autopilot ? null : true

    auto_provisioning_defaults {
      service_account = google_service_account.gke_nodes.email
      oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    }
  }


  master_authorized_networks_config {

    dynamic "cidr_blocks" {
      for_each = data.humanitec_source_ip_ranges.main.cidr_blocks
      content {
        cidr_block = cidr_blocks.key
      }
    }

    cidr_blocks {
        # Open to public internet to make it easier to connect for testing
        # At least the local IP running terraform needs to be included
        cidr_block = "0.0.0.0/0"

        # Alternative for tighter access, but less flexibility:
        # cidr_block = "${chomp(data.http.icanhazip.response_body)}/32"
    }
    gcp_public_cidrs_access_enabled = false
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_allocation_policy.cluster_secondary_range_name
    services_secondary_range_name = var.ip_allocation_policy.services_secondary_range_name
    cluster_ipv4_cidr_block       = var.ip_allocation_policy.cluster_ipv4_cidr_block
    services_ipv4_cidr_block      = var.ip_allocation_policy.services_ipv4_cidr_block
    stack_type                    = var.ip_allocation_policy.stack_type
  }

  node_config {
    machine_type    = var.node_size
    service_account = google_service_account.gke_nodes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  dynamic "confidential_nodes" {
    for_each = var.enable_autopilot ? [] : [1]
    content {
      enabled = true
    }
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = var.enable_autopilot
    }
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  dynamic "workload_identity_config" {
    # workload identity is enabled by default for Autopilot and there is no
    # need to set the workload pool.
    for_each = var.enable_autopilot ? [] : [1]

    content {
      workload_pool = "${var.project_id}.svc.id.goog"
    }

  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
  }

  lifecycle {
    ignore_changes = [
      node_config # otherwise destroy/recreate with Autopilot...
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "gke_node_pool" {
  count       = var.gcp_gke_autopilot ? 0 : 1
  name        = "primary"
  cluster     = google_container_cluster.gke.id
  
  autoscaling {
    min_node_count = 0
    max_node_count = 4
  }

  node_config {
    machine_type    = var.node_size
    service_account = google_service_account.gke_nodes.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}