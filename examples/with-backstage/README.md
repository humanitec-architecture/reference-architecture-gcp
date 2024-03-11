# GCP reference architecture with Backstage

Provisions the GCP reference architecture connected to Humanitec and installs Backstage.

## Prerequisites

* The same prerequisites as the [base reference architecture](../../README.md#prerequisites), plus the following items.
* A GitHub organization and permission to create new repositories in it. Go to https://github.com/account/organizations/new to create a new org (the "Free" option is fine). Note: is has to be an organization, a free account is not sufficient.
* Create a classic github personal access token with `repo`, `workflow`, `delete_repo` and `admin:org` scope [here](https://github.com/settings/tokens).
* Set the `GITHUB_TOKEN` environment variable to your token.
  ```
  export GITHUB_TOKEN="my-github-token"
  ```
* Set the `GITHUB_ORG_ID` environment variable to your GitHub organization ID.
  ```
  export GITHUB_ORG_ID="my-github-org-id"
  ```
* [Node.js](https://nodejs.org) installed locally.
* Install the GitHub App for Backstage into your GitHub organization using `node create-gh-app/index.js`. Follow the instructions.
  * “All repositories” ~> Install
  * “Okay, […] was installed on the […] account.” ~> You can close the window and server.

## Usage

Follow the same steps as for the [base layer](../../README.md#usage), applying these modifications:
* Execute `cd ./examples/with-backstage` after cloning the repo. Execute all subsequent commands in this directory.
* In particular, use the `./examples/with-backstage/terraform.tfvars.example` file as the basis for your `terraform.tfvars` file. It defines additional variables needed to setup and configure Backstage.

## Verify your result

Check for the existence of key elements of the backstage module. This is a subset of all elements only. For a complete list of what was installed, review the Terraform code.

1. Perform the [verification steps of the base installation](../../README.md) if you have not already done so.
2. Verify the existence of the Backstage Application in your Humanitec Organization:
   ```
   curl -s https://api.humanitec.io/orgs/${HUMANITEC_ORG}/apps/backstage \
     --header "Authorization: Bearer ${HUMANITEC_TOKEN}"
   ```
   This should output a JSON formatted representation of the Application like so:
   ```
   {"id":"backstage","name":"backstage","created_at":"2023-10-02T13:44:27Z","created_by":"s-d3e94a0e-8b53-29f9-b666-27548b7e06e0","envs":[{"id":"development","name":"Development","type":"development"}]}
   ```
   You can also check for the Application in the [Humanitec Platform Orchestrator UI](https://app.humanitec.io).

3. Connect to your GKE cluster via `kubectl`. See the [GKE documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl) or use this command:
   ```
   gcloud container clusters get-credentials htc-ref-arch-cluster --location <my-gcp-region>
   ```
4. Get the elements in the newly created Kubernetes namespace:
   ```
   kubectl get all -n backstage-development
   ```
   You should see
   - a `deployment`, `replicaset`, running `pod`, and `service` for Backstage
   - a `statefulset`, running `pod`, and `service` for PostgreSQL database used by Backstage.

   Note: it may take up to ten minutes after the `terraform apply` completed until you actually see those resources. The Backstage application needs to built and deployed via a GitHub action out of the newly created repository in your GitHub organization.


## Cleaning up

Once you are finished with the reference architecture, you can remove all provisioned infrastructure and the resource definitions created in Humanitec with the following:

1. Delete all Humanitec applications scaffolded using Backstage, but not the `backstage` app itself.

2. Follow the [base reference architecture cleanup instructions](../../README.md#cleaning-up).

## Terraform docs

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| github | ~> 5.38 |
| google | ~> 5.1 |
| humanitec | ~> 1.0 |
| random | ~> 3.5 |

### Providers

| Name | Version |
|------|---------|
| github | ~> 5.38 |
| google | ~> 5.1 |
| humanitec | ~> 1.0 |
| random | ~> 3.5 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| backstage\_mysql | git::https://github.com/humanitec-architecture/resource-packs-in-cluster.git//humanitec-resource-defs/mysql/basic | n/a |
| backstage\_postgres | git::https://github.com/humanitec-architecture/resource-packs-in-cluster.git//humanitec-resource-defs/postgres/basic | n/a |
| base | ../../modules/base | n/a |
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
| [github_repository.backstage](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [google_artifact_registry_repository_iam_member.gha_gar_containers_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [humanitec_application.backstage](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_resource_definition_criteria.backstage_mysql](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.backstage_postgres](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_value.backstage_cloud_provider](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_app_client_id](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_app_client_secret](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_app_id](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_app_private_key](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_app_webhook_secret](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_github_org_id](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_humanitec_org](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [humanitec_value.backstage_humanitec_token](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/value) | resource |
| [random_string.oidc_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gar\_repository\_location | Location of the Google Artifact Registry repository, | `string` | n/a | yes |
| github\_org\_id | GitHub org id | `string` | n/a | yes |
| humanitec\_ci\_service\_user\_token | Humanitec CI Service User Token | `string` | n/a | yes |
| humanitec\_org\_id | Humanitec Organization ID | `string` | n/a | yes |
| project\_id | GCP Project ID to provision resources in. | `string` | n/a | yes |
| region | GCP Region to provision resources in. | `string` | n/a | yes |
| environment | The environment to associate the reference architecture with. | `string` | `null` | no |
| environment\_type | The environment type to associate the reference architecture with. | `string` | `"development"` | no |
| humanitec\_prefix | A prefix that will be attached to all IDs created in Humanitec. | `string` | `"htc-ref-arch-"` | no |
<!-- END_TF_DOCS -->
