# ============================================
# MODULE - SECRET MANAGER 
# ============================================
# This file invokes the Secret Manager module to:
# - Create secrets (containers only)
# - Optionally apply IAM bindings on secrets

module "secret_manager" {
  source = "./modules/secret-manager"

  project_id = var.project_id
  region     = var.region

  secrets = var.secrets
  labels  = var.labels

  # Optional: IAM bindings ON secrets
  secret_iam_bindings = var.secret_iam_bindings
}