# ============================================
# Outputs
# ============================================

output "service_accounts" {
  description = "Service Accounts created by this module, keyed by account_id."
  value = {
    for sa_key, sa in google_service_account.service_accounts :
    sa_key => {
      email     = sa.email
      name      = sa.name
      unique_id = sa.unique_id
    }
  }
}

output "user_project_bindings" {
  description = "Project-level IAM bindings applied for users."
  value = [
    for b in google_project_iam_member.user_project_roles : {
      project = b.project
      role    = b.role
      member  = b.member
    }
  ]
}

output "group_project_bindings" {
  description = "Project-level IAM bindings applied for groups."
  value = [
    for b in google_project_iam_member.group_project_roles : {
      project = b.project
      role    = b.role
      member  = b.member
    }
  ]
}

output "service_account_project_bindings" {
  description = "Project-level IAM bindings applied for service accounts created by this module."
  value = [
    for b in google_project_iam_member.sa_project_roles : {
      project = b.project
      role    = b.role
      member  = b.member
    }
  ]
}

output "service_account_iam_bindings_applied" {
  description = "IAM bindings applied ON service accounts (impersonation / actAs / WIF)."
  value = [
    for b in google_service_account_iam_member.sa_iam_bindings : {
      service_account_id = b.service_account_id
      role               = b.role
      member             = b.member
    }
  ]
}