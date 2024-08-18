terraform {
  backend "remote" {
    organization = "sikademo"
    workspaces {
      name = "k8s"
    }
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

variable "digitalocean_token" {}
provider "digitalocean" {
  token = var.digitalocean_token
}

variable "cloudflare_api_token" {}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
