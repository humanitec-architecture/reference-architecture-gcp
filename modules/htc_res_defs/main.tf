resource "humanitec_resource_account" "cluster_account" {
  id   = "${var.prefix}cluster"
  name = "${var.prefix}cluster"
  type = "gcp"

  credentials = var.k8s_credentials
}

resource "humanitec_resource_definition" "k8s_cluster" {
  driver_type = "humanitec/k8s-cluster-gke"
  id          = "${var.prefix}cluster"
  name        = "${var.prefix}cluster"
  type        = "k8s-cluster"

  driver_account = humanitec_resource_account.cluster_account.id
  driver_inputs = {
    values_string = jsonencode({
      "name"         = var.k8s_cluster_name
      "loadbalancer" = var.k8s_loadbalancer
      "project_id"   = var.k8s_project_id
      "zone"         = var.k8s_region
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_cluster" {
  resource_definition_id = humanitec_resource_definition.k8s_cluster.id
  env_id                 = var.environment
  env_type               = var.environment_type

}


resource "humanitec_resource_definition" "k8s_namespace" {
  driver_type = "humanitec/echo"
  id          = "${var.prefix}namespace"
  name        = "${var.prefix}namespace"
  type        = "k8s-namespace"

  driver_inputs = {
    values_string = jsonencode({
      "namespace" = "$${context.app.id}-$${context.env.id}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_namespace" {
  resource_definition_id = humanitec_resource_definition.k8s_namespace.id
  env_id                 = var.environment
  env_type               = var.environment_type
}
