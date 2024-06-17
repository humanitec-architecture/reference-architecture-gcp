<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 1.0 |

### Providers

| Name | Version |
|------|---------|
| humanitec | ~> 1.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| default\_mysql | github.com/humanitec-architecture/resource-packs-in-cluster | v2024-06-05//humanitec-resource-defs/mysql/basic |
| default\_postgres | github.com/humanitec-architecture/resource-packs-in-cluster | v2024-06-05//humanitec-resource-defs/postgres/basic |

### Resources

| Name | Type |
|------|------|
| [humanitec_resource_definition.k8s_cluster](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition_criteria.default_mysql](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.default_postgres](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_cluster](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_namespace](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment to use for matching criteria. | `string` | n/a | yes |
| environment\_type | The environment type to use for matching criteria. | `string` | n/a | yes |
| humanitec\_cloud\_account | The ID of the Humanitec Cloud Account. | `string` | n/a | yes |
| k8s\_cluster\_name | The name of the cluster. | `string` | n/a | yes |
| k8s\_loadbalancer | IP address or Host of the load balancer used by the ingress controller. | `string` | n/a | yes |
| k8s\_project\_id | The GCP Project the cluster is in. | `string` | n/a | yes |
| k8s\_region | The region the cluster is in. | `string` | n/a | yes |
| prefix | A prefix that will be attached to all IDs created in Humanitec. | `string` | `""` | no |
<!-- END_TF_DOCS -->