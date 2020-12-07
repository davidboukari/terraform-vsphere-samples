resource "vsphere_virtual_machine" "vm" {
  count = "${var.nb_instance}"
  name             = "${var.vm_name}-${var.env}-${count.index}"
  resource_pool_id = "${var.resource_pool_id}"
  datastore_id     = "${var.datastore_id}"

  num_cpus = "${var.num_cpus}"
  memory   = "${var.memory}"
  guest_id = "${var.guest_id}"

  network_interface {
    network_id = "${var.network_id}"
    adapter_type = "${var.network_interface_types}"
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = "${var.template_id}"
    customize {
      linux_options {
        domain    = "vsphere.local"
        host_name = "${var.vm_name}-${terraform.workspace}-${count.index}"
      }
      // To use DHCP, declare an empty network_interface block for each configured interface.
      network_interface {}
    }

  }
}
