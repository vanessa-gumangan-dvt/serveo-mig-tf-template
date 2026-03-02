module "buckets" {
  source   = "./modules/bucket"
  for_each = var.buckets

  bucket_name     = each.key
  location        = length(each.value.location) > 0 ? each.value.location : var.region
  storage_class   = each.value.storage_class
  labels          = merge(each.value.bucket_labels, var.labels)
  force_destroy   = each.value.force_destroy
  lifecycle_rules = each.value.lifecycle_rules

  project_id   = var.project_id
  project_name = var.project_name
  environment  = var.environment

  iam_members = each.value.iam_members
  log_bucket  = each.value.log_bucket
}
