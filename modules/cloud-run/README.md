# Cloud Run Module
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_v2_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to be applied to all Cloud Run services | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID del proyecto GCP | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | Mapa de servicios Cloud Run a crear | <pre>map(object({<br/>    name            = string<br/>    region          = string<br/>    image           = string<br/>    cpu             = string<br/>    memory          = string<br/>    min_instances   = number<br/>    max_instances   = number<br/>    timeout         = string<br/>    is_public       = bool<br/>    service_account = string<br/>    env_vars        = map(string)<br/>    vpc_access = optional(object({<br/>      network_interfaces = optional(object({<br/>        network    = string<br/>        subnetwork = string<br/>        tags       = optional(list(string), [])<br/>      }))<br/>      egress = optional(string, "ALL_TRAFFIC")<br/>    }))<br/>    cr_srv_labels = map(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_ids"></a> [service\_ids](#output\_service\_ids) | Map of Terraform resource IDs keyed by var.services key. |
| <a name="output_service_uris"></a> [service\_uris](#output\_service\_uris) | Map of service URIs keyed by var.services key. |
<!-- END_TF_DOCS -->