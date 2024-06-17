<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.1 |
| humanitec | ~> 1.0 |

### Providers

| Name | Version |
|------|---------|
| google | ~> 5.1 |
| humanitec | ~> 1.0 |

### Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.pool_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.cloud_account_container_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.iam-binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [humanitec_resource_account.cloud_account](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_account) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gcp\_project\_id | The ID of the GCP project to which resources will be deployed. | `string` | n/a | yes |
| humanitec\_org | The identifier of the Humanitec organization used for managing deployments and resources. | `string` | n/a | yes |
| gcp\_service\_account\_id | The ID of the service account used for authenticating and managing GCP resources. | `string` | `"humanitec-cloud-account"` | no |
| gcp\_workload\_identity\_pool\_id | The ID of the Workload Identity Pool in GCP, which allows you to manage resources within the GCP project. | `string` | `"humanitec-wif-pool"` | no |
| gcp\_workload\_identity\_pool\_provider\_id | The ID of the Workload Identity Pool Provider within the specified Workload Identity Pool in GCP, enabling integration with Humanitec. | `string` | `"humanitec-wif"` | no |

### Outputs

| Name | Description |
|------|-------------|
| humanitec\_cloud\_account | The ID of the Humanitec Cloud Account. |
<!-- END_TF_DOCS -->