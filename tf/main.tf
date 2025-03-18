locals {
  network_name = "nt534"
}


module "init_storage_and_images" {
  source = "./common-stuff/kvm/images/ubuntu-server-2204"
}
module "ubuntu_desktop_iso" {
  source = "./common-stuff/kvm/images/ubuntu-desktop-2204"
}




module "network" {
  source          = "./common-stuff/kvm/network"
  network_name    = local.network_name
  network_mode    = "nat"
  network_domain  = "nt534.local"
  network_subnets = ["192.168.99.0/24"]
}


module "squid_proxy_server" {
  source             = "./common-stuff/kvm/vm/ubuntu-server-2204"
  vm_name            = "squid-proxy"
  vm_memory          = 1024
  vm_vcpu            = 2
  vm_network_name    = local.network_name
  vm_network_address = ["192.168.99.10"]
  username           = "ubuntu"
  ssh_key            = file("~/.ssh/id_rsa.pub")
  pool_name            = module.init_storage_and_images.pool_name
  base_volume_id     = module.init_storage_and_images.ubuntu_2204_disk_id
}
module "icap_server" {
  source             = "./common-stuff/kvm/vm/ubuntu-server-2204"
  vm_name            = "icap-server"
  vm_memory          = 4096
  vm_vcpu            = 2
  ssh_key            = file("~/.ssh/id_rsa.pub")
  vm_network_name    = local.network_name
  vm_network_address = ["192.168.99.20"]
  pool_name            = module.init_storage_and_images.pool_name
  base_volume_id     = module.init_storage_and_images.ubuntu_2204_disk_id
}


module "client" {
  source = "./common-stuff/kvm/vm/ubuntu-desktop-2204"
  vm_name = "client"
  vm_memory = 4096
  vm_vcpu = 2
  vm_network_name = local.network_name
  vm_network_address = ["192.168.99.30"]
  hashed_password = "$5$hRSXIy7qauenKl0K$cm53Nh9aeyIvs9/JCF.F8jrS29viTFCLc1f7pZetfW8"
  iso_volume_id = module.ubuntu_desktop_iso.id
}

output "squid_proxy_server_ip" {
  value = module.squid_proxy_server.ip_address
}
output "icap_server_ip" {
  value = module.icap_server.ip_address
}
