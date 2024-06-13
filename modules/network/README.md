<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.1 |

### Providers

| Name | Version |
|------|---------|
| google | ~> 5.1 |

### Resources

| Name | Type |
|------|------|
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.vpc_subnetworks](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | GCP Project ID | `string` | n/a | yes |
| region | GCP Region | `string` | n/a | yes |
| subnets | List of VPC Subnets | <pre>list(object({<br>    name                     = string<br>    description              = string<br>    ip_cidr_range            = string<br>    purpose                  = optional(string)<br>    role                     = optional(string)<br>    region                   = optional(string)<br>    private_ip_google_access = optional(bool)<br>    secondary_ip_range = optional(list(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    })))<br>  }))</pre> | n/a | yes |
| vpc\_description | VPC Description | `string` | n/a | yes |
| vpc\_name | VPC Name | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| subnet\_names | The subnet names |
| subnets | The created subnet resources |
| vpc\_id | n/a |
| vpc\_name | n/a |
| vpc\_self\_link | n/a |
<!-- END_TF_DOCS -->