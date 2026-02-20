# Secret Manager Module
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
| [google_secret_manager_secret.secrets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.secret_iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | Base labels applied to all secrets. These will be merged with module defaults. | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID where secrets will be created. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region used for user-managed secret replication (e.g., 'europe-west1'). | `string` | n/a | yes |
| <a name="input_secret_iam_bindings"></a> [secret\_iam\_bindings](#input\_secret\_iam\_bindings) | Optional IAM bindings ON each secret.<br/><br/>Structure:<br/>secret\_iam\_bindings = {<br/>  "<SECRET\_ID>" = {<br/>    "<BINDING\_KEY>" = {<br/>      role   = "roles/secretmanager.secretAccessor"<br/>      member = "group:platform@company.com"<br/>    }<br/>  }<br/>}<br/><br/>member must be provided in IAM member format, e.g.:<br/>- user:alice@company.com<br/>- group:platform@company.com<br/>- serviceAccount:sa-ci@project.iam.gserviceaccount.com<br/>- principalSet://iam.googleapis.com/projects/123/locations/global/workloadIdentityPools/pool/attribute.repository/org/repo | <pre>map(map(object({<br/>    role   = string<br/>    member = string<br/>  })))</pre> | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | List of Secret Manager secret IDs to create (containers only).<br/>Secret values/versions are expected to be uploaded manually.<br/><br/>Example:<br/>secrets = ["my-secret-1", "my-secret-2"] | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_iam_bindings_applied"></a> [secret\_iam\_bindings\_applied](#output\_secret\_iam\_bindings\_applied) | IAM bindings applied on secrets (role + member). |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Secrets created by this module, keyed by secret\_id. |
<!-- END_TF_DOCS -->