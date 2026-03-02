variable "project_id" {
  type        = string
  description = "GCP project ID where IAM will be managed."
}

# =============================================
# Users: project-level roles
# Key = user email (without 'user:' prefix)
# =============================================
variable "user_project_roles" {
  description = <<EOT
Project-level IAM roles for users.

Map key = user email (without the 'user:' prefix)
Value   = list of roles

Example:
user_project_roles = {
  "alice@company.com" = ["roles/viewer", "roles/logging.viewer"]
}
EOT

  type    = map(list(string))
  default = {}
}

# =============================================
# Groups: project-level roles
# Key = group email (without 'group:' prefix)
# =============================================
variable "group_project_roles" {
  description = <<EOT
Project-level IAM roles for groups.

Map key = group email (without the 'group:' prefix)
Value   = list of roles

Example:
group_project_roles = {
  "platform@company.com" = ["roles/viewer"]
}
EOT

  type    = map(list(string))
  default = {}
}

# =============================================
# Service Accounts: create + project roles
# Key = service account account_id
# =============================================
variable "service_accounts" {
  description = <<EOT
Service Accounts to create and their project-level roles.

Map key = service account account_id (must be unique within the project)

Example:
service_accounts = {
  "sa-terraform" = {
    display_name  = "Terraform SA"
    description   = "Used by Terraform"
    project_roles = ["roles/storage.admin"]
  }
}
EOT

  type = map(object({
    display_name  = string
    description   = optional(string)
    project_roles = list(string)
  }))

  default = {}
}

# ==================================================
# Service Account IAM bindings (optional)
# Who can act on / impersonate each service account
# ==================================================
variable "service_account_iam_bindings" {
  description = <<EOT
Optional IAM bindings ON each Service Account (impersonation / actAs / WIF).

Structure:
service_account_iam_bindings = {
  "<sa_account_id>" = {
    "<binding_key>" = {
      role   = "roles/iam.serviceAccountTokenCreator"
      member = "user:alice@company.com"
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