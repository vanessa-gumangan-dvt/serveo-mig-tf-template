# IAM Module

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
| [google_project_iam_member.group_project_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.sa_project_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.user_project_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.service_accounts](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.sa_iam_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_project_roles"></a> [group\_project\_roles](#input\_group\_project\_roles) | Project-level IAM roles for groups.<br/><br/>Map key = group email (without the 'group:' prefix)<br/>Value   = list of roles<br/><br/>Example:<br/>group\_project\_roles = {<br/>  "platform@company.com" = ["roles/viewer"]<br/>} | `map(list(string))` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID where IAM will be managed. | `string` | n/a | yes |
| <a name="input_service_account_iam_bindings"></a> [service\_account\_iam\_bindings](#input\_service\_account\_iam\_bindings) | Optional IAM bindings ON each Service Account (impersonation / actAs / WIF).<br/><br/>Structure:<br/>service\_account\_iam\_bindings = {<br/>  "<sa\_account\_id>" = {<br/>    "<binding\_key>" = {<br/>      role   = "roles/iam.serviceAccountTokenCreator"<br/>      member = "user:alice@company.com"<br/>    }<br/>  }<br/>}<br/><br/>member must be provided in IAM member format, e.g.:<br/>- user:alice@company.com<br/>- group:platform@company.com<br/>- serviceAccount:sa-ci@project.iam.gserviceaccount.com<br/>- principalSet://iam.googleapis.com/projects/123/locations/global/workloadIdentityPools/pool/attribute.repository/org/repo | <pre>map(map(object({<br/>    role   = string<br/>    member = string<br/>  })))</pre> | `{}` | no |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | Service Accounts to create and their project-level roles.<br/><br/>Map key = service account account\_id (must be unique within the project)<br/><br/>Example:<br/>service\_accounts = {<br/>  "sa-terraform" = {<br/>    display\_name  = "Terraform SA"<br/>    description   = "Used by Terraform"<br/>    project\_roles = ["roles/storage.admin"]<br/>  }<br/>} | <pre>map(object({<br/>    display_name  = string<br/>    description   = optional(string)<br/>    project_roles = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_user_project_roles"></a> [user\_project\_roles](#input\_user\_project\_roles) | Project-level IAM roles for users.<br/><br/>Map key = user email (without the 'user:' prefix)<br/>Value   = list of roles<br/><br/>Example:<br/>user\_project\_roles = {<br/>  "alice@company.com" = ["roles/viewer", "roles/logging.viewer"]<br/>} | `map(list(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_project_bindings"></a> [group\_project\_bindings](#output\_group\_project\_bindings) | Project-level IAM bindings applied for groups. |
| <a name="output_service_account_iam_bindings_applied"></a> [service\_account\_iam\_bindings\_applied](#output\_service\_account\_iam\_bindings\_applied) | IAM bindings applied ON service accounts (impersonation / actAs / WIF). |
| <a name="output_service_account_project_bindings"></a> [service\_account\_project\_bindings](#output\_service\_account\_project\_bindings) | Project-level IAM bindings applied for service accounts created by this module. |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | Service Accounts created by this module, keyed by account\_id. |
| <a name="output_user_project_bindings"></a> [user\_project\_bindings](#output\_user\_project\_bindings) | Project-level IAM bindings applied for users. |
<!-- END_TF_DOCS -->