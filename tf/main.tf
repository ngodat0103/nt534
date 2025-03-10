locals {
  network_name = "nt534"
}


module "init_storage_and_images" {
  source = "./modules/tf/kvm/images"
}


module "network" {
  source          = "./modules/tf/kvm/network"
  network_name    = local.network_name
  network_mode    = "nat"
  network_domain  = "nt534.local"
  network_subnets = ["192.168.99.0/24"]
}


module "squid_proxy_server" {
  source             = "./modules/tf/kvm/vm"
  vm_name            = "squid-proxy"
  vm_memory          = 1024
  vm_vcpu            = 2
  vm_network_name    = local.network_name
  vm_network_address = ["192.168.99.10"]
  username           = "ubuntu"
  ssh_key            = file("~/.ssh/id_rsa.pub")
  pool_id            = module.init_storage_and_images.pool_name
  base_volume_id     = module.init_storage_and_images.ubuntu_2204_disk_id
}
module "icap_server" {
  source             = "./modules/tf/kvm/vm"
  vm_name            = "icap-server"
  vm_memory          = 1024
  vm_vcpu            = 2
  ssh_key            = file("~/.ssh/id_rsa.pub")
  vm_network_name    = local.network_name
  vm_network_address = ["192.168.99.20"]
  pool_id            = module.init_storage_and_images.pool_name
  base_volume_id     = module.init_storage_and_images.ubuntu_2204_disk_id
}

output "squid_proxy_server_ip" {
  value = module.squid_proxy_server.ip_address
}
output "icap_server_ip" {
  value = module.icap_server.ip_address
}
