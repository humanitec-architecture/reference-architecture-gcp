# GKE Module

Creates a GKE cluster and installs the ingress-nginx ingress controller in it.

The following is provisioned:
- GKE cluster
- Service Account for accessing the cluster
- External Static IP (to front Load Balancer used by ingress-nginx)
- ingress-nginx provision in-cluster

## Required input variables

| Variable | Type | Description | Example |
| --- | --- | --- | --- |
| `project_id` | `string` | The GCP project provision the infrastructure in. | `"my-gcp-project"` |
| `region` | `string` | The GCP region to provision the infrastructure in. | `"us-west1"` |
| `vpc_name` | `string` | The name of the VPC to deploy the cluster in. | `"my-vpc"` |
| `subnet` | `string` | The name of the subnet that nodes should be provisioned in. | `"my-subnet"` |
| `cluster_name` | `string` | The name of the GKE cluster. | `"my-cluster"` |


## Optional input variables

| Variable | Type | Description | Default |
| --- | --- | --- | --- |
| `ip_allocation_policy` | `object` | A prefix that will be attached to all IDs created in Humanitec. Format defined [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#nested_ip_allocation_policy)  | `{ cluster_ipv4_cidr_block  = "/14", services_ipv4_cidr_block = "/20" }` |
| `enable_autopilot` | `bool` | If set to `true`, an Autopilot cluster will be provisioned. | `true` |
| `release_channel` | `string` | The release channel to use for the GKE cluster. | `"REGULAR"` |
| `node_size` | `string` | The default node size to use. | `"n2d-standard-4"` |