# =============================================================================
# GENERAL PROJECT CONFIGURATION
# =============================================================================
variable "project_id" {
  type = string
}

variable "project" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_number" {
  type = string
}

variable "environment" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "labels" {
  description = "A map of labels to apply to resources"
  type        = map(string)
  default     = {}
}

# =============================================================================
#  IAM
# =============================================================================

variable "user_project_roles" {
  type    = map(list(string))
  default = {}
}

variable "group_project_roles" {
  type    = map(list(string))
  default = {}
}

variable "service_accounts" {
  type = map(object({
    display_name  = string
    description   = optional(string)
    project_roles = list(string)
  }))
  default = {}
}

variable "service_account_iam_bindings" {
  type = map(map(object({
    role   = string
    member = string
  })))
  default = {}
}

# =============================================================================
#  SECRETS
# =============================================================================
variable "secrets" {
  type = list(object({
    secret_id     = string
    secret_labels = map(string)
  }))
}

variable "secret_iam_bindings" {
  type = map(map(object({
    role   = string
    member = string
  })))
  default = {}
}


# ==========================================
# CLOUD STORAGE BUCKETS
# ==========================================
variable "buckets" {
  description = "Buckets to create. Key map is used as bucket name, attributes are optional but have proper default values"
  type = map(object({
    location      = optional(string, "")
    storage_class = optional(string, "STANDARD")
    bucket_labels = optional(map(string), {})
    force_destroy = optional(bool, false)
    lifecycle_rules = optional(list(
      object({
        action    = any
        condition = any
      })
    ), [])
    iam_members = optional(list(
      object({
        role   = string
        member = string
        }
    )), [])
    log_bucket = optional(string, null)
  }))
}

# ==========================================
# ARTIFACT REGISTRY REPOSITORIES
# ==========================================
variable "artifact_registry_repositories" {
  description = <<EOT
Artifact Registry repositories to create.

Example:
repositories = {
  "backend" = {
    repository_id = "backend-docker"
    description   = "Backend Docker images"
    format        = "DOCKER"
    labels        = { environment = "dev" }
  }
}
EOT

  type = map(object({
    repository_id = string
    description   = string
    format        = string
    ar_labels     = map(string)
  }))
}

# ==========================================
# CLOUD RUN SERVICES
# ==========================================
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

# ==========================================
# COMPUTE ENGINE INSTANCES
# ==========================================
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