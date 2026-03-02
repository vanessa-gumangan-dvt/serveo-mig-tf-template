output "bucket" {
  description = "The created storage bucket full attributes"
  value       = module.bucket.bucket
}

output "name" {
  description = "Bucket name."
  value       = module.bucket.name
}

output "url" {
  description = "Bucket URL."
  value       = module.bucket.url
}
