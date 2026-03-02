resource "google_compute_instance" "instances" {
  for_each = var.vm_instances

  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone
  project      = var.project_id

  labels = merge(var.labels, each.value.vm_labels)

  boot_disk {
    initialize_params {
      image = each.value.image
      size  = each.value.disk_size_gb
      type  = each.value.disk_type
    }
  }

  network_interface {
    network    = each.value.network
    subnetwork = each.value.subnetwork

    dynamic "access_config" {
      for_each = each.value.assign_public_ip ? [1] : []
      content {}
    }
  }

  service_account {
    email  = each.value.service_account
    scopes = ["cloud-platform"]
  }
}