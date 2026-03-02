# ============================================
# MODULE - IAM
# ============================================
# This file invokes the global IAM module to manage:
# - Project-level IAM roles for users and groups
# - Service Account creation
# - Project-level IAM roles for service accounts
# - IAM bindings ON service accounts (impersonation / WIF / actAs)

module "iam" {
  source = "./modules/iam"

  # Project
  project_id = var.project_id

  # Project IAM for users 
  user_project_roles  = var.user_project_roles

  # Project IAM for groups
  group_project_roles = var.group_project_roles

  # Service Accounts + project roles
  service_accounts = var.service_accounts

  # IAM bindings ON service accounts
  service_account_iam_bindings = var.service_account_iam_bindings
}