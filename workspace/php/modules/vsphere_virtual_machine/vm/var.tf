variable "nb_instance" {
  description = "Nb Instance"
  type = number
}

variable "vm_name" {
  description = "VM Name"
  type = string
}

variable "resource_pool_id" {
  description = "resource_pool_id"
  type = string
}

variable "num_cpus" {
  description = "Nb CPU"
  type = number
}

variable "memory" {
  description = "Memory"
  type = number
}

variable "datastore_id" {
  description = "datastore_id"
  type = string
}

variable "guest_id" {
  description = "guest_id"
  type = string
}

variable "network_id" {
  description = "network_id"
  type = string
}

variable "adapter_type" {
  description = "adapter_type"
  type = string
}

variable "network_interface_types" {
  description = "network_interface_types"
  type = string
}

variable "template_id" {
  description = "template_id"
  type = string
}

variable "env" {
  description = "env"
  type = string
}


