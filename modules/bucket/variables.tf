## Variables

variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "ID of the project where the resources will be created"
  type        = string
}

variable "project_name" {
  description = "Name of the project where the resources will be created (without prefixes)"
  type        = string
}

variable "environment" {
  description = "Environment where the resources will be provisioned."
  type        = string

  validation {
    condition     = contains(["prod", "dev", "test", "lab"], var.environment)
    error_message = "The environment value must be one of the following: prod, dev, test, lab"
  }
}

variable "location" {
  description = "The location of the bucket."
  type        = string
  default     = "europe-west1"
}

variable "storage_class" {
  description = "The Storage Class of the new bucket."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Validation: storage class must be one of: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = null
}

variable "iam_members" {
  description = "The list of IAM members to grant permissions on the bucket."
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects when set to true. If this value is set to false and you try to delete a bucket that contains objects, Terraform will fail."
  type        = bool
  default     = false
}

variable "encryption_key" {
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket"
  type        = string
  default     = null
}

variable "lifecycle_rules" {
  description = "The bucket's Lifecycle Rules configuration."
  type = list(object({
    # Object with keys:
    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.
    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.
    action = any

    # Object with keys:
    # - age - (Optional) Minimum age of an object in days to satisfy this condition.
    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".
    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.
    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    condition = any
  }))
  default = [{
    # Keep live object and two previous versions for 90 days (1 previous version indefinitely)
    action = {
      type = "Delete"
    }
    condition = {
      age                = 90
      with_state         = "ARCHIVED"
      num_newer_versions = 2
    }
  }]
}

variable "log_bucket" {
  description = "The bucket that will receive log objects."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name"
  type        = string
  default     = null
}
