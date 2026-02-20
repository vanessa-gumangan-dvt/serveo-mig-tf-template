variable "project_id" {
  type        = string
  description = "GCP project ID where secrets will be created."
}

variable "region" {
  type        = string
  description = "Region used for user-managed secret replication (e.g., 'europe-west1')."
}

variable "secrets" {
  description = <<EOT
List of Secret Manager secret IDs to create (containers only).
Secret values/versions are expected to be uploaded manually.

Example:
secrets = ["my-secret-1", "my-secret-2"]
EOT
  type = list(string)
}

variable "labels" {
  description = "Base labels applied to all secrets. These will be merged with module defaults."
  type        = map(string)
  default     = {}
}

variable "secret_iam_bindings" {
  description = <<EOT
Optional IAM bindings ON each secret.

Structure:
secret_iam_bindings = {
  "<SECRET_ID>" = {
    "<BINDING_KEY>" = {
      role   = "roles/secretmanager.secretAccessor"
      member = "group:platform@company.com"
    }
  }
}

member must be provided in IAM member format, e.g.:
- user:alice@company.com
- group:platform@company.com
- serviceAccount:sa-ci@project.iam.gserviceaccount.com
- principalSet://iam.googleapis.com/projects/123/locations/global/workloadIdentityPools/pool/attribute.repository/org/repo
EOT

  type = map(map(object({
    role   = string
    member = string
  })))

  default = {}
}