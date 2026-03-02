# Artifact Registry Module
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
| [google_artifact_registry_repository.repos](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_registry_repositories"></a> [artifact\_registry\_repositories](#input\_artifact\_registry\_repositories) | Artifact Registry repositories to create.<br/><br/>Example:<br/>repositories = {<br/>  "backend" = {<br/>    repository\_id = "backend-docker"<br/>    description   = "Backend Docker images"<br/>    format        = "DOCKER"<br/>    labels        = { environment = "dev" }<br/>  }<br/>} | <pre>map(object({<br/>    repository_id = string<br/>    description   = string<br/>    format        = string<br/>    ar_labels        = map(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to be applied to all repositories | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where repositories will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repositories"></a> [repositories](#output\_repositories) | Map of created repositories (keyed by var.repositories keys). |
<!-- END_TF_DOCS -->