output "service_uris" {
  description = "Map of service URIs keyed by var.services key."
  value = {
    for k, s in google_cloud_run_v2_service.services :
    k => s.uri
  }
}

output "service_ids" {
  description = "Map of Terraform resource IDs keyed by var.services key."
  value = {
    for k, s in google_cloud_run_v2_service.services :
    k => s.id
  }
}