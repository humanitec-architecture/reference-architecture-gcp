# Humanitec Google Cloud Reference Architecture Implementation
> TL;DR
>
>Skip the theory? Go [here](README.md#how-to-spin-up-your-humanitec-google-cloud-reference-architecture-implementation) to spin up your Humanitec Google Cloud Reference Architecture Implementation.
>
> [Follow this learning path to master you Internal Developer Platform](https://developer.humanitec.com/training/master-your-internal-developer-platform/introduction/).

Building an Internal Developer Platform (IDP) can come with many challenges. To give you a head start, we’ve created a set of [reference architectures](https://humanitec.com/reference-architectures) based on hundreds of real-world setups. These architectures described in code provide a starting point to build your own IDP within minutes, along with customization capabilities to ensure your platform meets the unique needs of your users (developers).

The initial version of this reference architecture has been presented by Marco Marulli, Principal Delivery Lead II, McKinsey & Company at [PlatformCon 2023](https://www.youtube.com/watch?v=TswbmEXrvJg).

## What is an Internal Developer Platform (IDP)?

An [Internal Developer Platform (IDP)](https://humanitec.com/blog/what-is-an-internal-developer-platform) is the sum of all the tech and tools that a platform engineering team binds together to pave golden paths for developers. IDPs lower cognitive load across the engineering organization and enable developer self-service, without abstracting away context from developers or making the underlying tech inaccessible. Well-designed IDPs follow a Platform as a Product approach, where a platform team builds, maintains, and continuously improves the IDP, following product management principles and best practices.

## Understanding the different planes of the IDP reference architecture

When McKinsey originally [published the reference architecture](https://youtu.be/AimSwK8Mw-U?feature=shared) they proposed five planes that describe the different parts of a modern Internal Developer Platform (IDP).

![Google Cloud reference architecture Humanitec](docs/images/Reference-Architecture-Google-Cloud-Humanitec.png)

### Developer Control Plane 

This plane is the primary configuration layer and interaction point for the platform users. It harbors the following components:

* A **Version Control System**. GitHub is a prominent example, but this can be any system that contains two types of repositories:
    * Application Source Code
    * Platform Source Code, e.g. using Terraform
* **Workload specifications**. The reference architecture uses [Score](https://developer.humanitec.com/score/overview/).
* A **portal** for developers to interact with. It can be the Humanitec Portal, but you might also use [Backstage](https://backstage.io/) or any other portal on the market.

### Integration and Delivery Plane 

This plane is about building and storing the image, creating app and infra configs from the abstractions provided by the developers, and deploying the final state. It’s where the domains of developers and platform engineers meet.

This plane usually contains four different tools:
* A **CI pipeline**. It can be Github Actions or any CI tooling on the market.
* The **image registry** holding your container images. Again, this can be any registry on the market.
* An **orchestrator** which in our example, is the Humanitec Platform Orchestrator.
* The **CD system**, which can be the Platform Orchestrator’s deployment pipeline capabilities — an external system triggered by the Orchestrator using a webhook, or a setup in tandem with GitOps operators like ArgoCD.

### Monitoring and Logging Plane 

The integration of monitoring and logging systems varies greatly depending on the system. This plane however is not a focus of the reference architecture.

### Security Plane 

The security plane of the reference architecture is focused on the secrets management system. The secrets manager stores configuration information such as database passwords, API keys, or TLS certificates needed by an Application at runtime. It allows the Platform Orchestrator to reference the secrets and inject them into the Workloads dynamically. You can learn more about secrets management and integration with other secrets management [here](https://developer.humanitec.com/platform-orchestrator/security/overview). 

The reference architecture sample implementations use the secrets store attached to the Humanitec SaaS system.

### Resource Plane

This plane is where the actual infrastructure exists including clusters, databases, storage, or DNS services. The configuration of the Resources is managed by the Platform Orchestrator which dynamically creates app and infrastructure configurations with every deployment and creates, updates, or deletes dependent Resources as required.

## How to spin up your Humanitec Google Cloud Reference Architecture Implementation
This repo contains an implementation of part of the Humanitec Reference Architecture for an Internal Developer Platform.

To install an implementation containing add-ons, follow the separate README. We currently feature these add-ons:

* [Base layer plus Backstage](examples/with-backstage/)

This repo covers the base layer of the implementation for Google Cloud (GCP).

By default, the following will be provisioned:

- VPC
- GKE Autopilot Cluster
- Google Service Account to access the cluster
- Ingress NGINX in the cluster
- Resource Definitions in Humanitec for:
  - Kubernetes Cluster
  - Logging

### Prerequisites

* A Humanitec account with the `Administrator` role in an Organization. Get a [free trial](https://humanitec.com/free-trial?utm_source=github&utm_medium=referral&utm_campaign=gcp_refarch_repo) if you are just starting.
* A GCP project
* [gcloud CLI](https://cloud.google.com/cli) installed locally
* [Terraform](https://www.terraform.io/) installed locally

### Usage

**Note: Using this Reference Architecture Implementation will incur costs for your GCP project.**

It is recommended that you fully review the code before you run it to ensure you understand the impact of provisioning this infrastructure.
Humanitec does not take responsibility for any costs incurred or damage caused when using the Reference Architecture Implementation.

This reference architecture implementation uses Terraform. You will need to do the following:

1. [Fork this GitHub repo](https://github.com/humanitec-architecture/reference-architecture-gcp/fork), clone it to your local machine and navigate to the root of the repository.

2. Set the required input variables (see [Required input variables](#required-input-variables)).

3. Ensure you are logged in with `gcloud` (See: [gcloud auth application-default login](https://cloud.google.com/sdk/gcloud/reference/auth/application-default)).

   You will need to ensure your Google Cloud account has appropriate permissions on the project you wish to provision in.

4. Set the `HUMANITEC_TOKEN` environment variable to an appropriate Humanitec API token with the `Administrator` role on the Humanitec Organization.

   For example:

   ```
   export HUMANITEC_TOKEN="my-humanitec-api-token"
   ```

5. Run terraform:

   ```
   terraform init
   terraform plan
   terraform apply
   ```

#### Required input variables

Terraform reads variables by default from a file called `terraform.tfvars`. You can create your own file by renaming the `terraform.tfvars.example` file in the root of the repo and then filling in the missing values.

The following variables are required and so need to be set:

| Variable | Type | Description | Example |
| --- | --- | --- | --- |
| `project_id` | `string` | The GCP project provision the infrastructure in. | `"my-gcp-project"` |
| `region` | `string` | The GCP region to provision the infrastructure in. | `"us-west1"` |
| `humanitec_org_id` | `string` | The ID of the Humanitec Organization the cluster should be associated with. | `"my-org"` |

There are many other optional inputs that can be set. The full list is described in [Inputs](#inputs).

### Verify your result

Check for the existence of key elements of the reference architecture. This is a subset of all elements only. For a complete list of what was installed, review the Terraform code.

1. Set the `HUMANITEC_ORG` environment variable to the ID of your Humanitec Organization (must be all lowercase):
```bash
export HUMANITEC_ORG="my-humanitec-org"   
```

2. Verify the existence of the Resource Definition for the GKE cluster in your Humanitec Organization:
```bash
curl -s https://api.humanitec.io/orgs/${HUMANITEC_ORG}/resources/defs/htc-ref-arch-cluster \
  --header "Authorization: Bearer ${HUMANITEC_TOKEN}" \
  | jq .id,.type
```
This should output:
```bash
"htc-ref-arch-cluster"
"k8s-cluster"
```

3. Verify the existence of the newly created GKE cluster:

```bash
gcloud container clusters list --filter "name=htc-ref-arch-cluster"
```
This should output cluster data like this:
```bash
NAME                  LOCATION       MASTER_VERSION  MASTER_IP       MACHINE_TYPE    NODE_VERSION    NUM_NODES  STATUS
htc-ref-arch-cluster  <your-region>  xx.xx.xx-gke.xx xx.xx.xx.xx     n2d-standard-4  xx.xx.xx-gke.xx 3          RUNNING
```

### Cleaning up

Once you are finished with the reference architecture, you can remove all provisioned infrastructure and the resource definitions created in Humanitec with the following:

1. Ensure you are (still) logged in with `gcloud`.

2. Ensure you still have the `HUMANITEC_TOKEN` environment variable set to an appropriate Humanitec API token with the `Administrator` role on the Humanitec Organization.
  
   You can verify this in the UI if you log in with an Administrator user and go to Resource Management, and check the "Usage" of each resource definition with the prefix set in `humanitec_prefix` - by default this is `htc-ref-arch-`.

3. Run terraform:

   ```
   terraform destroy
   ```

## Terraform docs

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.1 |
| humanitec | ~> 0.13 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| base | ./modules/base | n/a |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| humanitec\_org\_id | ID of the Humanitec Organization to associate resources with. | `string` | n/a | yes |
| project\_id | GCP Project ID to provision resources in. | `string` | n/a | yes |
| region | GCP Region to provision resources in. | `string` | n/a | yes |
| environment | The environment to associate the reference architecture with. | `string` | `null` | no |
| environment\_type | The environment type to associate the reference architecture with. | `string` | `"development"` | no |
| humanitec\_prefix | A prefix that will be attached to all IDs created in Humanitec. | `string` | `"htc-ref-arch-"` | no |
<!-- END_TF_DOCS -->

## Learn more

Expand your knowledge by heading over to our learning path, and discover how to:
* Deploy the Humanitec reference architecture using a cloud provider of your choice
* Deploy and manage Applications using the Humanitec Platform Orchestrator and Score
* Provision additional Resources and connect to them
* Achieve standardization by design
* Deal with special scenarios

[Master your Internal Developer Platform](https://developer.humanitec.com/training/master-your-internal-developer-platform/introduction/)

* [Introduction](https://developer.humanitec.com/training/master-your-internal-developer-platform/introduction/)
* [Design principles](https://developer.humanitec.com/training/master-your-internal-developer-platform/design-principles/)
* [Structure and integration points](https://developer.humanitec.com/training/master-your-internal-developer-platform/structure-and-integration-points/)
* [Dynamic Configuration Management](https://developer.humanitec.com/training/master-your-internal-developer-platform/dynamic-config-management/)
* [Tutorial: Set up the reference architecture in your cloud](https://developer.humanitec.com/training/master-your-internal-developer-platform/setup-ref-arch-in-your-cloud/)
* [Theory on developer workflows](https://developer.humanitec.com/training/master-your-internal-developer-platform/theory-on-dev-workflows/)
* [Tutorial: Scaffold a new Workload and create staging and prod Environments](https://developer.humanitec.com/training/master-your-internal-developer-platform/scaffolding-a-new-workload/)
* [Tutorial: Deploy an Amazon S3 Resource to production](https://developer.humanitec.com/training/master-your-internal-developer-platform/deploy-a-resource/)
* [Tutorial: Perform daily developer activities (debug, rollback, diffs, logs)](https://developer.humanitec.com/training/master-your-internal-developer-platform/daily-activities/)
* [Tutorial: Deploy ephemeral Environments](https://developer.humanitec.com/training/master-your-internal-developer-platform/deploy-ephemeral-environments/)
* [Theory on platform engineering workflows](https://developer.humanitec.com/training/master-your-internal-developer-platform/theory-on-pe-workflows/)
* [Resource management theory](https://developer.humanitec.com/training/master-your-internal-developer-platform/resource-management-theory/)
* [Tutorial: Provision a Redis cluster on AWS using Terraform](https://developer.humanitec.com/training/master-your-internal-developer-platform/provision-redis-aws/)
* [Tutorial: Update Resource Definitions for related Applications](https://developer.humanitec.com/training/master-your-internal-developer-platform/update-resource-definitions-for-related-applications/)


