# =============================================================================
# GENERAL PROJECT CONFIGURATION
# =============================================================================

# General Project Configuration
env            = "<ENVIRONMENT>"
project_name   = "<PROJECT_NAME>"
project_id     = "<PROJECT_ID>"
project_number = "<PROJECT_NUMBER>"
region         = "<REGION>"

# Common resource labelling
labels = {
  projectname         = "<PROJECT_NAME>"
  projectstatus       = "<PROJECT_STATUS>"
  ownerid             = "<OWNER_ID>"
  owneremail          = "<OWNER_EMAIL>"
  organization        = "serveo"
  businessunit        = "<BUSINESS_UNIT>"
  costcenter          = "<COST_CENTER>"
  environment         = "<ENV>"
  criticality         = "<CRITICALITY>"
  dataclassification  = "<DATA_CLASSIFICATION>"
}

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
  {
    secret_id = "<SECRET_ID_1>"
    secret_labels = {
      description = "<SECRET_DESCRIPTION_1>"
    }
  },
  {
    secret_id = "<SECRET_ID_2>"
    secret_labels = {
      description = "<SECRET_DESCRIPTION_2>"
    }
  }
]

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

# =============================================================================
# BUCKETS
# =============================================================================
buckets = {
  "<BUCKET_NAME_1>" = {
    # Minimal configuration (uses module defaults)
    bucket_labels = {
      description = "<DESCRIPTION>"
    }
  },
  "<BUCKET_NAME_2>" = {
    bucket_labels = {
      description = "<DESCRIPTION>"
    }

    # Optional
    iam_members = [
      {
        role   = "roles/storage.objectViewer"
        member = "group:data@company.com"
      },
      {
        role   = "roles/storage.objectAdmin"
        member = "serviceAccount:sa-ci@project.iam.gserviceaccount.com"
      }
    ]

    # Optional – override default lifecycle
    lifecycle_rules = [
      {
        action = {
          type = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 30
        }
      }
    ]
  }
}



