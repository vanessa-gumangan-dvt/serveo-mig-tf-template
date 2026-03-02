resource "google_cloud_run_v2_service" "services" {
  for_each = var.cloud_run_services

  name     = each.value.name
  location = each.value.region
  project  = var.project_id

  labels = merge(each.value.cr_srv_labels, var.labels)

  template {
    containers {
      image = each.value.image

      # Recursos según tipo de servicio
      resources {
        limits = {
          cpu    = each.value.cpu
          memory = each.value.memory
        }
        cpu_idle          = true
        startup_cpu_boost = false
      }

      # Variables de entorno (se pueden agregar después)
      dynamic "env" {
        for_each = each.value.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }

    # Scaling configuration
    scaling {
      min_instance_count = each.value.min_instances
      max_instance_count = each.value.max_instances
    }

    # Timeout para workers (más largo) vs backend
    timeout = each.value.timeout

    # Service account para acceder a GCP resources
    service_account = each.value.service_account

    # VPC Access 
    dynamic "vpc_access" {
      for_each = each.value.vpc_access != null ? [each.value.vpc_access] : []
      content {
        egress = vpc_access.value.egress
        dynamic "network_interfaces" {
          for_each = vpc_access.value.network_interfaces != null ? [vpc_access.value.network_interfaces] : []
          content {
            network    = network_interfaces.value.network
            subnetwork = network_interfaces.value.subnetwork
            tags       = network_interfaces.value.tags
          }
        }
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  ingress = each.value.is_public ? "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER" : "INGRESS_TRAFFIC_INTERNAL_ONLY"
}