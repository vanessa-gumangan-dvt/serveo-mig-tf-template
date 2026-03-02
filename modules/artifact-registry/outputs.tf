output "repositories" {
  description = "Map of created repositories (keyed by var.repositories keys)."
  value = {
    for k, r in google_artifact_registry_repository.repos :
    k => {
      id            = r.id
      name          = r.name
      repository_id = r.repository_id
      location      = r.location
      format        = r.format
      labels        = r.labels
    }
  }
}