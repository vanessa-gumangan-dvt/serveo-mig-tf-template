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
  projectname        = "<PROJECT_NAME>"
  projectstatus      = "<PROJECT_STATUS>"
  ownerid            = "<OWNER_ID>"
  owneremail         = "<OWNER_EMAIL>"
  organization       = "serveo"
  businessunit       = "<BUSINESS_UNIT>"
  costcenter         = "<COST_CENTER>"
  environment        = "<ENV>"
  criticality        = "<CRITICALITY>"
  dataclassification = "<DATA_CLASSIFICATION>"
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

  "<GROUP_EMAIL_2>" = [
    "roles/<ROLE_1>",
    "roles/<ROLE_2>"
  ]
}

# =============================================================================
# IAM - SERVICE ACCOUNT (create + grant roles + add SA binding)
# =============================================================================

service_accounts = {
  "<SERVICE_ACCOUNT_ID_1>" = {
    display_name = "<DISPLAY_NAME>"
    description  = "<DESCRIPTION>"
    project_roles = [
      "roles/<ROLE_1>",
      "roles/<ROLE_2>"
    ]
  }

  "<SERVICE_ACCOUNT_ID_2>" = {
    display_name = "<DISPLAY_NAME>"
    description  = "<DESCRIPTION>"
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
# CLOUD STORAGE BUCKETS
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
          type          = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 30
        }
      }
    ]
  }
}

# =============================================================================
# ARTIFACT REGISTRY REPOSITORIES
# =============================================================================
artifact_registry_repositories = {
  "<REPOSITORY_KEY_1>" = {
    repository_id = "<REPOSITORY_ID_1>"
    description   = "<DESCRIPTION_1>"
    format        = "<FORMAT_1>" # DOCKER | MAVEN | NPM | PYTHON | APT | YUM

    ar_labels = {
      description = "<DESCRIPTION>"
    }
  }

  "<REPOSITORY_KEY_2>" = {
    repository_id = "<REPOSITORY_ID_2>"
    description   = "<DESCRIPTION_2>"
    format        = "<FORMAT_2>"

    ar_labels = {
      description = "<DESCRIPTION>"
    }
  }
}

# =============================================================================
# CLOUD RUN SERVICES
# =============================================================================
cloud_run_services = {

  "<SERVICE_KEY_1>" = {
    name   = "<CLOUD_RUN_SERVICE_NAME_1>"
    region = "<REGION>"  # e.g. europe-west1
    image  = "<REGION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY>/<IMAGE>:<TAG>"

    cpu    = "<CPU>"     # e.g. "1", "2"
    memory = "<MEMORY>"  # e.g. "512Mi", "1Gi"

    min_instances = <MIN_INSTANCES>  # e.g. 0
    max_instances = <MAX_INSTANCES>  # e.g. 3

    timeout = "<TIMEOUT>"  # e.g. "300s"

    is_public       = <TRUE_OR_FALSE>
    service_account = "<SERVICE_ACCOUNT_EMAIL>"

    env_vars = {
      "<ENV_VAR_KEY_1>" = "<ENV_VAR_VALUE_1>"
      "<ENV_VAR_KEY_2>" = "<ENV_VAR_VALUE_2>"
    }

    # Opcional - VPC Access
    vpc_access = {
      egress = "<EGRESS_MODE>" # ALL_TRAFFIC | PRIVATE_RANGES_ONLY

      network_interfaces = {
        network    = "<VPC_NETWORK_NAME>"
        subnetwork = "<SUBNETWORK_NAME>"
        tags       = ["<TAG_1>", "<TAG_2>"]
      }
    }

    cr_srv_labels = {
      application = "<APPLICATION_NAME>"
      component   = "<COMPONENT_NAME>"
    }
  }


  "<SERVICE_KEY_2>" = {
    name   = "<CLOUD_RUN_SERVICE_NAME_2>"
    region = "<REGION>"
    image  = "<REGION>-docker.pkg.dev/<PROJECT_ID>/<REPOSITORY>/<IMAGE>:<TAG>"

    cpu    = "<CPU>"
    memory = "<MEMORY>"

    min_instances = <MIN_INSTANCES>
    max_instances = <MAX_INSTANCES>

    timeout = "<TIMEOUT>"

    is_public       = <TRUE_OR_FALSE>
    service_account = "<SERVICE_ACCOUNT_EMAIL>"

    env_vars = {}

    # Sin VPC access
    vpc_access = null

    cr_srv_labels = {
      application = "<APPLICATION_NAME>"
      component   = "<COMPONENT_NAME>"
    }
  }

}