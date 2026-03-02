module "cloud_run" {
  source = "./modules/cloud-run"

  project_id         = var.project_id
  cloud_run_services = var.cloud_run_services

  # Common labels applied to all services (merged with cr_srv_labels inside the module)
  labels = var.labels
}