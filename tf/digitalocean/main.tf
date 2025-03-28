module "network" {
  source   = "./network"
  ip_range = "192.168.30.0/24"
}
resource "digitalocean_ssh_key" "akira-ssh-key" {
  name       = "akira-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWVKmEpsCNbXXWgxHV1Olj9qr2/dYZzpprUD4ZO6TUUSQtqtP/g4UBCc5qaz3ajPYhE9XW8trMudAJAj9qLv02iW3pkG2dLCy8uFVtoAMS6uPcINAo2+C9mzzCAVxmPD61C1o5VyX0ogpFGX9y6J4xWTooI6n8eMr87ovcClY0Mubb7vSq+W+4UI+OTKYjot3YuEGF+WOyP5w9LM0cVl7E7vkPfG4Xd73dpjPUfEY06OE/vkwBpjuqcd/jU/EPqnjs/TvNmcUufcBFtgQMtd5YqjiizT8fAcYxOUXqRW5Hc9PvRL/dvlKfSGn3ewi2itMroFQv57rsTb0lkY3/VIo+1aDtFgAYzIfZ0Z6vAsMieBwwAFlIsjomLrWlefaAbvEGLDD2mvrMkWSIg/Ync7M8+z+rv7dd8uo9d3F3GX+GflOe0YsCkCgs3oOirSmgKgwxjLEhPzW8OqSspGIikbOoE1oHwqzEQj2zSBxnC4d6V8DvJWgqnBz/8LmPdpwWAZc= akira@legion5"
}


resource "digitalocean_droplet" "squid-proxy-server" {
  image    = "ubuntu-22-04-x64"
  name     = "squid-proxy-server"
  region   = "sgp1"
  size     = "s-2vcpu-4gb"
  backups  = false
  vpc_uuid = module.network.id
  ssh_keys = [digitalocean_ssh_key.akira-ssh-key.fingerprint]
}

resource "digitalocean_project" "nt534-lab" {
  name        = "nt534-lab"
  description = "Playground for nt534 coursework"
  purpose     = "Education purpose about security"
  environment = "Development"
  resources   = [digitalocean_droplet.squid-proxy-server.urn]
}
