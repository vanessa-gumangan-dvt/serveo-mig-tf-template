resource "google_artifact_registry_repository" "repos" {
  # Key = repository_id (or any stable key you choose in tfvars)
  for_each = var.artifact_registry_repositories

  project       = var.project_id
  location      = var.region
  repository_id = each.value.repository_id
  description   = each.value.description
  format        = each.value.format

  labels = merge(each.value.ar_labels, var.labels)
}