# ============================================
# Module: Secret Manager - Secrets + IAM
# ============================================
# This module creates Secret Manager secrets (containers only).
# Secret payload/versions are expected to be uploaded manually in GCP.
#
# It also optionally manages IAM bindings on each secret to control
# who can access or administer it.

# --------------------------------------------
# Secrets (containers only)
# --------------------------------------------
resource "google_secret_manager_secret" "secrets" {
  for_each = {
    for s in var.secrets : s.secret_id => s
  }
  
  secret_id = each.value.secret_id
  project   = var.project_id

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  labels = merge(each.value.secret_labels, var.labels)
}

# --------------------------------------------
# Secret IAM bindings (optional)
# --------------------------------------------
locals {
  # Flatten:
  # secret_iam_bindings = {
  #   "<SECRET_ID>" = {
  #     "<BINDING_KEY>" = { role = "...", member = "group:..." }
  #   }
  # }
  # into a stable map for for_each.
  secret_iam_binding_pairs = merge([
    for secret_id, bindings in var.secret_iam_bindings : {
      for binding_key, b in bindings :
      "${secret_id}-${binding_key}" => {
        secret_id = secret_id
        role      = b.role
        member    = b.member
      }
    }
  ]...)
}

resource "google_secret_manager_secret_iam_member" "secret_iam" {
  for_each = local.secret_iam_binding_pairs

  # Use the secret resource ID created in this module
  secret_id = google_secret_manager_secret.secrets[each.value.secret_id].id
  role      = each.value.role
  member    = each.value.member
}