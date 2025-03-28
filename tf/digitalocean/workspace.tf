terraform {
  cloud {

    organization = "akira-homelab"

    workspaces {
      name = "digital-ocean-cli"
    }
  }
}