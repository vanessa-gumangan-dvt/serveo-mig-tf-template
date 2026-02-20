# =============================================================================
# GENERAL PROJECT CONFIGURATION
# =============================================================================

# General Project Configuration
env            = "<ENVIRONMENT>"
project_name   = "<PROJECT_NAME>"
project_id     = "<PROJECT_ID>"
project_number = "<PROJECT_NUMBER>"
region         = "<REGION>"

# =============================================================================
# IAM - USER (grant roles)
# =============================================================================

user_project_roles = {
  "<USER_EMAIL_1>" = [
    "roles/<ROLE_1>",
    "roles/<ROLE_2>"
  ]

  "<USER_EMAIL_2>" = [
    "roles/<ROLE_1>"
  ]
}

# =============================================================================
# IAM - GROUP (grant roles)
# =============================================================================

group_project_roles = {
  "<GROUP_EMAIL_1>" = [
    "roles/<ROLE_1>"
  ]

  "<GROUP_EMAIL_2>"  = [
    "roles/<ROLE_1>",
    "roles/<ROLE_2>"
  ]
}

# =============================================================================
# IAM - SERVICE ACCOUNT (create + grant roles + add SA binding)
# =============================================================================

service_accounts = {
  "<SERVICE_ACCOUNT_ID_1>" = {
    display_name  = "<DISPLAY_NAME>"
    description   = "<DESCRIPTION>"
    project_roles = [
      "roles/<ROLE_1>",
      "roles/<ROLE_2>"
    ]
  }

  "<SERVICE_ACCOUNT_ID_2>" = {
    display_name  = "<DISPLAY_NAME>"
    description   = "<DESCRIPTION>"
    project_roles = [
      "roles/<ROLE_1>",
      "roles/<ROLE_2>"
    ]
  }
}

# Optional: IAM bindings ON service accounts
service_account_iam_bindings = {
  "<SERVICE_ACCOUNT_ID_1>" = {
    "<BINDING_KEY_1>" = {
      role   = "roles/<SERVICE_ACCOUNT_ROLE>"
      member = "user:<USER_EMAIL>"
    }

    "<BINDING_KEY_2>" = {
      role   = "roles/<SERVICE_ACCOUNT_ROLE>"
      member = "group:<GROUP_EMAIL>"
    }

    "<BINDING_KEY_3>" = {
      role   = "roles/<SERVICE_ACCOUNT_ROLE>"
      member = "serviceAccount:<OTHER_SERVICE_ACCOUNT_EMAIL>"
    }
  }

  "<SERVICE_ACCOUNT_ID_2>" = {
    "<BINDING_KEY_1>" = {
      role   = "roles/<SERVICE_ACCOUNT_ROLE>"
      member = "user:<USER_EMAIL>"
    }
  }
}



# =============================================================================
# SECRET MANAGER 
# =============================================================================

secrets = [
  "<SECRET_ID_1>",
  "<SECRET_ID_2>"
]

secret_labels = {
  description       = "<DESCRIPTION>"
  dataclassification = "<DATA_CLASSIFICATION>"
}

secret_iam_bindings = {
  "<SECRET_ID_1>" = {
    "<BINDING_KEY_1>" = {
      role   = "roles/<SECRET_ROLE>"
      member = "user:<USER_EMAIL>"
    }

    "<BINDING_KEY_2>" = {
      role   = "roles/<SECRET_ROLE>"
      member = "group:<GROUP_EMAIL>"
    }
  }

  "<SECRET_ID_2>" = {
    "<BINDING_KEY_1>" = {
      role   = "roles/<SECRET_ROLE>"
      member = "group:<GROUP_EMAIL>"
    }
  }
}





# # =============================================================================
# # TAGGING CONFIGURATION
# # =============================================================================
# labels = {
#   projectname   = "plataformadeldato"
#   projectstatus = "en_proyecto"
#   ownerid       = "f1079"
#   owneremail    = "ogimenez_at_serveo_dot_com"
#   organization  = "serveo"
#   businessunit  = "sistemas"
#   costcenter    = "sn640is10"
#   criticality   = "high"
#   environment   = "test"
# }


# # =============================================================================
# # CLOUD STORAGE BUCKETS
# # =============================================================================
# buckets = {
#   # "bucket-example-with-non-default-attrs" = {
#   #   "storage_class" = "NEARLINE"
#   #   "iam_members" = [
#   #     {
#   #       "role" = "roles/storage.objectAdmin"
#   #       "member" = "user:example-member@serveo.com"
#   #     }
#   #   ]
#   # }
#   "exports" = {
#     labels = {
#       dataclassification = "public"
#       description        = "bucket-exports"
#     }
#   },
#   "cf-code" = {
#     labels = {
#       dataclassification = "public"
#       description        = "bucket-cf-code"
#     }
#   }
# }
