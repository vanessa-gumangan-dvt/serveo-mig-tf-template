module "artifact_registry" {
  source                         = "./modules/artifact-registry"
  project_id                     = var.project_id
  region                         = var.region
  artifact_registry_repositories = var.artifact_registry_repositories
  labels                         = var.labels
}
