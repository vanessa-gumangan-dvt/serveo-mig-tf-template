output "secrets" {
  description = "Secrets created by this module, keyed by secret_id."
  value = {
    for secret_id, s in google_secret_manager_secret.secrets :
    secret_id => {
      id        = s.id
      name      = s.name
      secret_id = s.secret_id
      project   = s.project
    }
  }
}

output "secret_iam_bindings_applied" {
  description = "IAM bindings applied on secrets (role + member)."
  value = [
    for b in google_secret_manager_secret_iam_member.secret_iam : {
      secret_id = b.secret_id
      role      = b.role
      member    = b.member
    }
  ]
}