<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| github | ~> 5.38 |
| google | ~> 5.1 |
| random | ~> 3.5 |

### Providers

| Name | Version |
|------|---------|
| github | ~> 5.38 |
| google | ~> 5.1 |
| random | ~> 3.5 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| gh\_oidc | terraform-google-modules/github-actions-runners/google//modules/gh-oidc | ~> 3.1 |

### Resources

| Name | Type |
|------|------|
| [github_actions_organization_secret.backstage_humanitec_token](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret) | resource |
| [github_actions_organization_variable.backstage_cloud_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_organization_variable.backstage_gcp_gar_host](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_organization_variable.backstage_gcp_gar_name](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_organization_variable.backstage_gcp_service_account](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_organization_variable.backstage_gcp_workload_identity_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [github_actions_organization_variable.backstage_humanitec_org_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable) | resource |
| [google_artifact_registry_repository_iam_member.gha_gar_containers_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_string.oidc_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gar\_repository\_id | Google Artifact Registry repository ID. | `string` | n/a | yes |
| gar\_repository\_location | Location of the Google Artifact Registry repository. | `string` | n/a | yes |
| github\_org\_id | GitHub org id | `string` | n/a | yes |
| humanitec\_ci\_service\_user\_token | Humanitec CI Service User Token | `string` | n/a | yes |
| humanitec\_org\_id | Humanitec Organization ID. | `string` | n/a | yes |
| project\_id | GCP Project ID to provision resources in. | `string` | n/a | yes |
<!-- END_TF_DOCS -->