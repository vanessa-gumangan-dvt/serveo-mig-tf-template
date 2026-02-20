# ============================================
# Module: Global IAM (Project + Service Accounts)
# ============================================
# This module manages:
# - Project-level IAM roles for users
# - Project-level IAM roles for groups
# - Creation of service accounts
# - Project-level IAM roles for service accounts
# - IAM bindings ON service accounts (impersonation / actAs / WIF)
#
# Notes:
# - Uses google_*_iam_member resources (granular) to reduce the risk of overwriting
#   IAM managed elsewhere.
# - Expects user/group identifiers as emails (without the "user:" / "group:" prefix).
# - Expects service account keys to match the service account account_id.

# --------------------------------------------
# Service Accounts (creation)
# --------------------------------------------
resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts

  project      = var.project_id
  account_id   = each.key
  display_name = each.value.display_name
  description  = try(each.value.description, null)
}

# --------------------------------------------
# Project-level IAM roles for Users
# --------------------------------------------
locals {
  # Flatten users x roles into a stable map for for_each
  user_project_role_pairs = merge([
    for user_email, roles in var.user_project_roles : {
      for role in roles :
      "user-${user_email}-${role}" => {
        role   = role
        member = "user:${user_email}"
      }
    }
  ]...)
}

resource "google_project_iam_member" "user_project_roles" {
  for_each = local.user_project_role_pairs

  project = var.project_id
  role    = each.value.role
  member  = each.value.member
}

# --------------------------------------------
# Project-level IAM roles for Groups
# --------------------------------------------
locals {
  # Flatten groups x roles into a stable map for for_each
  group_project_role_pairs = merge([
    for group_email, roles in var.group_project_roles : {
      for role in roles :
      "group-${group_email}-${role}" => {
        role   = role
        member = "group:${group_email}"
      }
    }
  ]...)
}

resource "google_project_iam_member" "group_project_roles" {
  for_each = local.group_project_role_pairs

  project = var.project_id
  role    = each.value.role
  member  = each.value.member
}

# --------------------------------------------
# Project-level IAM roles for Service Accounts
# (What each SA can do in the project)
# --------------------------------------------
locals {
  # Flatten service_accounts x project_roles into a stable map for for_each
  sa_project_role_pairs = merge([
    for sa_key, sa in var.service_accounts : {
      for role in sa.project_roles :
      "sa-${sa_key}-${role}" => {
        sa_key = sa_key
        role   = role
      }
    }
  ]...)
}

resource "google_project_iam_member" "sa_project_roles" {
  for_each = local.sa_project_role_pairs

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.service_accounts[each.value.sa_key].email}"
}

# --------------------------------------------
# IAM bindings ON Service Accounts (optional)
# (Who can impersonate / actAs / federate into the SA)
# --------------------------------------------
locals {
  # Flatten:
  # service_account_iam_bindings = {
  #   "<sa_account_id>" = {
  #     "<binding_key>" = { role = "...", member = "user:..." }
  #   }
  # }
  # into a stable map for for_each
  sa_iam_binding_pairs = merge([
    for sa_key, bindings in var.service_account_iam_bindings : {
      for binding_key, b in bindings :
      "sa-iam-${sa_key}-${binding_key}" => {
        sa_key = sa_key
        role   = b.role
        member = b.member
      }
    }
  ]...)
}

resource "google_service_account_iam_member" "sa_iam_bindings" {
  for_each = local.sa_iam_binding_pairs

  # Use the full resource name of the SA created in this module
  service_account_id = google_service_account.service_accounts[each.value.sa_key].name
  role               = each.value.role
  member             = each.value.member
}