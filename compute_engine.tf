module "compute_engine" {
  source = "./modules/compute-engine"

  project_id    = var.project_id

  # Labels (merge of common labels with vm labels)
  labels = var.labels

  # Map of VMs to create
  vm_instances = var.vm_instances
}