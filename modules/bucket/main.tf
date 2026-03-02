locals {
  # Default configuration
  default_lifecycle_rule = [{
    # Keep live object and two previous versions for 90 days (1 previous version indefinitely)
    action = {
      type = "Delete"
    }
    condition = {
      age                = 90
      with_state         = "ARCHIVED"
      num_newer_versions = 2
    }
  }]
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 4.0"

  name          = var.bucket_name
  project_id    = var.project_id
  location      = var.location
  storage_class = var.storage_class

  # Policies
  versioning               = true
  force_destroy            = var.force_destroy
  bucket_policy_only       = true
  retention_policy         = null
  public_access_prevention = "enforced"
  lifecycle_rules          = length(var.lifecycle_rules) > 0 ? var.lifecycle_rules : local.default_lifecycle_rule

  # IAM members and roles
  iam_members = var.iam_members

  # Logging
  log_bucket        = var.log_bucket
  log_object_prefix = "${var.project_id}/${var.bucket_name}/"

  # Encryption
  # Note: use only if KMS support is enabled in the project
  encryption = (var.encryption_key != null ?
    {
      default_kms_key_name = var.encryption_key
    }
    : null
  )

  # Labels
  labels = var.labels
}

