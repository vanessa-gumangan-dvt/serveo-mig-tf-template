variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "vm_instances" {
  description = "Compute Engine instances to create"
  type = map(object({
    name                = string
    zone                = string
    machine_type        = string
    image               = string
    disk_size_gb        = number
    disk_type           = string
    network             = string
    subnetwork          = string
    assign_public_ip    = bool
    service_account     = string
    vm_labels           = map(string) 
  }))
}

variable "labels" {
  description = "A map of labels to be applied to all Compute Engine instances"
  type        = map(string)
  default     = {}
}