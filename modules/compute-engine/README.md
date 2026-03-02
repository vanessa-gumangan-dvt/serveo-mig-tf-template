# Compute Engine Module
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
| [google_compute_instance.instances](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to be applied to all Compute Engine instances | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_vm_instances"></a> [vm\_instances](#input\_vm\_instances) | Compute Engine instances to create | <pre>map(object({<br/>    name                = string<br/>    zone                = string<br/>    machine_type        = string<br/>    image               = string<br/>    disk_size_gb        = number<br/>    disk_type           = string<br/>    network             = string<br/>    subnetwork          = string<br/>    assign_public_ip    = bool<br/>    service_account     = string<br/>    vm_labels           = map(string) <br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instances"></a> [instances](#output\_instances) | Map of created Compute Engine instances keyed by var.instances key. |
<!-- END_TF_DOCS -->