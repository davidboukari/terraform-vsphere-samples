provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "dc-toison-1"
}

data "vsphere_datastore" "datastore" {
  name          = "disk1T"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster-dijon-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "resource-pool-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name = "template-centos7-podman"
  datacenter_id = data.vsphere_datacenter.dc.id
}

module "vsphere_virtual_machine_vm" {
  nb_instance = "${var.nb_instance}"
  vm_name = "${var.vm_name}"
  env = "${terraform.workspace}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = "${var.num_cpus}"
  memory = "${var.memory}"
  guest_id = data.vsphere_virtual_machine.template.guest_id
  network_id = data.vsphere_network.network.id
  adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  template_id =   data.vsphere_virtual_machine.template.id
  network_interface_types =   data.vsphere_virtual_machine.template.network_interface_types[0]
  source = "./modules/vsphere_virtual_machine/vm"
  
}

#resource "vsphere_virtual_machine" "vm" {
#  count = var.nb_instance
#  name             = "${var.vm_name}-${terraform.workspace}-${count.index}"
#  resource_pool_id = data.vsphere_resource_pool.pool.id
#  #resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
#  datastore_id     = data.vsphere_datastore.datastore.id
#
#  num_cpus = 2
#  memory   = 1024
#  guest_id = data.vsphere_virtual_machine.template.guest_id
#
#  network_interface {
#    network_id = data.vsphere_network.network.id
#    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
#  }
#
#  disk {
#    label = "disk0"
#    size  = 20
#  }
#
#  clone {
#    template_uuid = data.vsphere_virtual_machine.template.id
#    customize {
#      linux_options {
#        domain    = "vsphere.local"
#        host_name = "${var.vm_name}-${terraform.workspace}-${count.index}"
#      }
#      // To use DHCP, declare an empty network_interface block for each configured interface.
#      network_interface {}
#    }
#  
#  }
#}
