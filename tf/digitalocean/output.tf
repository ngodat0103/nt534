output "squid-proxy-server-ip" {
  value = digitalocean_droplet.squid-proxy-server.ipv4_address
}