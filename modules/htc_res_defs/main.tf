resource "humanitec_resource_definition" "k8s_cluster" {
  driver_type = "humanitec/k8s-cluster-gke"
  id          = "${var.prefix}cluster"
  name        = "${var.prefix}cluster"
  type        = "k8s-cluster"

  driver_account = var.humanitec_cloud_account
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

  force_delete = true
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

  force_delete = true
}


# in-cluster postgres

module "default_postgres" {
  source = "github.com/humanitec-architecture/resource-packs-in-cluster?ref=v2024-06-05//humanitec-resource-defs/postgres/basic"

  prefix = var.prefix
}

resource "humanitec_resource_definition_criteria" "default_postgres" {
  resource_definition_id = module.default_postgres.id
  env_id                 = var.environment
  env_type               = var.environment_type

  force_delete = true
}

module "default_mysql" {
  source = "github.com/humanitec-architecture/resource-packs-in-cluster?ref=v2024-06-05//humanitec-resource-defs/mysql/basic"

  prefix = var.prefix
}

resource "humanitec_resource_definition_criteria" "default_mysql" {
  resource_definition_id = module.default_mysql.id
  env_id                 = var.environment
  env_type               = var.environment_type

  force_delete = true
}

resource "humanitec_resource_definition" "emptydir_volume" {
  driver_type = "humanitec/template"
  id          = "volume-emptydir"
  name        = "volume-emptydir"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = {
          "emptydir.yaml" = {
            "location" = "volumes"
            "data"     = <<END_OF_TEXT
name: $${context.res.guresid}-emptydir
emptyDir:
  sizeLimit: 1024Mi
END_OF_TEXT
          }
        }
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "emptydir_volume" {
  resource_definition_id = humanitec_resource_definition.emptydir_volume.id
  env_id                 = var.environment
  env_type               = var.environment_type

  force_delete = true
}

