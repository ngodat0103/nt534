 
 terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
 
 resource "digitalocean_vpc" "default" {
  name     = "nt534-lab"
  region   = "sgp1"
  ip_range = var.ip_range
}