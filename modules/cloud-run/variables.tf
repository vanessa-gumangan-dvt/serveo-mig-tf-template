variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
}

variable "cloud_run_services" {
  description = "Mapa de servicios Cloud Run a crear"
  type = map(object({
    name            = string
    region          = string
    image           = string
    cpu             = string
    memory          = string
    min_instances   = number
    max_instances   = number
    timeout         = string
    is_public       = bool
    service_account = string
    env_vars        = map(string)
    vpc_access = optional(object({
      network_interfaces = optional(object({
        network    = string
        subnetwork = string
        tags       = optional(list(string), [])
      }))
      egress = optional(string, "ALL_TRAFFIC")
    }))
    cr_srv_labels = map(string)
  }))
}

variable "labels" {
  description = "A map of labels to be applied to all Cloud Run services"
  type        = map(string)
  default     = {}
}