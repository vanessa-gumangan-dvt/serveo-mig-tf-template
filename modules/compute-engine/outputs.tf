output "instances" {
  description = "Map of created Compute Engine instances keyed by var.instances key."
  value = {
    for k, vm in google_compute_instance.instances :
    k => {
      name         = vm.name
      id           = vm.id
      self_link    = vm.self_link
      zone         = vm.zone
      machine_type = vm.machine_type
      labels       = vm.labels

      internal_ip = vm.network_interface[0].network_ip

      external_ip = (
        length(vm.network_interface[0].access_config) > 0
        ? vm.network_interface[0].access_config[0].nat_ip
        : null
      )
    }
  }
}