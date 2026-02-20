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
  type = list(string)
}

variable "secret_labels" {
  type        = map(string)
  default     = {}
}

variable "secret_iam_bindings" {
  type = map(map(object({
    role   = string
    member = string
  })))
  default = {}
}


# # ==========================================
# # Cloud Storage Buckets
# # ==========================================
# variable "buckets" {
#   description = "Buckets to create. Key map is used as bucket name, attributes are optional but have proper default values"
#   type = map(object({
#     location      = optional(string, "")
#     storage_class = optional(string, "STANDARD")
#     labels        = optional(map(string), {})
#     force_destroy = optional(bool, false)
#     lifecycle_rules = optional(list(
#       object({
#         action    = any
#         condition = any
#       })
#     ), [])
#     iam_members = optional(list(
#       object({
#         role   = string
#         member = string
#         }
#     )), [])
#     log_bucket = optional(string, null)
#   }))
# }


# # =============================================================================
# # TAGGING CONFIGURATION
# # =============================================================================
# variable "labels" {
#   description = "A map of labels to apply to resources"
#   type        = map(string)
#   default     = {}
# }

