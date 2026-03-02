<!-- BEGIN_TF_DOCS -->
<!-- Can be regenerated with `terraform-docs .` -->
# Cloud Storage Buckets module

This module allows the creation and configuration of Cloud Storage buckets.

It uses the [Google Official Cloud Storage module](https://github.com/terraform-google-modules/terraform-google-cloud-storage/tree/master/modules/simple_bucket).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.60, <5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.60, <5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket | `string` | `""` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | A Cloud KMS key that will be used to encrypt objects inserted into this bucket | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where the resources will be provisioned. | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When deleting a bucket, this boolean option will delete all contained objects when set to true. If this value is set to false and you try to delete a bucket that contains objects, Terraform will fail. | `bool` | `false` | no |
| <a name="input_iam_members"></a> [iam\_members](#input\_iam\_members) | The list of IAM members to grant permissions on the bucket. | <pre>list(object({<br>    role   = string<br>    member = string<br>  }))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the bucket. | `map(string)` | `null` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | The bucket's Lifecycle Rules configuration. | <pre>list(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = any<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    condition = any<br>  }))</pre> | <pre>[<br>  {<br>    "action": {<br>      "type": "Delete"<br>    },<br>    "condition": {<br>      "age": 90,<br>      "num_newer_versions": 2,<br>      "with_state": "ARCHIVED"<br>    }<br>  }<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the bucket. | `string` | `"europe-west1"` | no |
| <a name="input_log_bucket"></a> [log\_bucket](#input\_log\_bucket) | The bucket that will receive log objects. | `string` | `null` | no |
| <a name="input_log_object_prefix"></a> [log\_object\_prefix](#input\_log\_object\_prefix) | The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name | `string` | `null` | no |
| <a name="input_prefix_enabled"></a> [prefix\_enabled](#input\_prefix\_enabled) | Whether the bucket name should be prefixed or not. Enabled by default | `bool` | `true` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project where the resources will be created | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project where the resources will be created (without prefixes) | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | The Storage Class of the new bucket. | `string` | `"STANDARD"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The created storage bucket full attributes |
| <a name="output_name"></a> [name](#output\_name) | Bucket name. |
| <a name="output_url"></a> [url](#output\_url) | Bucket URL. |
<!-- END_TF_DOCS -->