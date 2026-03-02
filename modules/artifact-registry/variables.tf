variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region where repositories will be created"
  type        = string
}

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

variable "labels" {
  description = "A map of labels to be applied to all repositories"
  type        = map(string)
  default     = {}
}