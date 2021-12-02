resource "digitalocean_kubernetes_cluster" "sikademo" {
  name   = "sikademo"
  region = "fra1"
  // Get available versions using: doctl kubernetes options versions
  version = "1.21.5-do.0"

  node_pool {
    name = "sikademo"
    // Get available sizes using: doctl kubernetes options sizes
    size       = "s-4vcpu-8gb"
    node_count = 3
  }
}

resource "digitalocean_loadbalancer" "sikademo" {
  name   = "sikademo"
  region = "fra1"

  droplet_tag = "k8s:${digitalocean_kubernetes_cluster.sikademo.id}"

  healthcheck {
    port     = 30001
    protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 80
    target_port     = 30001
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 443
    target_port     = 30002
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 8080
    target_port     = 30003
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }

  forwarding_rule {
    entry_port      = 25
    target_port     = 30025
    entry_protocol  = "tcp"
    target_protocol = "tcp"
  }
}

output "lb_ip" {
  value = digitalocean_loadbalancer.sikademo.ip
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.sikademo.kube_config.0.raw_config
  sensitive = true
}
